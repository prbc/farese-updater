# FROM alpine:latest

# # For 
# RUN date

# RUN apk add --no-cache github-cli
# COPY bootstrap .
# COPY function.sh .

# # ENTRYPOINT ["/function.sh"]
# CMD ["echo", "hi"]

FROM public.ecr.aws/lambda/provided:al2

# Install the github-cli
ARG GITHUB_CLI_VERSION=2.14.2
ARG GITHUB_CLI_FILE_NAME=gh_${GITHUB_CLI_VERSION}_linux_amd64.rpm
RUN yum install -y git && \
    curl -LO https://github.com/cli/cli/releases/download/v$GITHUB_CLI_VERSION/$GITHUB_CLI_FILE_NAME && \
    rpm -i $GITHUB_CLI_FILE_NAME && \
    rm $GITHUB_CLI_FILE_NAME

COPY bootstrap /var/runtime/bootstrap
COPY function.sh /var/task/function.sh

CMD [ "function.sh.handler" ]
