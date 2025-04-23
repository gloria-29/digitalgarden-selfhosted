#!/bin/bash

# -- Preparation -- #
# Go to project dir
PROJECT_DIR=$(dirname $(realpath "$0"))
cd "$PROJECT_DIR"
# Source variables
source .env
# Get site dir
SITE_DIR="${PAGE_DIRECTORY:-site}"
# Go to git dir
cd "$PROJECT_DIR"/"$SITE_DIR"

# Build latest version & ensure running
bash "$PROJECT_DIR"/builder.sh


exitfn () {
    trap SIGINT  # Restore signal handling for SIGINT.
    echo "🔄 Cleaning Up..."
    bash "$PROJECT_DIR"/cleanup.sh
    exit
}

trap "exitfn" INT

## -- Watcher Loop -- #
while true; do
    sleep $WATCHER_INTERVAL
    echo "🔄 Checking for updates..."
    # Get number of commits local is behind
    git fetch
    behind=$(git rev-list --count HEAD..origin/$(git rev-parse --abbrev-ref HEAD))

    if [ "$behind" -gt 0 ]; then
        echo "🚀 New version detected. Pulling and rebuilding..."
        git pull
        bash "$PROJECT_DIR"/builder.sh
    else
        echo "✅ No changes detected."
    fi
done
