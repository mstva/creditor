import {WorkflowJobParameters} from "@circleci/circleci-config-sdk/dist/src/lib/Components/Workflow/types";

const CircleCI = require('@circleci/circleci-config-sdk');
const fs = require('fs');
const argv = require('minimist')(process.argv.slice(2));

const circleci_config = new CircleCI.Config()

const deploy_workflow = new CircleCI.Workflow("deploy")
circleci_config.addWorkflow(deploy_workflow)

const resource_class = "large"
const image = "ubuntu-2204:2022.10.1"
const ubuntu = new CircleCI.executors.MachineExecutor(resource_class, image)

const run_unit_tests_job = () => {
    const job = new CircleCI.Job(`run_unit_tests`, ubuntu)
    circleci_config.addJob(job)
    job.addStep(new CircleCI.commands.Checkout())
    job.addStep(new CircleCI.commands.Run({
        name: "Install Poetry", command: `pip3 install poetry`
    }))
    job.addStep(new CircleCI.commands.Run({
        name: "Install Packages",
        working_directory: "backend",
        command: `poetry install`,
    }))
    job.addStep(new CircleCI.commands.Run({
        name: "Run Pytest",
        working_directory: "backend",
        command: `ls -a`
    }))
    return job
}

deploy_workflow.addJob(run_unit_tests_job(), {filters: {branches: {only: ["main"]}}})

const ENV = {
    DEVELOPMENT: "development",
    STAGING: "staging",
    PRODUCTION: "production",
}
const ENV_LIST = [ENV.DEVELOPMENT, ENV.STAGING, ENV.PRODUCTION]

const get_steps = (env: string) => {
    const image = "crewtech"
    return {
        login_to_docker_hub: {
            name: "Login to docker hub",
            command: `echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin`
        },
        build_docker_image: {
            name: "Build a docker image",
            command: `docker build -t $DOCKERHUB_USERNAME/${image}:${env} -f backend/Dockerfile backend`
        },
        push_to_docker_hub: {
            name: "Push to docker hub",
            command: `docker push $DOCKERHUB_USERNAME/${image}:${env}`
        },
        get_env_vars_from_circleci: {
            name: "Get the environment variables from CircleCI",
            command: `python3 scripts/get_circleci_env.py --env=${env} --token=$CIRCLE_TOKEN --owner=$CIRCLE_OWNER_ID`
        },
        append_docker_username_to_env: {
            name: "Append docker username to env file",
            command: `echo "DOCKERHUB_USERNAME=$DOCKERHUB_USERNAME" >> .env.${env}`
        },
        copy_env_and_script_to_server: {
            name: "Copy the env file and run script to the server",
            command: `rsync .env.${env} scripts/run_containers.py root@$SERVER_IP:/root`
        },
        run_the_script: {
            name: "Run the script",
            command: `ssh root@$SERVER_IP 'source .env.${env} && python3 run_containers.py --env=${env} --image=$DOCKERHUB_USERNAME/${image}'`
        },
    }
}

const get_parameters = (env: string) => {
    const parameters: WorkflowJobParameters = {
        context: ["crewtech-common-context", `crewtech-${env}-context`],
        filters: {branches: {only: ["main"]}},
    }

    parameters.requires = ['run_unit_tests']

    if (env === ENV.STAGING) {
        parameters.requires!.push(`deploy_${ENV.DEVELOPMENT}_environment`)
    }
    if (env === ENV.PRODUCTION) {
        parameters.requires!.push(`deploy_${ENV.STAGING}_environment`)
    }

    return parameters
}

ENV_LIST.map((env: string) => {

    // Deploy Jobs
    const job = new CircleCI.Job(`deploy_${env}_environment`, ubuntu)
    circleci_config.addJob(job)
    job.addStep(new CircleCI.commands.Checkout())
    job.addStep(new CircleCI.commands.Run(get_steps(env).login_to_docker_hub))
    job.addStep(new CircleCI.commands.Run(get_steps(env).build_docker_image))
    job.addStep(new CircleCI.commands.Run(get_steps(env).push_to_docker_hub))
    job.addStep(new CircleCI.commands.Run(get_steps(env).get_env_vars_from_circleci))
    job.addStep(new CircleCI.commands.Run(get_steps(env).append_docker_username_to_env))
    job.addStep(new CircleCI.commands.Run(get_steps(env).copy_env_and_script_to_server))
    job.addStep(new CircleCI.commands.Run(get_steps(env).run_the_script))

    // Workflow
    deploy_workflow.addJob(job, get_parameters(env))

})

const yml_config = circleci_config.stringify();

fs.writeFileSync(argv.f, yml_config, {flag: 'w'});
fs.readFileSync(argv.f, 'utf-8');

