resource "aws_sns_topic" "topic" {
  name = "ALB-Alert"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "pintovben@gmail.com"
}