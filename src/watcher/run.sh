#!/bin/bash

# -- Preparation -- #
# Go to project dir
PROJECT_DIR=$(dirname $(realpath "$0"))
cd "$PROJECT_DIR"
# Source variables
. .env
# Get site dir
SITE_DIR="${PAGE_DIRECTORY:-site}"
# Go to git dir
cd /app/"$SITE_DIR"
# Set site directory as safe
git config --add safe.directory /app/site

# Build latest version & ensure running
sh /app/watcher/builder.sh

# -- Clean-up trap -- #
exitfn () {
    trap SIGINT  # Restore signal handling for SIGINT.
    echo "🔄 Cleaning Up..."
    bash /app/watcher/cleanup.sh
    exit
}

trap "exitfn" INT

# -- Watcher Loop -- #
while true; do
    sleep $WATCHER_INTERVAL
    echo "🔄 Checking for updates..."
    # Get number of commits local is behind
    git fetch
    behind=$(git rev-list --count HEAD..origin/$(git rev-parse --abbrev-ref HEAD))

    if [ "$behind" -gt 0 ]; then
        echo "🚀 New version detected. Pulling and rebuilding..."
        git pull
        bash /app/watcher/builder.sh
    else
        echo "✅ No changes detected."
    fi
done
