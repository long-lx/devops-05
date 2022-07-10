# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair

resource "aws_key_pair" "devops" {
  key_name = "devops-ssh"

  # replace the below with your public key
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC45C8ZG/u2+ak8oL7ana1p59YGB1WTmEHRAty5bdOxWOjkXAH2Pyn+oJZ3LS7gDJiFpWO3zkCOdKWnNWtxgKlCOnWqh5dH+YlzLxuI3x4KhR8VDhZub0EwfhmSv93vTtFyIp5F2bRLXInPq+D4Pipwufq9fUyxHYdXXdkg31/50Bkizn+ixxAU/mBrCzlA3VfhXhT0VNuCcSZvIkXdM0a1zKQrHbmNNHzLCm0aeNpg+eh/GqUu/U/fEnBTn1Bikuf6ASXLWZrXPKWXVM4R6cBcusjm8Xg1VSRLo8+/otYvqQrerbdQJssHUGwQfwFsWyBDXdxC8RZHO2jBkkIphOo9 me@longlx8.com"
}

# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest

# create ec2 instances with public subnet in zone a
module "ec2_instance_za" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["01"])

  name = "web-za-${each.key}"

  ami                         = "ami-0eaf04122a1ae7b3b" # https://cloud-images.ubuntu.com/locator/ec2/
  instance_type               = var.ec2_instance_type
  key_name                    = aws_key_pair.devops.key_name
  vpc_security_group_ids      = [module.security_group.security_group_id]
  subnet_id                   = element(module.vpc.public_subnets, 0)
  associate_public_ip_address = true
}

# create ec2 instances with public subnet in zone a
module "ec2_instance_zb" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["01"])

  name = "web-zb-${each.key}"

  ami                         = "ami-0eaf04122a1ae7b3b" # https://cloud-images.ubuntu.com/locator/ec2/
  instance_type               = var.ec2_instance_type
  key_name                    = aws_key_pair.devops.key_name
  vpc_security_group_ids      = [module.security_group.security_group_id]
  subnet_id                   = element(module.vpc.public_subnets, 1)
  associate_public_ip_address = true
}
