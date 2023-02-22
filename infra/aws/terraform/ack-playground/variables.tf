variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "prefix" {
  type        = string
  default     = "ack-poc-"
  description = "The prefix for all resources"

  validation {
    condition     = can(regex(".*-$|^$", var.prefix))
    error_message = "The string must end with a hyphen or be empty."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "namespace_service_accounts" {
    type = list(string)
    default = [
        "ack-system:ack-s3-controller"
    ]
}