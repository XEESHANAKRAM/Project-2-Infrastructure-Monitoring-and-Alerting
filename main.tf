provider "aws" {
  region = "us-east-1"
  access_key = "**"
  secret_key = "**"
}

# Create an SNS Topic for Alerts
resource "aws_sns_topic" "alert" {
  name = "web-application-alerts"
}

# Create an SNS Subscription for Email Notifications
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alert.arn
  protocol  = "email"
  endpoint  = "jamzeeshanakram@gmail.com" # Replace with your email
}

# Create CloudWatch Alarms for CPU Usage
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "High CPU Utilization"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  statistic          = "Average"
  period             = 60
  evaluation_periods = 2
  threshold          = 80
  comparison_operator = "GreaterThanThreshold"

  alarm_actions = [aws_sns_topic.alert.arn]
}

# Create CloudWatch Alarms for Memory Usage
resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  alarm_name          = "High Memory Utilization"
  metric_name        = "MemoryUtilization"
  namespace          = "AWS/EC2"
  statistic          = "Average"
  period             = 60
  evaluation_periods = 2
  threshold          = 80
  comparison_operator = "GreaterThanThreshold"

  alarm_actions = [aws_sns_topic.alert.arn]
}

# Create CloudWatch Alarms for Network Traffic
resource "aws_cloudwatch_metric_alarm" "network_alarm" {
  alarm_name          = "High Network Traffic"
  metric_name        = "NetworkIn"
  namespace          = "AWS/EC2"
  statistic          = "Average"
  period             = 60
  evaluation_periods = 2
  threshold          = 1000000 # Adjust threshold as needed
  comparison_operator = "GreaterThanThreshold"

  alarm_actions = [aws_sns_topic.alert.arn]
}

# Create a CloudWatch Log Group for Application Logs
resource "aws_cloudwatch_log_group" "app_logs" {
  name = "/aws/lambda/app-log-stream" # Replace with your log group name
}

# Create a CloudWatch Log Stream for Application Logs
resource "aws_cloudwatch_log_stream" "app_log_stream" {
  log_group_name = aws_cloudwatch_log_group.app_logs.name
  name           = "app-log-stream"
}

# Create a CloudWatch Dashboard to visualize metrics
resource "aws_cloudwatch_dashboard" "app_dashboard" {
  dashboard_name = "WebApplicationMonitoring"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 6,
        height = 6,
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", "your-instance-id"], # Replace with your instance ID
            ["AWS/EC2", "MemoryUtilization", "InstanceId", "your-instance-id"],
            ["AWS/EC2", "NetworkIn", "InstanceId", "your-instance-id"],
          ],
          region = "us-east-1",  # Specify the region
          title = "EC2 Instance Metrics",
          annotations = {         # Add annotations if required
            horizontal = [
              {
                label = "High CPU Utilization",
                value = 80,
              },
              {
                label = "High Memory Utilization",
                value = 80,
              },
              {
                label = "High Network Traffic",
                value = 1000000, # Adjust as necessary
              }
            ]
          }
        },
      },
    ],
  })
}
