resource "aws_iam_policy" "s3_access" {
  name        = "s3AccessForK3sConfig"
  description = "Permite acesso ao S3 para configuração do K3s"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = [
        "s3:PutObject",
        "s3:GetObject"
        ],
      Effect   = "Allow",
      Resource = "${aws_s3_bucket.k3s.arn}/*"
    }]
  })
}