provider "aws" {
  region = "us-east-1" 
}

resource "aws_s3_bucket" "static_website" {
  bucket = "robbiemuellercom"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

locals {
  s3_origin_id = "static_website"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.static_website.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = ""
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "RobbieMueller.com Cloudfront Distrbution"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

#Website objects for S3 Bucket
resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "about.html"
  source = "${path.module}/website/about.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "blog.html"
  source = "${path.module}/website/blog.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "gallery.html"
  source = "${path.module}/website/gallery.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "index.html"
  source = "${path.module}/website/index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "resume.html"
  source = "${path.module}/website/resume.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "script.js"
  source = "${path.module}/website/script.js"
  content_type = "application/javascript"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "style.css"
  source = "${path.module}/website/style.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/awsccp.png"
  source = "${path.module}/website/imgaes/awsccp.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/awssysops.png"
  source = "${path.module}/website/imgaes/awssysops.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/azure-security-engineer-associate600x600.png"
  source = "${path.module}/website/imgaes/azure-security-engineer-associate600x600.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/azurefund.png"
  source = "${path.module}/website/imgaes/azurefund.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/ccna_600.png"
  source = "${path.module}/website/imgaes/ccna_600.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/CompTIA_A_2Bce.png"
  source = "${path.module}/website/imgaes/CompTIA_A_2Bce.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/Comptia_CySA_2Bce.png"
  source = "${path.module}/website/imgaes/Comptia_CySA_2Bce.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/CompTIA_Network_2Bce.png"
  source = "${path.module}/website/imgaes/CompTIA_Network_2Bce.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/CompTIA_Project_2B.png"
  source = "${path.module}/website/imgaes/CompTIA_Project_2B.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/CompTIA_Security_2Bce.png"
  source = "${path.module}/website/imgaes/CompTIA_Security_2Bce.png"
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/dutchharbor.jpg"
  source = "${path.module}/website/imgaes/dutchharbor.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_bucket_object" "website_files" {
  bucket = aws_s3_bucket.website.id
  key    = "images/isc2_associate.png"
  source = "${path.module}/website/imgaes/isc2_associate.png"
  content_type = "image/png"
}