terraform{
	required_providers={
		aws={
			source="hashicorp/aws"
			version="~>5.0"
		}
	}
}

provider "aws"{
	region 			    =var.aws_region
	skip_credentials_validation = true
	skip_requesting_account_id  = true
}

resource "aws_ebs_volume" "disk_analysis"{
	availability_zone="${var.aws_region}a"
	size=var.volume_size_gb
	type="gp3"
	encrypted=true

	tags={
	   Environment=var.environment
	   Service="billing-etl"
	}
}

resource "aws_vpc" "finops_vpc"{
	cide_block="10.10.0.0/16"

	tags={
	   Environment=var.environment
	   Service="billing-etl"
	}
}

resource "aws_vpc_endpoint" "s3_gateway"{
	vpc_id=aws_vpc.finops_vpc.id
	service_name="com.amazonaws.${var.aws_region}.s3"
	vpc_endpoint_type="Gateway"

	tags={
	    Environment=var.environment
	    Service="billing-etl"
	}
}
