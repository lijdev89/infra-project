#-----------------------------
#Keypair Creation
#-----------------------------
resource "aws_key_pair" "auth_key" {
  key_name   = "${var.project_name}-${var.project_env}"
  public_key = file("ssh-key.pub")
  tags = {
    Name = "${var.project_name}-${var.project_env}"
  }

}

#-----------------------------
#VPC creation
#------------------------------
resource "aws_security_group" "ubereats" {
  name        = "${var.project_name}-${var.project_env}-frontend"
  description = "demo security group"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.project_name}-${var.project_env}-frontend"
  }
}

#-----------------------------
#SG creation
#-----------------------------
resource "aws_security_group_rule" "prod_rule" {
  for_each    = toset(var.frontend-sg-ports)
  type        = "ingress"
  from_port   = each.key
  to_port     = each.key
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ubereats.id
}

#------------------------------------------
#Creating EC2 instance
#------------------------------------------
resource "aws_instance" "frontend" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.auth_key.key_name
  user_data              = file("setup.sh")
  vpc_security_group_ids = [aws_security_group.ubereats.id]
  tags = {
    Name = "${var.project_name}-${var.project_env}-frontend"
  }
}

#------------------------------------------
#Creating route53 in new branch
#------------------------------------------

resource "aws_route53_record" "terraform" {
  zone_id = data.aws_route53_zone.jehshopdns.id
  name    = "${var.hostname}.${var.hosted_zone_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.public_ip]
}

