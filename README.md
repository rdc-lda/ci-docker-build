# CI build Docker: build Docker image

CI Docker which builds docker images.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

In order to develop / test, you need the following tools installed:

* [Docker](https://docs.docker.com/docker-for-mac/install/)
* [GNU Make](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) 3.8 or higher

## Built With

* Docker

### Build Docker

~~~bash
# Build the Docker locally
#  -- see output how to run this Docker on your machine
$ make image

# Push Docker to the Docker Registry
$ make push
~~~

## Deployment

Use the Docker image in your CI tooling - you need to specify the following as part of your build:

* `release-manifest.json` - defines the set of artefacts to be included in the release.

### Release manifest definition

A release consists of a name, version, type (full or update), description and a list of artefacts:

~~~yaml
{
   "name": "my-release",
   "version": "x.y.z",
   "type": "full",
   "description": "Adds features a, b, c.",
   "platform": "openshift",
   "artefacts": {
      "artefact": [
         {
            "name": "my-web-app",
            "version": "x.y.z"
         },
         {
            "name": "my-service-1",
            "version": "x.y.z"
         },
         {
            "name": "my-service-2",
            "version": "x.y.z"
         }
      ]
   }
}
~~~

### CircleCI - build release

Just copy the YAML into your build definition:

~~~yaml
jobs:

  # Validate the downloaded release
  deploy_release:
    docker:
      - image: rdclda/ci-docker-build
    working_directory: ~/release
    steps:
      - attach_workspace:
          # Must be absolute path or relative path from working_directory
          at: ~/release

      # Retrieve the artefacts
      - run:
          name: Validate the artefacts
          command: |
            validate-release \
              --source=./artefacts \
              --manifest=./artefacts/release-manifest.json
~~~

...and enable to export step in the overall flow:

~~~yaml
# TODO
~~~

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/rdc-lda/fintech-blogs/tags).

## Authors

* **Robin Huiser** - *Initial work* - [robinhuiser](https://github.com/robinhuiser)

See also the list of [contributors](CONTRIBUTORS.md) who participated in this project.

## License

This project is licensed under the Apache License - see the [LICENSE](LICENSE) file for details