# https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "7.0.0"

  name               = local.name
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.security_group.security_group_id]

  target_groups = [
    {
      name_prefix      = "d05-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        web-za-01 = {
          target_id = "i-02bc797b8fba78dd3"
          port      = 80
        }
        web-za-02 = {
          target_id = "i-04038b53f58dd1a03"
          port      = 80
        }
        web-zb-01 = {
          target_id = "i-0aa8a699d663cea02"
          port      = 80
        }
        web-zb-02 = {
          target_id = "i-0fc57548c2fce491e"
          port      = 80
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}
