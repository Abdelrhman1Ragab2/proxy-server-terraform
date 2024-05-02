resource "aws_lb" "loadbalancer" {
  count = 2
  name               = "${var.lb_name}-${count.index}"
  internal           = count.index%2==0?false:true
  load_balancer_type = "application"
  security_groups    = var.lb_sg
  subnets            = var.lb_subnets[count.index]  ## list[[ pub subnets],[priv subns ]]
}


resource "aws_lb_target_group" "target_group" {
  count=2
  vpc_id   = var.vpc-id
  name     = "nti-target-group${count.index}"
  port     = 80
  protocol = "HTTP"

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "listener" {
  count = 2
  load_balancer_arn = aws_lb.loadbalancer[count.index].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[count.index].arn
  }
}

resource "aws_lb_target_group_attachment" "my_attachment" {
  count = 4
  target_group_arn = aws_lb_target_group.target_group[count.index<2?0:1].arn
  target_id        = var.instance-id[count.index]
}