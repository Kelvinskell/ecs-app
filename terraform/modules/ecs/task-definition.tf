resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "ecs-app"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = "2048"
  memory                   = "5120"
  requires_compatibilities = ["FARGATE"]

  volume {
    name = "db-data"

    efs_volume_configuration {
      file_system_id = var.efs_id
    }
  }

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      "name" : "news-app",
      "image" : "kelvinskell/terra-tier",
      "cpu" : 0,
      "portMappings" : [
        {
          "name" : "flask-port",
          "containerPort" : 5000,
          "hostPort" : 5000,
          "protocol" : "tcp",
          "appProtocol" : "http"
        }
      ],
      "essential" : true,
      "environment" : [
        {
          "name" : "SECRET_KEY",
          "value" : "08dae760c2488d8a0dca1bfb"
        },
        {
          "name" : "API_KEY",
          "value" : "f39307bb61fb31ea2c458479762b9acc"
        },
        {
          "name" : "MYSQL_DB",
          "value" : "yourdbname"
        },
        {
          "name" : "MYSQL_HOST",
          "value" : "db"
        },
        {
          "name" : "MYSQL_USER",
          "value" : "yourusername"
        },
        {
          "name" : "DATABASE_PASSWORD",
          "value" : "Yourpassword@123"
        }
      ],
      "environmentFiles" : [],
      "mountPoints" : [],
      "volumesFrom" : [],
      "ulimits" : [],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/terra-tier",
          "awslogs-region" : "us-east-1",
          "awslogs-stream-prefix" : "ecs"
        },
        "secretOptions" : []
      },
      "systemControls" : []
    },
    {
      "name" : "mysqldb",
      "image" : "mysql:5.7",
      "cpu" : 0,
      "portMappings" : [
        {
          "name" : "mysql-port",
          "containerPort" : 3306,
          "hostPort" : 3306,
          "protocol" : "tcp"
        }
      ],
      "essential" : false,
      "environment" : [
        {
          "name" : "MYSQL_DATABASE",
          "value" : "yourdbname"
        },
        {
          "name" : "MYSQL_PASSWORD",
          "value" : "Yourpassword@123"
        },
        {
          "name" : "MYSQL_ROOT_PASSWORD",
          "value" : "yourrootpassword"
        },
        {
          "name" : "MYSQL_USER",
          "value" : "yourusername"
        }
      ],
      "environmentFiles" : [],
      "mountPoints" : [
        {
          "sourceVolume" : "db-data",
          "containerPath" : "/var/lib/mysql",
          "readOnly" : false
        }
      ],
      "volumesFrom" : [],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/terra-tier",
          "awslogs-region" : "us-east-1",
          "awslogs-stream-prefix" : "ecs"
        },
        "secretOptions" : []
      },
      "systemControls" : []
    }
  ])
}