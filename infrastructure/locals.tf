locals {
  region              = "ap-south-1"
  vpc_cidr            = "10.0.0.0/16"
  env                 = "dev"
  azs                 = ["${local.region}a", "${local.region}b"]
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

  private_subnets = {
    private_1 = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 3)
      az   = local.azs[0]
    }

    private_2 = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 4)
      az   = local.azs[1]
    }
  }
}