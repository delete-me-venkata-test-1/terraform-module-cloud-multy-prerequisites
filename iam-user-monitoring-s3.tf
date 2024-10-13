resource "aws_iam_user" "loki_s3" {
  provider = aws.clientaccount
  for_each = aws_route53_zone.clusters
  name     = "loki-s3-${aws_route53_zone.clusters[each.key].name}"
}

resource "aws_iam_user_policy_attachment" "loki_s3" {
  provider   = aws.clientaccount
  for_each   = aws_iam_user.loki_s3
  user       = each.value.name
  policy_arn = aws_iam_policy.loki_s3[each.key].arn
  depends_on = [aws_iam_user.loki_s3]
}

resource "aws_iam_access_key" "loki_s3" {
  for_each   = aws_iam_user.loki_s3
  provider   = aws.clientaccount
  user       = each.value.name
  depends_on = [aws_iam_user.loki_s3]
}

#loki s3 configuration on new buckets 
resource "aws_iam_user" "mointoring_loki_s3" {
  provider = aws.clientaccount
  for_each = aws_route53_zone.clusters
  name     = "mointoring-loki-s3-${aws_route53_zone.clusters[each.key].name}"
}

resource "aws_iam_user_policy_attachment" "mointoring_loki_s3" {
  provider   = aws.clientaccount
  for_each   = aws_iam_user.mointoring_loki_s3
  user       = each.value.name
  policy_arn = aws_iam_policy.mointoring_loki_s3[each.key].arn
  depends_on = [aws_iam_user.mointoring_loki_s3]
}

resource "aws_iam_access_key" "mointoring_loki_s3" {
  for_each   = aws_iam_user.mointoring_loki_s3
  provider   = aws.clientaccount
  user       = each.value.name
  depends_on = [aws_iam_user.mointoring_loki_s3]
}

#thanos s3 configuration on new buckets 
resource "aws_iam_user" "mointoring_thanos_s3" {
  provider = aws.clientaccount
  for_each = aws_route53_zone.clusters
  name     = "mointoring-thanos-s3-${aws_route53_zone.clusters[each.key].name}"
}

resource "aws_iam_user_policy_attachment" "mointoring_thanos_s3" {
  provider   = aws.clientaccount
  for_each   = aws_iam_user.mointoring_thanos_s3
  user       = each.value.name
  policy_arn = aws_iam_policy.mointoring_thanos_s3[each.key].arn
  depends_on = [aws_iam_user.mointoring_thanos_s3]
}

resource "aws_iam_access_key" "mointoring_thanos_s3" {
  for_each   = aws_iam_user.mointoring_thanos_s3
  provider   = aws.clientaccount
  user       = each.value.name
  depends_on = [aws_iam_user.mointoring_thanos_s3]
}

#tempo s3 configuration on new buckets 
resource "aws_iam_user" "mointoring_tempo_s3" {
  provider = aws.clientaccount
  for_each = aws_route53_zone.clusters
  name     = "mointoring-tempo-s3-${aws_route53_zone.clusters[each.key].name}"
}

resource "aws_iam_user_policy_attachment" "mointoring_tempo_s3" {
  provider   = aws.clientaccount
  for_each   = aws_iam_user.mointoring_tempo_s3
  user       = each.value.name
  policy_arn = aws_iam_policy.mointoring_tempo_s3[each.key].arn
  depends_on = [aws_iam_user.mointoring_tempo_s3]
}

resource "aws_iam_access_key" "mointoring_tempo_s3" {
  for_each   = aws_iam_user.mointoring_tempo_s3
  provider   = aws.clientaccount
  user       = each.value.name
  depends_on = [aws_iam_user.mointoring_tempo_s3]
}