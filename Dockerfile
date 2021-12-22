FROM alpine:3.15

RUN apk add --no-cache github-cli
COPY entrypoint.sh .

ENTRYPOINT ["/entrypoint.sh"]
