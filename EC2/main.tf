
#public-ec2_instance

resource "aws_instance" "pub_ec2" {
  count = 2
  ami = var.ec2_ami
  instance_type = var.ec2_type
  subnet_id = var.pub_ec2_sub_ids[count.index]
  associate_public_ip_address = true
  key_name = var.ec2_key
  user_data = <<EOF
#!/bin/bash
sudo dnf update -y

sudo dnf install -y nginx

sudo systemctl start nginx

sudo systemctl enable nginx
echo 'server {
      listen 80;
      server_name _;

      location / {
        proxy_pass http://${var.private_lb_dns};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      }
    }' > /etc/nginx/conf.d/reverse_proxy.conf
sudo service nginx restart



  EOF

  vpc_security_group_ids = [
    var.ec2_sg
  ]

  tags = {
    Name = "pub-${var.ec2_name}-${count.index}"
  }

  provisioner "local-exec" {
    when        = create
    on_failure  = continue
    command = "echo 'public-ip-${count.index} : ${self.public_ip}' >> ips.txt"
 }

}

resource "aws_instance" "priv_ec2" {
  count = 2
  ami = count.index==0?var.ec2_ami:"ami-0776c814353b4814d"
  instance_type = var.ec2_type
  subnet_id = var.priv_ec2_sub_ids[count.index]
  associate_public_ip_address = false
  key_name = var.ec2_key
  user_data = file(count.index==0?"apache-amazon.sh":"apache-ubuntu.sh")

  vpc_security_group_ids = [
    var.ec2_sg
  ]

  tags = {
    Name = "priv-${var.ec2_name}-${count.index}"
  }

  depends_on = [ 
      var.nat-gateway
   ]


  provisioner "local-exec" {
    when        = create
    on_failure  = continue
    command = "echo 'private-ip-${count.index} : ${self.private_ip}' >> ips.txt"
 }
  
}


