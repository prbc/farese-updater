#!/bin/sh

set -o errexit

# Referenced:
#   https://docs.aws.amazon.com/lambda/latest/dg/runtimes-walkthrough.html

HEADERS="$(mktemp)"

# Get an event. The HTTP request will block until one is received
EVENT_DATA=$(curl -sS -LD "$HEADERS" -X GET "http://${AWS_LAMBDA_RUNTIME_API}/2018-06-01/runtime/invocation/next")

# Extract request ID by scraping response headers received above
REQUEST_ID=$(grep -Fi Lambda-Runtime-Aws-Request-Id "$HEADERS" | tr -d '[:space:]' | cut -d: -f2)

###############################
# Start Farese church updater #
###############################


echo test






#############################
# End Farese church updater #
#############################

# Send the response
curl -s -X POST "http://${AWS_LAMBDA_RUNTIME_API}/2018-06-01/runtime/invocation/$REQUEST_ID/response" -d "complete"
