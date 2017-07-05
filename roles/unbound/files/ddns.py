#!/usr/bin/env python3
import os
import sys
import json
import boto3
import platform
import traceback
import subprocess
from datetime import datetime

config = {}
with open(os.path.expanduser('~/.ddns.conf')) as conf:
    config.update(json.load(conf))

ZONE_ID = config['zone_id']
ROOT = config['root']
HOST = config.get('host', platform.uname().node.split('.')[0])
TTL = config.get('ttl', 300)

session = boto3.Session(profile_name='personal')
r53 = session.client('route53')

def dig_ip(hostname):
    cmd = f'dig +short {hostname} @resolver1.opendns.com'.split(' ')
    try:
        return subprocess.check_output(cmd).decode('utf-8').strip()
    except Exception as exc:
        print(f'{datetime.utcnow().isoformat()}+UTC Failed to read DNS name - bailing out')
        traceback.print_exc()
        sys.exit(1)

def my_ip():
    return dig_ip('myip.opendns.com')

def change_recordset(current_ip):
    resp = r53.change_resource_record_sets(
        HostedZoneId=ZONE_ID,
        ChangeBatch={
            'Comment': f'Automatic DDNS change {datetime.utcnow().isoformat()}+UTC',
            'Changes': [{
                'Action': 'UPSERT',
                'ResourceRecordSet': {
                    'Name': '.'.join((HOST, ROOT)),
                    'Type': 'A',
                    'TTL': TTL,
                    'ResourceRecords': [{'Value': current_ip}]
                }
            }]
        }
    )

    print(f'{datetime.utcnow().isoformat()}+UTC Submitted change request: {resp}')

def main():
    current_ip = my_ip()
    r53_ip = dig_ip('.'.join((HOST, ROOT)))
    if current_ip != r53_ip:
        print(f'{datetime.utcnow().isoformat()}+UTC Mismatch alert, {r53_ip} does not match {current_ip}')
        change_recordset(current_ip)
    else:
        print(f'{datetime.utcnow().isoformat()}+UTC All good - IP is updated in R53')

if __name__ == '__main__':
    main()
