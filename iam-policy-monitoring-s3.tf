resource "aws_iam_policy" "loki_s3" {
  provider = aws.clientaccount
  for_each = module.loki_s3
  name     = "loki-s3-${aws_route53_zone.clusters[each.key].name}"
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
              "${module.loki_s3[each.key].primary_s3_bucket_arn}",
              "${module.loki_s3[each.key].primary_s3_bucket_arn}/*"
            ]
        }
    ]
}
EOF
}

# Since the loki, tempo and thanos shares the same bucket, created the common and giving the path based security

resource "aws_iam_policy" "mon_loki_s3" {
  provider = aws.clientaccount
  for_each = module.mointoring_s3
  name     = "mon-loki-s3-${aws_route53_zone.clusters[each.key].name}"
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
              "${module.mon_s3[each.key].primary_s3_bucket_arn}",
              "${module.mon_s3[each.key].primary_s3_bucket_arn}/loki-logs/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "mon_tempo_s3" {
  provider = aws.clientaccount
  for_each = module.mointoring_s3
  name     = "mon-tempo-s3-${aws_route53_zone.clusters[each.key].name}"
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
              "${module.mon_s3[each.key].primary_s3_bucket_arn}",
              "${module.mon_s3[each.key].primary_s3_bucket_arn}/traces/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "mon_thanos_s3" {
  provider = aws.clientaccount
  for_each = module.mon_s3
  name     = "mon-thanos-s3-${aws_route53_zone.clusters[each.key].name}"
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
              "${module.mon_s3[each.key].primary_s3_bucket_arn}",
              "${module.mon_s3[each.key].primary_s3_bucket_arn}/metrics/*"
            ]
        }
    ]
}
EOF
}