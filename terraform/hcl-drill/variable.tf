variable "aws_region"{
	type=String
	description="Target AWS deployment region"
	default="us-east-1"
}

variable "volume_size_gb"{
	type=number
	description="size of the gp3 analytics EBS volume in gb"
	default=200
}

variable "environment"{
	type=string
	description="Deployment environment tag(Dec, Stage, Prod)"
	default="Prod"
}
