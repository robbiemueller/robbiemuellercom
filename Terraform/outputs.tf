output "s3_bucket_domain_name" {
  value = aws_s3_bucket.static_website.bucket_regional_domain_name
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
