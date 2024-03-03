resource "aws_s3_bucket" "k3s" {
  bucket = "oprimogus-k3s"
  force_destroy = true
}

resource "aws_s3_bucket" "example" {
  bucket = "oprimogus-example"
  force_destroy = true
}