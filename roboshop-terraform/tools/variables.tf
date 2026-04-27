variable "zone_id" {
  default = "Z09055292Q5WKIF45FE2E"
}

variable "ami" {
  default = "ami-0051178e229f92cb4"
}

variable "tools" {
  default = {
    vault = {
      instance_type = "t3.small"
    }
    github-runner = {
      instance_type = "t3.small"
      iam_policy    = ["*"]
      disk_size     = 50
    }
    elk = {
      instance_type = "t3.xlarge"
      spot          = true
      spot_max_price = 0.0400
      subnet        = "subnet-05f2d527e96f275c9"
    }
  }
}

variable "token" {}

variable "ecr" {
  default = {
    frontend  = "IMMUTABLE"
    cart      = "IMMUTABLE"
    catalogue = "IMMUTABLE"
    user      = "IMMUTABLE"
    shipping  = "IMMUTABLE"
    payment   = "IMMUTABLE"
    runner    = "MUTABLE"
  }
}
