# Include the AWS provider configuration from provider.tf
provider "aws" {
  alias  = "guardduty" # Alias the AWS provider for GuardDuty-specific resources
  region = "us-east-1" # Modify to your desired region
}

# Create an AWS GuardDuty Detector
resource "aws_guardduty_detector" "example" {
  provider = aws.guardduty
  enable   = true
}

# Define GuardDuty Finding Criteria (Threat Intelligence Set)
resource "aws_guardduty_threatintelset" "example" {
  provider   = aws.guardduty
  detector_id = aws_guardduty_detector.example.id
  format      = "TXT"
  location    = "https://example.com/threat-list.txt"
}

# Create an AWS CloudWatch Event Rule
resource "aws_cloudwatch_event_rule" "example" {
  name        = "guardduty-example-rule"
  description = "GuardDuty Example Rule"

  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail_type = ["GuardDuty Finding"]
    detail      = {
      findings = {
        threatIntelSetItem = {
          -"${aws_guardduty_threatintelset.example.name}" = true
        }
      }
    }
  })
}

# Create an AWS SNS Topic
resource "aws_sns_topic" "example" {
  name = "guardduty-example-topic"
}

# Subscribe to the SNS Topic
resource "aws_sns_topic_subscription" "example" {
  topic_arn = aws_sns_topic.example.arn
  protocol  = "email"
  endpoint  = "youremail@example.com"
}

# Attach GuardDuty to all specified EC2 instances
resource "aws_guardduty_member" "example" {
  count         = length(var.ec2_instance_ids)
  provider      = aws.guardduty
  detector_id   = aws_guardduty_detector.example.id
  account_id    = "YOUR_ACCOUNT_ID"
  email         = "youremail@example.com"
  invitation_message = "Please accept GuardDuty invitation for monitoring."
  disable_email_notification = false

  member {
    account_id = "YOUR_ACCOUNT_ID"
    email      = "youremail@example.com"
    type       = "EC2_INSTANCE_ID"
    id         = var.ec2_instance_ids[count.index]
  }
}
