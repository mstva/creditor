#!/usr/bin/python

import argparse
import subprocess
import sys

parser = argparse.ArgumentParser()

parser.add_argument("--e", help="Current Environment")
parser.add_argument("--l", help="Is Local?")

args = parser.parse_args()

env = args.e
local = args.l

crewtech_path = ""

if local == "local":
    crewtech_path = ""
else:
    crewtech_path = "crewtech/"

run_command = f'docker compose -f {crewtech_path}crewtech_api/.docker-compose/{env}.yml up -d --build;' \
              f'docker image prune -f --filter="dangling=true";' \
              'docker ps --format "{{.Names}} ===== {{.Status}}";' \
              f'docker logs crewtech_{env}_django;'

process = subprocess.run(
    run_command,
    encoding="utf-8",
    shell=True,
    stdout=subprocess.PIPE,
)
for line in process.stdout:
    sys.stdout.write(line)
