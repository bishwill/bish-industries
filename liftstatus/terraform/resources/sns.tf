resource "aws_sns_topic" "lift_status" {
  name = "lift-status-topic"
}


resource "aws_sns_topic_subscription" "topic_sms_subscription" {
  count     = length(local.phone_numbers)
  topic_arn = aws_sns_topic.lift_status.arn
  protocol  = "sms"
  endpoint  = local.phone_numbers[count.index]
}