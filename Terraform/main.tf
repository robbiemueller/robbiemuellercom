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

resource "aws_s3_bucket_public_access_block" "static_website_access" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = true
  restrict_public_buckets = false
}


locals {
  s3_origin_id = "static_website"
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_website.id
  depends_on = [aws_s3_bucket_public_access_block.static_website_access]

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

  aliases = ["robbiemueller.com", "www.robbiemueller.com"]

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:284868345684:certificate/18a69634-571c-44ad-8ec5-e5ef02c8e235"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
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

resource "aws_s3_bucket_object" "scriptjs" {
  bucket = aws_s3_bucket.static_website.id
  key    = "blogscript.js"
  source = "${path.module}/../website/blogscript.js"
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

resource "aws_dynamodb_table" "visitor_counter" {
  name           = "visitor_counter"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "page"

  attribute {
    name = "page"
    type = "S"
  }

  tags = {
    Name = "VisitorCounter"
  }
}

resource "aws_lambda_function" "visitor_counter" {
  function_name    = "visitorCounter"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  filename         = "lambda.zip"
  source_code_hash = "uupnaMNPumpLe2kkip6v/I2YVD6hG6+PAiT3ORPqLvM="
  role             = aws_iam_role.lambda_execution_role.arn

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.visitor_counter.name
    }
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_execution_policy" {
  name = "lambda_execution_policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.visitor_counter.arn
      }
    ]
  })
}

resource "aws_api_gateway_rest_api" "visitor_counter_api" {
  name        = "VisitorCounterAPI"
  description = "API for managing the visitor counter on the resume page."
}

resource "aws_api_gateway_resource" "visitor_counter_resource" {
  rest_api_id = aws_api_gateway_rest_api.visitor_counter_api.id
  parent_id   = aws_api_gateway_rest_api.visitor_counter_api.root_resource_id
  path_part   = "count"
}

resource "aws_api_gateway_method" "visitor_counter_get" {
  rest_api_id   = aws_api_gateway_rest_api.visitor_counter_api.id
  resource_id   = aws_api_gateway_resource.visitor_counter_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "visitor_counter_lambda" {
  rest_api_id = aws_api_gateway_rest_api.visitor_counter_api.id
  resource_id = aws_api_gateway_resource.visitor_counter_resource.id
  http_method = aws_api_gateway_method.visitor_counter_get.http_method

  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.visitor_counter.invoke_arn
}

resource "aws_api_gateway_deployment" "visitor_counter_deployment" {
  rest_api_id = aws_api_gateway_rest_api.visitor_counter_api.id
  stage_name  = "prod"

  depends_on = [
    aws_api_gateway_integration.visitor_counter_lambda
  ]
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.visitor_counter.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.visitor_counter_api.execution_arn}/*/*"
}
