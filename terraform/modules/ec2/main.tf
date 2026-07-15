############################################
# Ubuntu 22.04 AMI
############################################

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

############################################
# EC2 Docker Host
############################################

resource "aws_instance" "docker_host" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = var.private_subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  key_name = var.key_name

  associate_public_ip_address = false

  user_data = templatefile(
    "${path.root}/userdata/userdata.sh",
    {
      github_repo       = var.github_repo
      db_password       = var.db_password
      rabbitmq_user     = var.rabbitmq_user
      rabbitmq_password = var.rabbitmq_password
    }
  )

  root_block_device {

    volume_size = 20

    volume_type = "gp3"

  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-docker-host"
    }
  )

}