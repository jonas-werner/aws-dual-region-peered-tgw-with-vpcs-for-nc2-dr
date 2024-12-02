variable "project_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "JWR"
}

variable "tokyo_region" {
  description = "AWS region for Tokyo resources"
  type        = string
  default     = "ap-northeast-1"
}

variable "osaka_region" {
  description = "AWS region for Osaka resources"
  type        = string
  default     = "ap-northeast-3"
}

variable "tokyo_vpc_cidr" {
  description = "CIDR block for Tokyo VPC"
  type        = string
  default     = "10.101.0.0/16"
}

variable "osaka_vpc_cidr" {
  description = "CIDR block for Osaka VPC"
  type        = string
  default     = "10.102.0.0/16"
}

variable "tokyo_az" {
  description = "Availability Zone for Tokyo resources"
  type        = string
  default     = "ap-northeast-1a"
}

variable "osaka_az" {
  description = "Availability Zone for Osaka resources"
  type        = string
  default     = "ap-northeast-3a"
}
