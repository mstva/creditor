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
headers = {
    "Circle-Token": circle_token,
    "Accept": "application/json",
    "Content-Type": "application/json"
}

conn.request(
    "GET",
    f"/api/v2/context?owner-id={owner_id}",
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

context_vars = json.loads(conn.getresponse().read().decode("utf-8"))

next_context_vars = {}

if context_vars["next_page_token"]:
    page_token = context_vars["next_page_token"]
    conn.request(
        "GET",
        f"/api/v2/context/{context_id}/environment-variable?page-token={page_token}",
        headers=headers
    )
    next_context_vars = json.loads(conn.getresponse().read().decode("utf-8"))

env_vars_list = []

for (key, value), (next_key, next_value) in zip(context_vars.items(), next_context_vars.items()):
    if key == "items" and next_key == "items":
        env_vars_list = value + next_value

env_vars = ""

for item in env_vars_list:
    env_vars += f'{item["variable"]}=${item["variable"]}%s\\n\n'

command = 'mkdir -p crewtech_api/.env;' \
          f'touch crewtech_api/.env/.env.{env};' \
          f'printf "\n{env_vars}" > crewtech_api/.env/.env.{env};'

ret = subprocess.run(command, capture_output=True, shell=True)
print(ret.stdout.decode())
