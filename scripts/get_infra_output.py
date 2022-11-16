import argparse
import subprocess
import json

parser = argparse.ArgumentParser()
parser.add_argument("--env", help="Current Environment")
parser.add_argument("--compose", help="Docker Compose File")
args = parser.parse_args()
env = args.env
compose = args.compose


def get_output(name):
    command = f'docker compose -f {compose} run --rm terraform -chdir=src output -json {name}'
    process = subprocess.run(command, shell=True, stdout=subprocess.PIPE)
    result = process.stdout.decode('utf-8')
    print(f"# {name} output")
    try:
        output = json.loads(result)
        for item in output[env]:
            print(f"{item}={output[env][item]}")
    except Exception as e:
        print(f'No output for digitalocean | {e}\n')


get_output(name="digitalocean")
get_output(name="cloudamqp")

