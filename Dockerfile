FROM alpine

RUN apk add --no-cache \
      bash \
      curl

# To prevent the error:
#   Error: the working directory '' is invalid, it needs to be an absolute path
WORKDIR /

COPY entrypoint.sh .

ENTRYPOINT ["/entrypoint.sh"]
