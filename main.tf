provider "aws" {
  region = var.tokyo_region
}

provider "aws" {
  alias  = "osaka"
  region = var.osaka_region
}
