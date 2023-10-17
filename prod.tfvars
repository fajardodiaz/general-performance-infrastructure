master_instance_type  = "c5.xlarge"
slave_instance_type   = "c5.2xlarge"
master_instance_count = 1
slave_instance_count  = 2
ami                   = "ami-053b0d53c279acc90"
availability_zone     = "us-east-1a"
key_name              = "AutomatizacionDevops"
<<<<<<< HEAD
volume_size           = 10
volume_type           = "gp2"
environment           = "production"
=======
volume_size           = 75
volume_type           = "gp2"
environment           = "production"
>>>>>>> 4e50572 (Adding sg and eip association)
