#!/bin/bash

IMAGE=${1:-airflow}
TAG=${2:-latest}
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

rm -rf .tmp/

mkdir -p .tmp && cd .tmp
git clone https://github.com/puckel/docker-airflow.git
cp $DIR/Dockerfile docker-airflow/Dockerfile
cp $DIR/entrypoint.sh docker-airflow/script/entrypoint.sh
cd docker-airflow

docker build --build-arg PYTHON_DEPS="Flask-OAuthlib" --build-arg AIRFLOW_DEPS="kubernetes" --tag=${IMAGE}:${TAG} .

cd ../..
rm -rf .tmp/
