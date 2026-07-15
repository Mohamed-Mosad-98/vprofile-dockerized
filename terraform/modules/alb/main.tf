############################################
# Application Load Balancer
############################################

resource "aws_lb" "this" {

  name = "${var.project_name}-${var.environment}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    var.alb_security_group_id
  ]

  subnets = var.public_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-alb"
    }
  )

}

############################################
# Java Target Group
############################################

resource "aws_lb_target_group" "java" {

  name = "${var.project_name}-${var.environment}-java"

  port     = 8080
  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {

    enabled = true

    path = "/login"

    protocol = "HTTP"

    matcher = "200"

  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-java-tg"
    }
  )

}

############################################
# Nginx Target Group
############################################

resource "aws_lb_target_group" "nginx" {

  name = "${var.project_name}-${var.environment}-nginx"

  port     = 8081
  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {

    enabled = true

    path = "/"

    protocol = "HTTP"

    matcher = "200"

  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-nginx-tg"
    }
  )

}

############################################
# Register EC2 in Java Target Group
############################################

resource "aws_lb_target_group_attachment" "java" {

  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.java.arn

  target_id = var.instance_ids[count.index]

  port = 8080

}

############################################
# Register EC2 in Nginx Target Group
############################################

resource "aws_lb_target_group_attachment" "nginx" {

  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.nginx.arn

  target_id = var.instance_ids[count.index]

  port = 8081

}

############################################
# HTTP Listener
############################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.java.arn

  }

}

############################################
# /static/* Rule
############################################

resource "aws_lb_listener_rule" "static" {

  listener_arn = aws_lb_listener.http.arn

  priority = 10

  action {

    type = "forward"

    target_group_arn = aws_lb_target_group.nginx.arn

  }

  condition {

    path_pattern {

      values = [
        "/second/*"
      ]


    }

  }

}