resource "aws_ecs_task_definition" "backend_task" {
  family = "backend_example_app_family"


  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"


  memory = "512"
  cpu    = "256"


  execution_role_arn = aws_iam_role.ecs_role.arn

  container_definitions = <<EOT
[
    {
        "name": "backend_example_app_family",
        "image": "${aws_ecr_repository.ecr_repo.repository_url}:latest",
        "memory": 512,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 3000,
                "hostPort": 3000
            }
        ]
    }
]
EOT
}

resource "aws_ecs_cluster" "backend_cluster" {
  name = "backend_cluster_example_app"
}

resource "aws_ecs_service" "backend_service" {
  name = "backend_service"

  cluster         = aws_ecs_cluster.backend_cluster.id
  task_definition = aws_ecs_task_definition.backend_task.arn

  launch_type   = "FARGATE"
  desired_count = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn # Referencing our target group
    container_name   = aws_ecs_task_definition.backend_task.family
    container_port   = 3000 # Specifying the container port
  }

  network_configuration {
    subnets          = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
    security_groups  = ["${aws_security_group.security_group_example_app.id}"]
    assign_public_ip = true
  }
}