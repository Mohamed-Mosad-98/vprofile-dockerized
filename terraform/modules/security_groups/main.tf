############################################
# ALB Security Group
############################################

resource "aws_security_group" "alb" {

  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Security Group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-alb-sg"
    }
  )

}

############################################
# EC2 Security Group
############################################

resource "aws_security_group" "ec2" {

  name        = "${var.project_name}-${var.environment}-ec2-sg"
  description = "Security Group for Docker Host"
  vpc_id      = var.vpc_id

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = [
      var.ssh_allowed_cidr
    ]

  }

  ingress {

    description = "Application 8080"

    from_port = 8080
    to_port   = 8080

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]

  }

  ingress {

    description = "Application 8081"

    from_port = 8081
    to_port   = 8081

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2-sg"
    }
  )

}