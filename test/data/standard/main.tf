# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2022] Technogix SARL
# All rights reserved
# -------------------------------------------------------
# Simple deployment for testing
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 12 november 2021
# -------------------------------------------------------

# -------------------------------------------------------
# Create volume using the current module
# -------------------------------------------------------
module "volume" {

	source 				= "../../../"
	email 				= "moi.moi@moi.fr"
	project 			= "test"
	environment 		= "test"
	region				= var.region
	module 				= "test"
	git_version 		= "test"
	service_principal 	= var.service_principal
	account				= var.account
	name 				= "test"
    availability_zone   = "${var.region}a"
	disk 				= {
		size	= 40
		type	= "gp2"
	}
    rights = [
		{   description = "AllowEC2ToAccessStorage"
            principal = { services = ["ec2.amazonaws.com"]}
        }
	]
}

# -------------------------------------------------------
# Terraform configuration
# -------------------------------------------------------
provider "aws" {
	region		= var.region
	access_key 	= var.access_key
	secret_key	= var.secret_key
}

terraform {
	required_version = ">=1.0.8"
	backend "local"	{
		path="terraform.tfstate"
	}
}

# -------------------------------------------------------
# Region for this deployment
# -------------------------------------------------------
variable "region" {
	type    = string
}

# -------------------------------------------------------
# AWS credentials
# -------------------------------------------------------
variable "access_key" {
	type    	= string
	sensitive 	= true
}
variable "secret_key" {
	type    	= string
	sensitive 	= true
}

# -------------------------------------------------------
# IAM account which root to use to test access rights settings
# -------------------------------------------------------
variable "account" {
	type 		= string
	sensitive 	= true
}
variable "service_principal" {
	type 		= string
	sensitive 	= true
}

# -------------------------------------------------------
# Test outputs
# -------------------------------------------------------
output "volume" {
	value = {
		id 	    = module.volume.id
		arn     = module.volume.arn
		key     = module.volume.key
	}
}
