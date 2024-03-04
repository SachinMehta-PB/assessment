variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-2  = "ami-0f5daaa3a7fb3378b"
    us-east-1  = "ami-0f5daaa3a7fb3378b"
    ap-south-1 = "ami-0f5daaa3a7fb3378b"
  }
}

variable "PRIV_KEY_PATH" {
  default = "connect"
}

variable "PUB_KEY_PATH" {
  default = "connect.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
  default = ["0.0.0.0/0"]
}

variable "rmq" {
  default = "rabbit"
}

variable "rmpass" {
  default = "Rabbitrabbit12345"
}

variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "VPC_NAME" {
  default = "terrafrom-vpc"
}

variable "zone1" {
  default = "us-east-2a"
}

variable "zone2" {
  default = "us-east-2b"
}

variable "zone3" {
  default = "us-east-2c"
}

variable "Vpc_cidr" {
  default = "172.21.0.0/16"
}

variable "PubSub1CIDR" {
  default = "172.21.1.0/24"
}

variable "PubSub2CIDR" {
  default = "172.21.2.0/24"
}

variable "PubSub3CIDR" {
  default = "172.21.3.0/24"
}

variable "PrivSub1CIDR" {
  default = "172.21.4.0/24"
}

variable "PrivSub2CIDR" {
  default = "172.21.5.0/24"
}

variable "PrivSub3CIDR" {
  default = "172.21.6.0/24"
}