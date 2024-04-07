resource "aws_iam_policy" "cortex_s3" {
  provider = aws.clientaccount
  for_each = module.cortex_s3
  name     = "cortex-s3-${aws_route53_zone.clusters[each.key].name}"
  policy   = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
              "s3:ListBucket",
              "s3:PutObject",
              "s3:GetObject",
              "s3:DeleteObject"
            ],
            "Effect": "Allow",
            "Resource": [
              "${module.cortex_s3[each.key].primary_s3_bucket_arn}",
              "${module.cortex_s3[each.key].primary_s3_bucket_arn}/*"
            ]
        }
    ]
}
EOF
}
