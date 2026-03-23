FROM ubuntu:24.04 AS base
WORKDIR /work

RUN apt update 
RUN apt install git \
    curl \
    wget \
    jq -y

RUN apt update && apt upgrade -y

COPY --chmod=777 ./github_runner_command /work

RUN ./github_runner_command

RUN ./actions-runner/bin/installdependencies.sh

RUN chown ubuntu:ubuntu -R /work

USER ubuntu

RUN whoami

ARG GH_PAT
ARG REPO_NAME="docker-build-automation"
RUN ls -la ./actions-runner/

RUN ls -la ./actions-runner/bin/

RUN REG_TOKEN=$(curl -s -X POST \
    -H "Authorization: Bearer ${GH_PAT}" \
    -H "Accept: application/vnd.github+json" \
    https://api.github.com/repos/QHuyNguyen/${REPO_NAME}/actions/runners/registration-token \
    | jq -r .token) && \
    ./actions-runner/config.sh --url https://github.com/QHuyNguyen/docker-build-automation --token ${REG_TOKEN}

CMD ["./run.sh"]
