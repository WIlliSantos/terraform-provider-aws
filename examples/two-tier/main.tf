#################################
## PROVIDER		                 ##
#################################

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

#################################
## JENKINS RESOURCES           ##
#################################

resource "aws_instance" "jenkins" {
  count = "${var.instance_count_jenkins}"
  ami                    = "${var.ami_jenkins}"
  instance_type          = "${var.instance_type_jenkins}"
  key_name               = "${var.key_name_jenkins}"
  monitoring             = "${var.monitoring_jenkins}"
  iam_instance_profile   = "${var.iam_instance_profile_jenkins}"
  vpc_security_group_ids = [ "${aws_security_group.sg_jenkins.id}" ]
  depends_on = [ "aws_security_group.sg_jenkins" ]
  
  credit_specification {
    cpu_credits = "${var.cpu_credits_jenkins}"
  }

  tags = {
    Name = "${var.name_jenkins}"
  }
}

resource "aws_security_group" "sg_jenkins" {
  name        = "${var.sg_jenkins}"
  description = "${var.sg_jenkins}"
  vpc_id      = "${var.vpc_jenkins}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.sg_jenkins}"
  }
}
  
resource "aws_eip" "ip_jenkins" {
  instance = "${aws_instance.jenkins.id}"
  depends_on = [ "aws_instance.jenkins" ]

  tags = {
    Name = "${var.eip_jenkins}"
  }
}

#################################
## ANSIBLE RESOURCES           ##
#################################

resource "aws_instance" "ansible" {

  count = "${var.instance_count_ansible}"
  ami                    = "${var.ami_ansible}"
  instance_type          = "${var.instance_type_ansible}"
  key_name               = "${var.key_name_ansible}"
  monitoring             = "${var.monitoring_ansible}"
  iam_instance_profile   = "${var.iam_instance_profile_ansible}"
  vpc_security_group_ids = [ "${aws_security_group.sg_ansible.id}" ]

  credit_specification {
    cpu_credits = "${var.cpu_credits_ansible}"
  }

  tags = {
    Name = "${var.name_ansible}"
  }
}

resource "aws_security_group" "sg_ansible" {
  name        = "${var.sg_ansible}"
  description = "${var.sg_ansible}"
  vpc_id      = "${var.vpc_ansible}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.sg_ansible}"
  }
}

resource "aws_eip" "ip_ansible" {
  instance = "${aws_instance.ansible.id}"
  depends_on = [ "aws_instance.ansible" ]

  tags = {
    Name = "${var.eip_ansible}"
  }
}

#################################
## KUBERNETES RESOURCES        ##
#################################

resource "aws_instance" "kubernetes" {

  count = "${var.instance_count_kubernetes}"
  ami                    = "${var.ami_kubernetes}"
  instance_type          = "${var.instance_type_kubernetes}"
  key_name               = "${var.key_name_kubernetes}"
  monitoring             = "${var.monitoring_kubernetes}"
  iam_instance_profile   = "${var.iam_instance_profile_kubernetes}"
  vpc_security_group_ids = [ "${aws_security_group.sg_kubernetes.id}" ]


  credit_specification {
    cpu_credits = "${var.cpu_credits_kubernetes}"
  }

  tags = {
    Name = "${var.name_kubernetes}"
  }
}

resource "aws_security_group" "sg_kubernetes" {
  name        = "${var.sg_kubernetes}"
  description = "${var.sg_kubernetes}"
  vpc_id      = "${var.vpc_kubernetes}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.sg_kubernetes}"
  }
}

resource "aws_eip" "ip_kubernetes" {
  instance = "${aws_instance.kubernetes.id}"
  depends_on = [ "aws_instance.kubernetes" ]

  tags = {
    Name = "${var.eip_kubernetes}"
  }
}
