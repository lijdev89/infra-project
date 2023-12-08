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
