variable "ami_id" {
  type        = string
  description = "AMI ID to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "region" {
  type        = string
  description = "my region"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "project_env" {
  type        = string
  description = "Env of the project"
}

variable "project_owner" {
  type        = string
  description = "Owner of the project"
}

variable "frontend-sg-ports" {

  type        = list(any)
  description = "frontend security group parts"
}
