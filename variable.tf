# network variable
variable "vpc-cidr" {
    type = string
    description = "cidr for vpc"
  
}
variable "cidr-all" {
    type = string
    description = "cidr 0.0.0.0/0"
  
}

variable "pub-sub-cidr" {
    type = list
    description = "list of all public cidr"
  
}
variable "priv-sub-cidr" {
    type = list
    description = "list of all private cidr"
  
}
variable "availability-zone" {
    type = list
    description = "list for tow az"
  
}

# ec2 variable 
variable ec2-ami {
  type        = string
  description = "ami for amazon ec2 "
}

variable ec2-type {
  type        = string
  description = "type for amazon ec2"
}

variable ec2-key {
  type        = string
  description = "key for amazon ec2"
}


variable ec2-name {
  type        = string
  description = "name for amazon ec2"
}

# variable module lb 
variable "lb-name" {
    type = string
    default = "name of lb"
  
}