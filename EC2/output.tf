output "ec2-ips" {
  description = "The ip addreses for ec2s"
  value       = [
    aws_instance.pub_ec2[0].id,
    aws_instance.pub_ec2[1].id,
    aws_instance.priv_ec2[0].id,
    aws_instance.priv_ec2[1].id
    ]
}
output "ec2-ips-1" {
  description = "The ip addreses for ec2s"
  value       = [
    aws_instance.pub_ec2[0].public_ip,
    aws_instance.pub_ec2[1].public_ip,
    aws_instance.priv_ec2[0].private_ip,
    aws_instance.priv_ec2[1].private_ip
    ]
}