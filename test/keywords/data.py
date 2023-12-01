# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Keywords to create data for module test
# -------------------------------------------------------
# Nadège LEMPERIERE, @13 november 2021
# Latest revision: 13 november 2021
# -------------------------------------------------------

# System includes
from json import load, dumps

# Robotframework includes
from robot.libraries.BuiltIn import BuiltIn, _Misc
from robot.api import logger as logger
from robot.api.deco import keyword
ROBOT = False

# ip address manipulation
from ipaddress import IPv4Network

@keyword('Load Standard Test Data')
def load_standard_test_data(volume, region) :

    result = {}
    result['volumes'] = []

    result['volumes'].append({})
    result['volumes'][0]['name'] = 'volume'
    result['volumes'][0]['data'] = {}

    result['volumes'][0]['data']['AvailabilityZone'] = 'eu-west-1a'
    result['volumes'][0]['data']['Encrypted'] = True
    result['volumes'][0]['data']['KmsKeyId'] = volume['key']
    result['volumes'][0]['data']['Size'] = 40
    result['volumes'][0]['data']['State'] = 'available'
    result['volumes'][0]['data']['VolumeId'] = volume['id']
    result['volumes'][0]['data']['VolumeType'] = 'gp2'

    result['volumes'][0]['data']['Tags'] = []
    result['volumes'][0]['data']['Tags'].append({'Key'        : 'Version'             , 'Value' : 'test'})
    result['volumes'][0]['data']['Tags'].append({'Key'        : 'Project'             , 'Value' : 'test'})
    result['volumes'][0]['data']['Tags'].append({'Key'        : 'Module'              , 'Value' : 'test'})
    result['volumes'][0]['data']['Tags'].append({'Key'        : 'Environment'         , 'Value' : 'test'})
    result['volumes'][0]['data']['Tags'].append({'Key'        : 'Owner'               , 'Value' : 'moi.moi@moi.fr'})
    result['volumes'][0]['data']['Tags'].append({'Key'        : 'Name'                , 'Value' : 'test.test.test.' + region + '.test.ebs'})

    return result