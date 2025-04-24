#!/bin/bash

# -- Preparation -- #
# Go to project dir
PROJECT_DIR=$(dirname $(realpath "$0"))
cd /app

# Source variables
. watcher/.env

# -- Building -- #
echo "⏳ Building new garde image..."
docker build -t "${CONTAINER_NAME}" -f Dockerfile --build-arg GIT_DIR="${PAGE_DIRECTORY}" \
                                                  --label app_name=garden .

# -- Swapping -- #
echo "🔁 Swapping containers..."
sh /app/watcher/cleanup.sh
docker run -d --name "${CONTAINER_NAME}" -p 8080:80 "${CONTAINER_NAME}"

echo "✅ Swap complete."
