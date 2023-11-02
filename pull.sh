#!/usr/bin/env bash

# pull --rebase all git repos in ~/Projects
for dir in ~/Projects/**/*; do
    if [ -d "$dir" ]; then
        if [ -d "$dir/.git" ]; then
            repo=$(basename $dir)
            org=$(basename "$(dirname $dir)")
            current_branch=$(git -C $dir branch --show-current)
            echo "$org/$repo: $current_branch"
            git -C $dir pull --rebase
        fi
    fi
done
