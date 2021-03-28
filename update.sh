#!/bin/sh

set -o errexit

echo "Building image"
docker build --no-cache -t 660423837417.dkr.ecr.us-east-1.amazonaws.com/farese-updater .

echo "Pushing image"
docker push 660423837417.dkr.ecr.us-east-1.amazonaws.com/farese-updater:latest

export AWS_REGION=us-east-1

echo "Updating test lambda"
aws lambda update-function-code --function-name farese-updater --image-uri 660423837417.dkr.ecr.us-east-1.amazonaws.com/farese-updater:latest

echo -n "Waiting until ready"
until [[ "$(aws lambda get-function --function-name farese-updater --query 'Configuration.LastUpdateStatus' --output text)" == "Successful" ]]
do
  sleep 1
  echo -n "."
done

echo ""

sleep 5

aws lambda invoke --function-name farese-updater --log-type Tail --query LogResult --output text output.log | base64 -d
