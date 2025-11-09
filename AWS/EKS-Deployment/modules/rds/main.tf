resource "aws_db_subnet_group" "rds_subnets" {
  name       = "${var.tags["Environment"]}-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags = var.tags
}

resource "aws_db_instance" "this" {
  identifier              = "${var.tags["Environment"]}-db"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  allocated_storage       = var.allocated_storage
  db_name = "bookstore"
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.rds_subnets.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  publicly_accessible     = false
  tags = var.tags
}

output "db_endpoint" {
  value = aws_db_instance.this.address
}

