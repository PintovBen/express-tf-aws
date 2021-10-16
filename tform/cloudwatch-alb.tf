module "alb-target-group-cloudwatch-sns-alarms" {
  source                  = "cloudposse/alb-target-group-cloudwatch-sns-alarms/aws"
  version                 = "0.15.0"
  alb_arn_suffix          = aws_alb.application_load_balancer.arn
  target_group_arn_suffix = aws_lb_target_group.target_group.arn
  alarm_actions           = ["${aws_sns_topic.topic.arn}"]
}