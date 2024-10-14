
locals {
  bucketkeys = {
    loki : "otel/loki/logs"
    thanos : "otel/thanos/metrics"
    tempo : "otel/tempo/traces"
  }
  clusters = aws_route53_zone.clusters

  # Nested loop over both lists, and flatten the result.
  bucketkeys_cluster = distinct(flatten([
    for bucketKey, value in local.bucketkeys : [
      for cluster in local.clusters : {
        bucketKey = bucketKey
        cluster   = cluster.name
      }
    ]
  ]))
}

resource "aws_iam_policy" "loki_s3" {
  provider = aws.clientaccount
  for_each = { for entry in local.bucketkeys_cluster : "${entry.bucketKey}.${entry.cluster}" => entry }
  name     = "${each.value.bucketKey}-s3-${each.value.cluster}"
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
              "${module.common_s3.primary_s3_bucket_arn}/${each.value.name}/*",
              "${module.common_s3.primary_s3_bucket_arn}/${each.value.name}/*"
            ]
        }
    ]
}
EOF
}
