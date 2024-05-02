module "network1" {
    source = "./network"
    vpc_cidr = var.vpc-cidr
    priv_sub_cidr=var.priv-sub-cidr
    pub_sub_cidr= var.pub-sub-cidr
    availability_zone=var.availability-zone
    cidr_all=var.cidr-all
}
module "ec2" {
    source = "./EC2"
    ec2_ami= var.ec2-ami
    ec2_type=var.ec2-type
    ec2_key=var.ec2-key
    ec2_sg = module.network1.sg_id
    ec2_name = var.ec2-name
    pub_ec2_sub_ids=[ module.network1.pub_sub_id1, module.network1.pub_sub_id2]
    priv_ec2_sub_ids=[module.network1.priv_sub_id1,module.network1.priv_sub_id2]
    private_lb_dns= module.lb1.lb_dns_name1
    nat-gateway = module.network1.nat-gw
}
module "lb1" {
    source = "./LB"
    lb_subnets=[[ module.network1.pub_sub_id1, module.network1.pub_sub_id2],[module.network1.priv_sub_id1,module.network1.priv_sub_id2]]
    lb_sg = [module.network1.sg_id]
    lb_name = var.lb-name
    vpc-id=module.network1.vpc_id
    instance-id=module.ec2.ec2-ips
}



resource "local_file" "lb-dns" {
    filename = "./dns-name"
    content = "external load balancer: ${module.lb1.lb_dns_name0}\ninternal load balancer:${module.lb1.lb_dns_name1}"
  
}