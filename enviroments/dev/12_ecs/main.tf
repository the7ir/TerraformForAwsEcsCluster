module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "ecs-integrated"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  services = {
    ecsdemo-frontend = {
      cpu    = 1024
      memory = 4096

      # Container definition(s)
      container_definitions = {

        fluent-bit = {
          cpu       = 512
          memory    = 1024
          essential = true
          image     = "906394416424.dkr.ecr.us-west-2.amazonaws.com/aws-for-fluent-bit:stable" // Chỗ này có thể cần thay thế.
          firelens_configuration = {
            type = "fluentbit"
          }
          memory_reservation = 50
        }

        ecs-sample = {
          cpu       = 512
          memory    = 1024
          essential = true
          image     = "public.ecr.aws/aws-containers/ecsdemo-frontend:776fd50"// Chỗ này có thể cần thay thế hoặc cần account
          port_mappings = [
            {
              name          = "ecs-sample"  // Need to change
              containerPort = 80
              protocol      = "tcp"
            }
          ]

          # Example image used requires access to write to root filesystem
          readonly_root_filesystem = false

          dependencies = [{
            containerName = "fluent-bit"
            condition     = "START"
          }]

          enable_cloudwatch_logging = true // change to true
          log_configuration = {
            logDriver = "awsfirelens"
            options = {
              Name                    = "firehose"
              region                  = provider.aws.region
              delivery_stream         = "my-stream"
              log-driver-buffer-limit = "2097152"
            }
          }
          memory_reservation = 100
        }
      }

      service_connect_configuration = {
        namespace = "example"
        service = {
          client_alias = {
            port     = 80
            dns_name = "ecs-sample"
          }
          port_name      = "ecs-sample"
          discovery_name = "ecs-sample"
        }
      }

      load_balancer = {
        service = {
          target_group_arn = data.aws_lb_target_group.test.arn //"arn:aws:elasticloadbalancing:eu-west-1:1234567890:targetgroup/bluegreentarget1/209a844cd01825a4" // Need to change
          container_name   = "ecs-sample" // Need to change
          container_port   = 80
        }
      }

      subnet_ids = data.aws_subnets.subnets.ids  //["10.0.1.0/24", "10.0.101.0/24"] // need to change
      security_group_rules = {
        alb_ingress_3000 = {
          type                     = "ingress"
          from_port                = 80
          to_port                  = 80
          protocol                 = "tcp"
          description              = "Service port"
          source_security_group_id = [data.aws_security_group.dev_private_sg.id] // need to change security_groups = ["sg-9115bae1"]

        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }

  tags = {
    Environment = "Dev"
    Project     = "Example"
  }
}