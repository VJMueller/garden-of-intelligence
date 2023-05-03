# conigure AWS APP Runner
resource "aws_apprunner_service" "garden_of_intelligence" {
  service_name = "garden-of-intelligence"

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.app-garden-of-intelligence.arn
    }
    image_repository {
      image_configuration {
        port = "8000" #The port that your application listens to in the container                             
      }
      image_identifier = "301581146302.dkr.ecr.eu-west-1.amazonaws.com/garden-of-intelligence:latest"
      #"${aws_ecr_repository.ecr_repository.repository_url}:${local.service_release_tag}"                          
      image_repository_type = "ECR"
    }

  }
}

output "service_url" {
  value = aws_apprunner_service.garden_of_intelligence.service_url
}