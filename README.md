# garden-of-intelligence
Personal project

## Requirements

To access the AWS from your local machine you have to configure the AWS CLI [documentation] https://doc.babbel.com/lessonnine/guides.doc/tooling/aws.html#access-from-local-machine

Add token for private gems and packages to your shell variables using Babbel's [documentation](https://doc.babbel.com/lessonnine/guides.doc/tooling/github-packages.html).


[Install Docker](https://docs.docker.com/get-docker/), open it and navigate to `Settings --> Resources` and increase the memory value to **4 GB**, if the default value is higher than `4GB`, you can leave as is.

To use terraform install `tfenv`. Then use that to install terraform.

## Docker

To spin up the Docker containers run:

```sh
docker-compose up -d
```

To stop containers

```sh
docker-compose down
```

To rebuild containers

```sh
docker-compose build --no-cache
```

The app will start on port `3044`

# Running commands

>If you run the commands from the local machine Terminal instead, prefix them with `docker-compose exec lms-app`.

Run the tests as follows:

```sh
bundle exec rspec
```

Run the linters

```sh
bundle exec rubocop
bundle exec rubocop -A
```

Run rails console:
```sh
bundle exec rails console
```

## Terraform CLI
`tfenv use`
`terraform init`
`terraform apply`


`terraform validate`
Check whether the configuration is valid // also done by plan & apply

`terraform fmt`
Reformat your configuration in the standard style
=>  pre-commit hook

`terraform show`
Show the current state or a saved plan

`terraform plan`
creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. By default, when Terraform creates a plan it:
- Check whether the configuration is valid
- Reads the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
- Compares the current configuration to the prior state and noting any differences.
- Proposes a set of change actions that should, if applied, make the remote objects match the configuration.

`terraform apply`
performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, unless it was explicitly told to skip approval.
- Check whether the configuration is valid