# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2022] Technogix SARL
# All rights reserved
# -------------------------------------------------------
# Module to deploy an aws s3 bucket with all the secure
# components required
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 12 november 2021
# -------------------------------------------------------

terraform {
	experiments = [ module_variable_optional_attrs ]
}

# -------------------------------------------------------
# Contact e-mail for this deployment
# -------------------------------------------------------
variable "email" {
	type 	= string
}

# -------------------------------------------------------
# Environment for this deployment (prod, preprod, ...)
# -------------------------------------------------------
variable "environment" {
	type 	= string
}
variable "region" {
	type 	= string
}

# -------------------------------------------------------
# Topic context for this deployment
# -------------------------------------------------------
variable "project" {
	type    = string
}
variable "module" {
	type 	= string
}

# -------------------------------------------------------
# Solution version
# -------------------------------------------------------
variable "git_version" {
	type    = string
	default = "unmanaged"
}

# -------------------------------------------------------
# Bucket name
# -------------------------------------------------------
variable "name" {
	type = string
}

# -------------------------------------------------------
# Netork configuration
# -------------------------------------------------------
variable "availability_zone" {
	type = string
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
	type = string
}
variable "account" {
	type = string
}
