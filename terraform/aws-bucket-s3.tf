resource "aws_s3_bucket" "k3s" {
  bucket = "oprimogus-k3s"
  force_destroy = true
}