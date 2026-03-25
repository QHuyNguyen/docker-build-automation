FROM ubuntu:22.04 AS build
WORKDIR /work

RUN apt update && apt install git \
    curl \
    ca-certificates -y --no-install-recommends \
    && update-ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --chmod=777 ./github_runner_command .

# Download and extract GitHub Actions runner
RUN ./github_runner_command

FROM ubuntu:22.04 AS runtime

RUN adduser ubuntu && \
    mkdir -p /home/ubuntu && \
    chown -R ubuntu:ubuntu /home/ubuntu

#Ensure the 'ubuntu' user owns EVERYTHING in /actions-runner before switchin user
RUN mkdir /actions-runner && chown ubuntu:ubuntu /actions-runner

WORKDIR /actions-runner

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    jq \
    ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy runner from build stage
COPY --from=build --chown=ubuntu:ubuntu /work/actions-runner .

# Install any missing dependencies for .NET Core (required by runner)
RUN ./bin/installdependencies.sh

USER ubuntu

# GitHub PAT and repo name will be injected at runtime
ARG GH_PAT
ENV GH_PAT=$GH_PAT

ENV REPO_NAME="docker-build-automation"

COPY --chmod=777 ./entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh" ]
