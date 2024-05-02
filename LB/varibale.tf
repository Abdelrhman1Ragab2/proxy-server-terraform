# lb.tf variable 
variable lb_subnets {
  type        = list(list(string))
  description = "lb_subnets for amazon ec2"
}

variable lb_sg {
  type        = set(string)
  description = "lb_sg  for amazon ec2"
}


variable lb_name {
  type        = string
  description = "name for amazon ec2"
}

variable "vpc-id" {
  type = string
  description = "vpc id "
  
}

variable "instance-id" {
  type = list
  description = "instance ids  "
  
}