#!/bin/bash

# -- Preparation -- #
# Go to project dir
PROJECT_DIR=$(dirname $(realpath "$0"))
cd "$PROJECT_DIR"

# Source variables
source .env

# Check if container is running
if docker ps --format "{{.Names}}" | grep -q "${CONTAINER_NAME}"; then
    docker stop "$CONTAINER_NAME" &>/dev/null || true
fi
# Remove existing containers
if docker container ls -a  --format "{{.Names}}" | grep -q "${CONTAINER_NAME}"; then
    docker rm "$CONTAINER_NAME" &>/dev/null || true
fi
