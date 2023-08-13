# Create private S3 bucket that stores terraform state 
resource "aws_s3_bucket" "tfstate" {
  bucket        = "wordpress-3tier-state-files"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "s3_ownership" {
  bucket = aws_s3_bucket.tfstate.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tfstate_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_ownership]
  bucket     = aws_s3_bucket.tfstate.id
  acl        = "private"
}

# Add bucket versioning for state rollback
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Add bucket encryption to hide sensitive state data
resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
  bucket = aws_s3_bucket.tfstate.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}