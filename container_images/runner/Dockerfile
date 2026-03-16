FROM alpine:latest as build
WORKDIR /work
RUN apk add --update --upgrade --no-cache \
    curl \
    ca-certificates \
    git \
    openssh-client \
    tree \
    aws-cli

CMD echo "TESTING SUCCESS"
