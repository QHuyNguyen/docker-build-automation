#!/bin/bash
set -e

if [ -z "$GH_PAT" ]; then
    echo "GH_PAT is required"
    exit 1
fi

REG_TOKEN=$(curl -s -X POST \
    -H "Authorization: Bearer ${GH_PAT}" \
    -H "Accept: application/vnd.github+json" \
    https://api.github.com/repos/QHuyNguyen/${REPO_NAME}/actions/runners/registration-token \
    | jq -r .token)

echo "GH_PAT length: ${#GH_PAT}"

./config.sh --url https://github.com/QHuyNguyen/${REPO_NAME} --token ${REG_TOKEN}

exec ./run.sh