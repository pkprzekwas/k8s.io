#!/bin/sh

set -euo pipefail

export SERVICE=s3
export RELEASE_VERSION=`curl -sL https://api.github.com/repos/aws-controllers-k8s/$SERVICE-controller/releases/latest | grep '"tag_name":' | cut -d'"' -f4`
export ACK_SYSTEM_NAMESPACE=ack-system
export AWS_REGION=eu-central-1

aws ecr-public get-login-password --region us-east-1 | helm registry login --username AWS --password-stdin public.ecr.aws

helm install \
    --create-namespace \
    -n ${ACK_SYSTEM_NAMESPACE} ack-${SERVICE}-controller \
    --version=${RELEASE_VERSION} \
    --set=aws.region=${AWS_REGION} \
    oci://public.ecr.aws/aws-controllers-k8s/${SERVICE}-chart
