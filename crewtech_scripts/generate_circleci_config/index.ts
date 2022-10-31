import {WorkflowJobParameters} from "@circleci/circleci-config-sdk/dist/src/lib/Components/Workflow/types";

const CircleCI = require('@circleci/circleci-config-sdk');
const fs = require('fs');
const argv = require('minimist')(process.argv.slice(2));

const circleci_config = new CircleCI.Config()

const deploy_workflow = new CircleCI.Workflow("deploy")

circleci_config.addWorkflow(deploy_workflow)

const ENV = {
    DEVELOPMENT: "development",
    STAGING: "staging",
    PRODUCTION: "production",
}

const create_job = (env: string) => {
    const ubuntu_executor = new CircleCI.executors.MachineExecutor(
        "large", "ubuntu-2204:2022.10.1"
    )
    return new CircleCI.Job(
        `deploy_${env}_environment`, ubuntu_executor
    )
}

const get_steps = (env: string) => {
    return {
        set_environment_variables: {
            name: "Set the environment variables",
            command: `python3 crewtech_scripts/set_env_vars.py --env=${env} --token=$CIRCLE_TOKEN --owner=$OWNER_ID`
        },
        push_the_code: {
            name: "Push the code",
            command: `rsync -r --progress --stats crewtech_api crewtech_scripts/run_app.py root@$SERVER_IP:/root/crewtech`

        },
        run_the_script: {
            name: "Run the script",
            command: `ssh root@$SERVER_IP 'python3 crewtech/run_app.py --e=${env}'`
        },
    }
}

const get_parameters = (env: string) => {
    const parameters: WorkflowJobParameters = {
        context: ["crewtech_common_context", `crewtech_${env}_context`],
        filters: {branches: {only: ["main"]}},
    }

    parameters.requires = []

    if (env === ENV.STAGING) {
        parameters.requires!.push(`deploy_${ENV.DEVELOPMENT}_environment`)
    }
    if (env === ENV.PRODUCTION) {
        parameters.requires!.push(`deploy_${ENV.STAGING}_environment`)
    }

    return parameters
}

const build_job = (env: string) => {
    const job = create_job(env)
    circleci_config.addJob(job)
    const steps = get_steps(env)
    job.addStep(new CircleCI.commands.Checkout())
    job.addStep(new CircleCI.commands.Run(steps.set_environment_variables))
    job.addStep(new CircleCI.commands.Run(steps.push_the_code))
    job.addStep(new CircleCI.commands.Run(steps.run_the_script))
    deploy_workflow.addJob(job, get_parameters(env))
}

build_job(ENV.DEVELOPMENT)
build_job(ENV.STAGING)
build_job(ENV.PRODUCTION)

const yml_config = circleci_config.stringify();


fs.writeFileSync(argv.f, yml_config, {flag: 'w',});
fs.readFileSync(argv.f, 'utf-8');

