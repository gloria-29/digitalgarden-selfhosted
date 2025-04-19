#!/bin/bash

# -- Preparation -- #
# Go to project dir
PROJECT_DIR=$(dirname $(realpath "$0"))
cd "$PROJECT_DIR"

# Source variables
source .env

# -- Building -- #
echo "⏳ Building new garde image..."
docker build -t "${CONTAINER_NAME}" -f Dockerfile .

# -- Swapping -- #
echo "🔁 Swapping containers..."
bash "$PROJECT_DIR"/cleanup.sh
docker run -d --name "${CONTAINER_NAME}" -p 8080:80 "${CONTAINER_NAME}"

echo "✅ Swap complete."
