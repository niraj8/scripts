#!/usr/bin/env bash

# commit additions - substractions for all git repos in ~/Projects
since_date=$1
until_date=$2
author=$3
if [ -z "$since_date" ]; then
    since_date=$(date -v -1d +%Y-%m-%d)
    until_date=$(date +%Y-%m-%d)
fi

if [ -z "$author" ]; then
    author="Niraj Palecha"
fi

total_count=0

git_log_additions() {
    git -C $1 log --author="$author" --since="$since_date" --until="$until_date" --pretty=tformat: --numstat | awk '{ add += $1 - $2 } END { printf "%s\n", add }'
}

count_for_repo() {
    dir=$1
    repo=$(basename $dir)
    org=$(basename "$(dirname $dir)")
    current_branch=$(git -C $dir branch --show-current)
    if [ "$current_branch" != "master" ] && [ "$current_branch" != "main" ]; then
        echo "not main/master $org/$repo : $current_branch"
    fi
    count=$(git_log_additions $dir $author)
    total_count=$((total_count + count))
    # echo "$org/$repo : $current_branch: $count"
}

for dir in ~/Projects/**/*; do
    if [ -d "$dir" ]; then
        if [ -d "$dir/.git" ]; then
            count_for_repo $dir
            # echo $(basename $dir)
            # git_log_additions $dir $author
        fi  
    fi
done

echo $since_date,$total_count
