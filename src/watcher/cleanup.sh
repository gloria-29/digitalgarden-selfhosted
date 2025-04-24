#!/bin/bash

# -- Preparation -- #
# Go to project dir
PROJECT_DIR=$(dirname $(realpath "$0"))
cd "$PROJECT_DIR"

# Source variables
if [ -f .env ]; then
. .env
fi
# Check if container is running
if docker ps --format "{{.Names}}" | grep -q "${CONTAINER_NAME}"; then
    echo "🚫 Stopping running container"
    docker stop "$CONTAINER_NAME" &>/dev/null || true
fi
# Remove existing containers
if docker container ls -a  --format "{{.Names}}" | grep -q "${CONTAINER_NAME}"; then
    echo "🗑️ Removing container"
    docker rm "$CONTAINER_NAME" &>/dev/null || true
fi

# Pruning unused containers
for img in $(docker images --filter "dangling=true" --quiet); do
    if docker inspect "$img" | grep -q '"app_name": "garden"'; then
        echo "🧹 Removing dangling garden image: $img"
        docker rmi "$img"
    fi
done
