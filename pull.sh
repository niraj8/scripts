#!/usr/bin/env bash

# pull --rebase all git repos in ~/Projects
for dir in ~/Projects/**/*; do
    if [ -d "$dir" ]; then
        if [ -d "$dir/.git" ]; then
            git -C $dir pull --rebase
        fi
    fi
done
