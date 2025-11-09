#!/usr/bin/env bash

DOCKERHUB_USER="1jashshah"
TAG="v1"

docker build -t ${DOCKERHUB_USER}/book-service:${TAG} services/book-service
docker push ${DOCKERHUB_USER}/book-service:${TAG}

docker build -t ${DOCKERHUB_USER}/user-service:${TAG} services/user-service
docker push ${DOCKERHUB_USER}/user-service:${TAG}

echo "Built and pushed images. Update app-deployment manifests if you used a different tag or repo."

