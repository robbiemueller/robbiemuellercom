terraform {
  backend "s3" {
    bucket = "tfstaterobbie"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {
  region = "us-east-1" 
}

resource "aws_s3_bucket" "static_website" {
  bucket = "robbiemuellercom"

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}



locals {
  s3_origin_id = "static_website"
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.static_website.arn}/*"
        ]
      }
    ]
  })
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
resource "aws_s3_bucket_object" "abouthtml" {
  bucket = aws_s3_bucket.static_website.id
  key    = "about.html"
  source = "${path.module}/../website/about.html"
  content_type = "text/html"
  depends_on   = [aws_s3_bucket.static_website]
}

resource "aws_s3_bucket_object" "bloghtml" {
  bucket = aws_s3_bucket.static_website.id
  key    = "blog.html"
  source = "${path.module}/../website/blog.html"
  content_type = "text/html"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "galleryhtml" {
  bucket = aws_s3_bucket.static_website.id
  key    = "gallery.html"
  source = "${path.module}/../website/gallery.html"
  content_type = "text/html"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "indexhtml" {
  bucket = aws_s3_bucket.static_website.id
  key    = "index.html"
  source = "${path.module}/../website/index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "resumehtml" {
  bucket = aws_s3_bucket.static_website.id
  key    = "resume.html"
  source = "${path.module}/../website/resume.html"
  content_type = "text/html"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "scriptjs" {
  bucket = aws_s3_bucket.static_website.id
  key    = "script.js"
  source = "${path.module}/../website/script.js"
  content_type = "application/javascript"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "stylecss" {
  bucket = aws_s3_bucket.static_website.id
  key    = "style.css"
  source = "${path.module}/../website/style.css"
  content_type = "text/css"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "awsccppng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/awsccp.png"
  source = "${path.module}/../website/images/awsccp.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "awssysopspng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/awssysops.png"
  source = "${path.module}/../website/images/awssysops.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "azure-security-engineer-associate600x600png" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/azure-security-engineer-associate600x600.png"
  source = "${path.module}/../website/images/azure-security-engineer-associate600x600.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "azurefundpng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/azurefund.png"
  source = "${path.module}/../website/images/azurefund.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "ccna_600png" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/ccna_600.png"
  source = "${path.module}/../website/images/ccna_600.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "CompTIA_A_2Bcepng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/CompTIA_A_2Bce.png"
  source = "${path.module}/../website/images/CompTIA_A_2Bce.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "Comptia_CySA_2Bcepng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/Comptia_CySA_2Bce.png"
  source = "${path.module}/../website/images/Comptia_CySA_2Bce.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "CompTIA_Network_2Bcepng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/CompTIA_Network_2Bce.png"
  source = "${path.module}/../website/images/CompTIA_Network_2Bce.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "CompTIA_Project_2Bpng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/CompTIA_Project_2B.png"
  source = "${path.module}/../website/images/CompTIA_Project_2B.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "CompTIA_Security_2Bcepng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/CompTIA_Security_2Bce.png"
  source = "${path.module}/../website/images/CompTIA_Security_2Bce.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "dutchharborjpg" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/dutchharbor.jpg"
  source = "${path.module}/../website/images/dutchharbor.jpg"
  content_type = "image/jpeg"
  depends_on   = [aws_s3_bucket.static_website]  
}

resource "aws_s3_bucket_object" "isc2_associatepng" {
  bucket = aws_s3_bucket.static_website.id
  key    = "images/isc2_associate.png"
  source = "${path.module}/../website/images/isc2_associate.png"
  content_type = "image/png"
  depends_on   = [aws_s3_bucket.static_website]  
}