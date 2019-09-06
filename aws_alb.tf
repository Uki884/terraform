#ALB作成
resource "aws_alb" "alb" {
  name                       = "${var.app_name}-alb"
  security_groups            = ["${aws_security_group.alb_sg.id}"]
  subnets                    = ["${aws_subnet.vpc_main-public-subnet1.id}","${aws_subnet.vpc_main-public-subnet2.id}"]
  internal                   = false
  enable_deletion_protection = false
}
#ALBターゲットグループ
resource "aws_alb_target_group" "alb-http" {
  name     = "${var.app_name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc_main.id}"
  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}
resource "aws_alb_target_group" "alb-https" {
  name     = "${var.app_name}-target-group-https"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.vpc_main.id}"
  health_check {
    interval            = 30
    path                = "/login"
    port                = 443
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}
#ALBにターゲットグループ紐付け
#HTTP
resource "aws_alb_target_group_attachment" "alb-http" {
  target_group_arn = "${aws_alb_target_group.alb-http.arn}"
  target_id        = "${aws_instance.ec2.id}"
  port             = 80
}
#HTTPS
resource "aws_alb_target_group_attachment" "alb-https" {
  target_group_arn = "${aws_alb_target_group.alb-https.arn}"
  target_id        = "${aws_instance.ec2.id}"
  port             = 443
}

#リスナー追加
#HTTP
resource "aws_alb_listener" "alb-http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    target_group_arn = "${aws_alb_target_group.alb-http.arn}"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
#HTTPS
resource "aws_alb_listener" "alb-https" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.certificate_arn}"
  default_action {
    target_group_arn = "${aws_alb_target_group.alb-http.arn}"
    type             = "forward"
  }
}

#rules

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = "${aws_alb_listener.alb-http.arn}"

  action {
    type = "redirect"
    target_group_arn = "${aws_alb_target_group.alb-http.arn}"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    field  = "path-pattern"
    values = ["*"]
  }
}
