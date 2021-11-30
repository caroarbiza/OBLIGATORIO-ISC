resource "aws_s3_bucket" "backup" {
  bucket = "backup-bucket-ecs"
  acl    = "private"

  lifecycle_rule {
    enabled = true

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

  }

  versioning {
    enabled = true
  }

  tags = {
    Name = "Backup bucket"
  }
}

