module "appconfig" {
  source  = "terraform-aws-modules/appconfig/aws"

  name        = "example"
  description = "AppConfig hosted configuration"

  # environments
  environments = {
    nonprod = {
      name        = "dev"
      description = "Non-production environment"
    },
    prod = {
      name        = "prod"
      description = "Production environment"
    }
  }

  # hosted config version
  use_hosted_configuration           = true
  hosted_config_version_content_type = "application/json"
  hosted_config_version_content = jsonencode({
    isEnabled     = false,
    messageOption = "ItWorks!"
  })

  # configuration profile
  config_profile_validator = [{
    type = "JSON_SCHEMA"
    content = jsonencode({
      "$schema" = "http://json-schema.org/draft-04/schema#",
      type      = "object",
      properties = {
        isEnabled = {
          type = "boolean"
        },
        messageOption = {
          type    = "string",
          minimum = 0
        }
      },
      additionalProperties = false,
      required             = ["isEnabled", "messageOption"]
    }) }, {
    type    = "LAMBDA"
    content = "arn:aws:lambda:us-east-1:123456789101:function:example-appconfig-hosted" // need to change
  }]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}