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
    const image = "crewtech"
    return {
        login_to_docker_hub: {
            name: "Login to docker hub",
            command: `echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin`
        },
        build_docker_image: {
            name: "Build a docker image",
            command: `docker build -t $DOCKERHUB_USERNAME/${image}:${env} -f crewtech_api/Dockerfile crewtech_api`
        },
        push_to_docker_hub: {
            name: "Push to docker hub",
            command: `docker push $DOCKERHUB_USERNAME/${image}:${env}`
        },
        get_env_vars_from_circleci: {
            name: "Get the environment variables from CircleCI",
            command: `python3 crewtech_scripts/get_circleci_env.py --env=${env} --token=$CIRCLE_TOKEN --owner=$OWNER_ID`
        },
        copy_env_and_script_to_server: {
            name: "Copy the env file and run script to the server",
            command: `rsync .env.${env} crewtech_scripts/run_containers.py root@$SERVER_IP:/root`
        },
        run_the_script: {
            name: "Run the script",
            command: `ssh root@$SERVER_IP 'python3 run_containers.py --env=${env} --image=$DOCKERHUB_USERNAME/${image}'`
        },
    }
}

const get_parameters = (env: string) => {
    const parameters: WorkflowJobParameters = {
        context: ["crewtech-common-context", `crewtech-${env}-context`],
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
    job.addStep(new CircleCI.commands.Run(steps.login_to_docker_hub))
    job.addStep(new CircleCI.commands.Run(steps.build_docker_image))
    job.addStep(new CircleCI.commands.Run(steps.push_to_docker_hub))
    job.addStep(new CircleCI.commands.Run(steps.get_env_vars_from_circleci))
    job.addStep(new CircleCI.commands.Run(steps.copy_env_and_script_to_server))
    job.addStep(new CircleCI.commands.Run(steps.run_the_script))
    deploy_workflow.addJob(job, get_parameters(env))
}

build_job(ENV.DEVELOPMENT)
build_job(ENV.STAGING)
build_job(ENV.PRODUCTION)

const yml_config = circleci_config.stringify();


fs.writeFileSync(argv.f, yml_config, {flag: 'w',});
fs.readFileSync(argv.f, 'utf-8');

