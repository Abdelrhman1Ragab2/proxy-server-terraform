# default.tf variable 
variable vpc_cidr {
  type        = string
  description = "vpc_cidr"
}

variable pub_sub_cidr {
  type        = list
  description = "list of tow public subnet cider "
}

variable priv_sub_cidr {
  type        = list
  description = "list of tow privater subnet cider "
}

variable  availability_zone {
  type        = list
  description = "list of tow availability_zone  "
}

# route_table.tf variable
variable cidr_all {
  type        = string
  description = "cidr for all ip "
}