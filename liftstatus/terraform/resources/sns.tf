resource "aws_sns_topic" "lift_status" {
  name = "lift-status-topic"
}


resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.lift_status.arn
  protocol  = "email"
  endpoint  = "will.bishop9427@gmail.com"
}