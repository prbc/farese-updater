FROM alpine

RUN apk add \
      bash \
      curl \
      git \
      jq \
      --no-cache

# To prevent the error:
#   Error: the working directory '' is invalid, it needs to be an absolute path
WORKDIR /

COPY entrypoint.sh .

ENTRYPOINT ["/entrypoint.sh"]
