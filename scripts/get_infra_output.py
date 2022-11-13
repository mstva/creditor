import argparse
import subprocess
import json

parser = argparse.ArgumentParser()
parser.add_argument("--env", help="Current Environment")
parser.add_argument("--compose", help="Docker Compose File")
args = parser.parse_args()
env = args.env
compose = args.compose

run_command = f'docker compose -f {compose} run --rm terraform -chdir=src output -json {env}'

process = subprocess.run(run_command, shell=True, stdout=subprocess.PIPE)
result = process.stdout.decode('utf-8')
output = json.loads(result)

for item in output:
    print(f"{item}={output[item]}")


