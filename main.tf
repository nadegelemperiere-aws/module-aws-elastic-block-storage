# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Module to deploy an aws elastic block storage with all
# the secure components required
# -------------------------------------------------------
# Nadège LEMPERIERE, @24 january 2022
# Latest revision: 24 january 2022
# -------------------------------------------------------

# -------------------------------------------------------
# Create the ebs volume
# -------------------------------------------------------
resource "aws_ebs_volume" "volume" {

    availability_zone = var.availability_zone
    size              = var.disk.size
    type              = var.disk.type
    encrypted         = true
    kms_key_id        = aws_kms_key.volume.arn
    snapshot_id       = var.snapshot

	tags = {
		Name           	= "${var.project}.${var.environment}.${var.module}.${var.region}.${var.name}.ebs"
		Environment     = var.environment
		Owner   		= var.email
		Project   		= var.project
		Version 		= var.git_version
		Module  		= var.module
	}
}

# -------------------------------------------------------
# Set permission policy for disk access
# -------------------------------------------------------
locals {
    kms_statements = concat([
        for i,right in ((var.rights != null) ? var.rights : []) :
        {
            Sid         = right.description
            Effect         = "Allow"
            Principal     = {
                "AWS"         : ((right.principal.aws != null) ? right.principal.aws : [])
                "Service"     : ((right.principal.services != null) ? right.principal.services : [])
            }
            Action         = ["kms:Decrypt","kms:GenerateDataKey"],
            Resource    = ["*"]
        }
    ],
    [
        {
            Sid         = "AllowRootAndServicePrincipal"
            Effect         = "Allow"
            Principal     = {
                "AWS"         : ["arn:aws:iam::${var.account}:root", "arn:aws:iam::${var.account}:user/${var.service_principal}"]
            }
            Action         = "kms:*",
            Resource    = ["*"]
        }
    ])
}

# -------------------------------------------------------
# Disk encryption key
# -------------------------------------------------------
resource "aws_kms_key" "volume" {

    description                 = "Table ${var.name} encryption key"
    key_usage                   = "ENCRYPT_DECRYPT"
    customer_master_key_spec    = "SYMMETRIC_DEFAULT"
    deletion_window_in_days     = 7
    enable_key_rotation         = true
      policy                    = jsonencode({
          Version = "2012-10-17",
          Statement = local.kms_statements
    })

    tags = {
        Name            = "${var.project}.${var.environment}.${var.module}.${var.region}.${var.name}.ebs.key"
        Environment     = var.environment
        Owner           = var.email
        Project         = var.project
        Version         = var.git_version
        Module          = var.module
    }
}
