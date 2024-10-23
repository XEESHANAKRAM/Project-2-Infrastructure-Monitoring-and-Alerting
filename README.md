# Project-2-Infrastructure-Monitoring-and-Alerting

Project: Zeeshan Akram (DevOps Engineer)
Web: wikihelpful.com
linkedin: https://www.linkedin.com/in/mrzeeshanakram/


# Project 2: Infrastructure Monitoring and Alerting
This project focuses on implementing a robust monitoring and alerting system for your company's web application using AWS CloudWatch and SNS (Simple Notification Service). By completing this project, you will gain hands-on experience in setting up monitoring for critical infrastructure metrics and leveraging notifications to stay informed about your application's performance.

# 1. Project Overview
Objective: Monitor the performance of a web application by creating CloudWatch Alarms for critical metrics, setting up SNS for alerts, aggregating logs using CloudWatch Logs, and implementing a dashboard for visualization.

# 2. Required Modules
CloudWatch: For monitoring and alarming based on metrics.
SNS: For notifications via email/SMS.
CloudWatch Logs: For log aggregation and monitoring.
Terraform Modules: Use reusable Terraform modules for creating alarms and SNS.

# 3. Directory Structure
Create a directory structure for your project:

infrastructure-monitoring/
│
├── modules/
│   ├── cloudwatch/
│   │   └── main.tf
│   └── sns/
│       └── main.tf
│
└── main.tf


# 9. Testing the Monitoring Setup
Access your CloudWatch Alarms in the AWS Management Console to confirm they are created.
Test the SNS email subscription by triggering an alarm to ensure notifications are sent.
Check the CloudWatch Logs for application logs and ensure the dashboard reflects the metrics.
