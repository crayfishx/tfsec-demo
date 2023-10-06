# tfsec:ignore:aws-s3-enable-versioning tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "tfsecdemo-test-bucket"
    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = "arn"
          sse_algorithm     = "aws:kms"
        }
      }
   }
}



resource "aws_s3_bucket_ownership_controls" "bucket_acl" {
  bucket = aws_s3_bucket.demo_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

 resource "aws_s3_bucket_public_access_block" "demo" {
    bucket = aws_s3_bucket.demo_bucket.id
    block_public_acls = true
    ignore_public_acls = true
    restrict_public_buckets = true
    block_public_policy = true 

 }

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_acl]

  bucket = aws_s3_bucket.demo_bucket.id
  acl    = "private"
}
