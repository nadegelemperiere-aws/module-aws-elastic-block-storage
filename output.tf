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

output "id" {
    value = aws_ebs_volume.volume.id
}

output "arn" {
    value = aws_ebs_volume.volume.arn
}

output "key" {
    value = aws_kms_key.volume.arn
}
