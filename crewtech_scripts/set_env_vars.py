#!/usr/bin/python

import argparse
import http.client
import json
import subprocess

parser = argparse.ArgumentParser()

parser.add_argument("--env", help="Current Environment")
parser.add_argument("--token", help="CircleCI Token")
parser.add_argument("--owner", help="CircleCI Owner ID")

args = parser.parse_args()

circle_token = args.token
owner_id = args.owner
env = args.env

context_id = ""

conn = http.client.HTTPSConnection("circleci.com")
headers = {"Circle-Token": circle_token}

conn.request(
    "GET",
    f"/api/v2/context?owner-id={owner_id}?page-token={circle_token}",
    headers=headers
)

context_list = json.loads(conn.getresponse().read().decode("utf-8"))

for item in context_list["items"]:
    if env in item["name"]:
        context_id = item["id"]

conn.request(
    "GET",
    f"/api/v2/context/{context_id}/environment-variable?page-token={circle_token}",
    headers=headers
)

context_environment_variables = json.loads(conn.getresponse().read().decode("utf-8"))

env_vars = ""

for item in context_environment_variables["items"]:
    env_vars += f'{item["variable"]}=${item["variable"]}%s\\n\n'

command = 'mkdir -p crewtech_api/.env;' \
          f'touch crewtech_api/.env/.env.{env};' \
          f'printf "\n{env_vars}" > crewtech_api/.env/.env.{env};'

ret = subprocess.run(command, capture_output=True, shell=True)
print(ret.stdout.decode())
