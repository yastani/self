# -*- coding: utf-8 -*-

from __future__ import print_function, unicode_literals

import os
import sys
import base64
import json
import zlib
import datetime
import requests
import re
import yaml
import boto3

sys.setdefaultencoding('utf-8')

print('Loading function')

def get_s3object():
    s3 = boto3.client('s3')
    obj = s3.get_object(Bucket='hoge', Key='config.yml')

    return obj

def get_api_key(yaml_data):
    chatwork_api_key = yaml_data['params']['webhooks'][os.environ['NOTIFY']]['api_key']

    return chatwork_api_key

def get_endpoint(yaml_data):
    chatwork_endpoint = yaml_data['params']['environments'][os.environ['ENVIRONMENT']][os.environ['SERVICENAME']]['notify_endpoint']

    return chatwork_endpoint

def get_filter_word_lists(yaml_data):
    pattern_lists = []
    pattern_lists = yaml_data['params']['environments'][os.environ['ENVIRONMENT']][os.environ['SERVICENAME']]['filter_pattern']['match_words']

    return pattern_lists

def get_exclude_lists(yaml_data):
    exclude_lists = []
    exclude_lists = yaml_data['params']['environments'][os.environ['ENVIRONMENT']][os.environ['SERVICENAME']]['filter_pattern']['exclude_log_streams']

    return exclude_lists

def format_messages(data, data_json, log_json):
    date = datetime.datetime.fromtimestamp(int(str(log_json["timestamp"])[:10])) + datetime.timedelta(hours=9)
    messages = "--------------- New error is recorded. ---------------\n"
    messages += "Owner : " +  data_json["owner"] + "\n"
    messages += "LogGroup : " + data_json["logGroup"] + "\n"
    messages += "LogStream : " + data_json["logStream"] + "\n"
    messages += "SubscriptionFilters : " + ''.join(data_json["subscriptionFilters"]) + "\n"
    messages += "Time : " +  date.strftime('%Y-%m-%d %H:%M:%S') + "\n"
    messages += "Message : " + log_json['message'] + "\n"
    messages += "---------------------------------------------------------\n"
    chatwork_body = {'body': messages}

    return chatwork_body

def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))
    data = zlib.decompress(base64.b64decode(event['awslogs']['data']), 16+zlib.MAX_WBITS)
    data_json = json.loads(data)
    log_json = json.loads(json.dumps(data_json["logEvents"][0], ensure_ascii=False))

    obj = get_s3object()
    yaml_data = yaml.load(obj['Body'].read())
    pattern_lists = get_filter_word_lists(yaml_data)
    exclude_lists = get_exclude_lists(yaml_data)

    if not exclude_lists is None:
        for exclude_target in exclude_lists:
            if exclude_target in data_json["logStream"]:
                print("Since this log stream is an object to be excluded, processing is terminated.")
                sys.exit()

    for pattern_word in pattern_lists:
        repatter = re.compile(pattern_word, re.IGNORECASE)
        matches = repatter.search(log_json['message'])
        if not matches is None:
            chatwork_endpoint = get_endpoint(yaml_data)
            chatwork_headers = {"X-ChatWorkToken": get_api_key(yaml_data)}
            chatwork_body = format_messages(data, data_json, log_json)

            resp = requests.post(
                chatwork_endpoint,
                headers=chatwork_headers,
                params=chatwork_body
            )
            print(resp.content)

    return 'Successfully processed {} records.'.format(len(event['awslogs']))