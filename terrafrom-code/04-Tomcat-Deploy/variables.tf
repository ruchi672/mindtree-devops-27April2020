variable "nvkey" {
  default = "nvkey"
}

variable "pvt_key" {
  default = "/root/.ssh/nvkey.pem"
}

variable "us-east-zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "sg1" {
  default = "sg-0c9c83c3b45cd9ebd"
}
