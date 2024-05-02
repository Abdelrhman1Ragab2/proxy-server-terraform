output vpc_id{
  value= aws_vpc.nti_vpc.id
}

output pub_sub_id1{

  value= aws_subnet.public_subnets[0].id
}

output pub_sub_id2{

  value= aws_subnet.public_subnets[1].id
}

output priv_sub_id1{

  value= aws_subnet.private_subnets[0].id
}
output priv_sub_id2{

  value= aws_subnet.private_subnets[1].id
}

output sg_id{
  value= aws_security_group.sg.id
}

output nat-gw{
  value= aws_nat_gateway.ngw
}


