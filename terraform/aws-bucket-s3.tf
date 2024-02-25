resource "aws_s3_bucket" "terraform_state" {
  bucket = "oprimogus-terraform-state"
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "k3s" {
  bucket = "oprimogus-k3s"
  lifecycle {
    prevent_destroy = true
  }
}