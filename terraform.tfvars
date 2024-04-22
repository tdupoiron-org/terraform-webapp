owner                  = "tdupoiron"
aws_region             = "eu-west-3"
aws_availability_zones = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
ovh_region             = "ovh-eu"
ovh_domain             = "dupoiron.com"

webapp_subdomain       = "bbs"
webapp_name            = "bbs"
webapp_image           = "atlassian/bitbucket:latest"
webapp_port            = 7990
webapp_heathcheck_path = "/status"

# webapp_subdomain       = "bbs"
# webapp_name            = "bbs"
# webapp_image           = "atlassian/bitbucket:latest"
# webapp_port            = 7990
# webapp_heathcheck_path = "/status"

# webapp_subdomain       = "jenkins"
# webapp_name            = "jenkins"
# webapp_image           = "jenkins/jenkins:latest"
# webapp_port            = 8080
# webapp_heathcheck_path = "/login"