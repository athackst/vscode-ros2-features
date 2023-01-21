#!/bin/bash

# Initialize variables for version and filename
version=""
filename=""

# Parse command line arguments
while getopts "v:f:" opt; do
  case $opt in
    v) version="$OPTARG"
    ;;
    f) filename="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac
done

# Check if both flags were provided
if [ -z "$version" ] || [ -z "$filename" ]; then
    echo "Please provide both -v for version and -f for file name."
    exit 1
fi

# Get the current version from the file
current_version=$(grep -oP '"version": "\K(.*)(?=")' $filename)

# Replace the old version with the new version in the file
sed -i "s/\"version\": \"$current_version\"/\"version\": \"$version\"/g" $filename
