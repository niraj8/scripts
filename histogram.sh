#!/bin/bash

data=$(cat data/loc.csv)

# Function to print a horizontal bar for the histogram
print_bar() {
    local bar=""
    local length=$1
    for ((i = 0; i < length; i+=15)); do
        bar+="█"
    done
    echo -n "$bar"
}

# Process the data and create the histogram
echo "Date       | Data Value | Histogram"
echo "-------------------------------------"
while IFS= read -r line; do
    date=$(echo "$line" | cut -d ',' -f 1)
    value=$(echo "$line" | cut -d ',' -f 2)
    printf "%-10s | %-10s | " "$date" "$value"
    print_bar "$value"
    # echo " ($value)"
done <<< "$data"
