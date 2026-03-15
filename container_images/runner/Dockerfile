FROM alpine:latest as build
WORKDIR /work
RUN apk add --update --upgrade --no-cache \
    curl \
    ca-certificates \
    git \
    openssh-client \
    tree \
    aws-cli
    
COPY --chmod=777 ./terraform_command /work
RUN ./terraform_command
#COPY ./Devops /work
#ca-certificate - it is a digital certificate that is used to verify the identity of 3rd parties, and encrypt data between you and said 3rd party.

CMD ["/bin/sh"]
