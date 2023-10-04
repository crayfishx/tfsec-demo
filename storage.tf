resource "aws_s3_bucket" "demo_bucket" {
  bucket = "tfsecdemo-test-bucket"
}

resource "aws_s3_bucket_ownership_controls" "bucket_acl" {
  bucket = aws_s3_bucket.demo_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_acl]

  bucket = aws_s3_bucket.demo_bucket.id
  acl    = "private"
}
