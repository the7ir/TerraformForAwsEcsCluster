module "metric_alarm" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 3.0"

  alarm_name          = "my-application-logs-errors"
  alarm_description   = "Bad errors in my-application-logs"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 10
  period              = 60
  unit                = "Count"

  namespace   = "MyApplication"
  metric_name = "ErrorCount"
  statistic   = "Maximum"

  alarm_actions = ["arn:aws:sns:eu-west-1:835367859852:my-sns-queue"] // need to change
}