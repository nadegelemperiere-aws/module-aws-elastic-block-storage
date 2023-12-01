# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Module to deploy an aws s3 bucket with all the secure
# components required
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 01 december 2023
# -------------------------------------------------------


# -------------------------------------------------------
# Contact e-mail for this deployment
# -------------------------------------------------------
variable "email" {
	type 	 = string
    nullable = false
}

# -------------------------------------------------------
# Environment for this deployment (prod, preprod, ...)
# -------------------------------------------------------
variable "environment" {
	type 	 = string
    nullable = false
}
variable "region" {
	type 	 = string
    nullable = false
}

# -------------------------------------------------------
# Topic context for this deployment
# -------------------------------------------------------
variable "project" {
	type     = string
    nullable = false
}
variable "module" {
	type 	 = string
    nullable = false
}

# -------------------------------------------------------
# Solution version
# -------------------------------------------------------
variable "git_version" {
	type     = string
	default  = "unmanaged"
    nullable = false
}

# -------------------------------------------------------
# Bucket name
# -------------------------------------------------------
variable "name" {
	type     = string
    nullable = false
}

# -------------------------------------------------------
# Netork configuration
# -------------------------------------------------------
variable "availability_zone" {
	type     = string
    nullable = false
}

# -------------------------------------------------------
# Disk settings
# -------------------------------------------------------
variable "disk" {
    type = object({
        size = number
        type = string
    })
    default = {
        size = 30
        type = "gp3"
    }
    nullable = false
}

# -------------------------------------------------------
# Id of the snapshot to use for initialization
# -------------------------------------------------------
variable "snapshot" {
	type    = string
	default = null
}

# --------------------------------------------------------
# Volume access rights + Service principal and account
# to ensure root and service principal can access
# --------------------------------------------------------
variable "rights" {
    type = list(object({
        description = string
        principal     = object({
            aws       = optional(list(string))
            services  = optional(list(string))
        })
    }))
    default = null
}
variable "service_principal" {
	type     = string
    nullable = false
}
variable "account" {
	type     = string
    nullable = false
}
