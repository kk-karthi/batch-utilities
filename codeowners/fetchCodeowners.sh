#!/bin/bash

# Function to prompt for organization name if not provided.
get_org_name() {
    if [ -z "$1" ]; then
        read -p "Enter the GitHub organization name: " org_name
    else
        org_name=$1
    fi
    echo $org_name
}

# Get organization name from the first argument or prompt the user.
org_name=$(get_org_name "$1")

# List all repositories in the organization.
repos=$(gh repo list $org_name --json name -q '.[].name')

# Loop through each repository and try to fetch the CODEOWNERS file.
for repo in $repos; do
    echo "Checking $repo"
    # Attempt to download the CODEOWNERS file from the .github, docs, or root directory.
    for path in ".github/CODEOWNERS" "docs/CODEOWNERS" "CODEOWNERS"; do
        file_content=$(gh api repos/$org_name/$repo/contents/$path --jq '.content' 2>/dev/null)
        
        # If file_content is not empty, a CODEOWNERS file has been found
        if [ -n "$file_content" ]; then
            echo "CODEOWNERS file found in $repo at $path"
            # The file content is base64 encoded, decode it
            echo "$file_content" | base64 --decode
            break  # Exit the loop once we find a CODEOWNERS file
        fi
    done

    if [ -z "$file_content" ]; then
        echo "No CODEOWNERS file found in $repo"
    fi
    
    echo "-------------------------------------"
done
