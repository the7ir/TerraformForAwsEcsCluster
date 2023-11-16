# variables.tf | Auth and Application variables
variable "project_name" {
  description = "The project name to be used in global resources names"
  type        = string
  default     = "terraformforawsecscluster"
}
