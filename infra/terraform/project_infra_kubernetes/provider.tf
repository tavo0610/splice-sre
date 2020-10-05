provider "aws" {
  version = "~> 2.57.0"
  region  = "us-west-2"
  profile = "personal"
}

provider "random" {
  version = "~> 2.2.1"
}
