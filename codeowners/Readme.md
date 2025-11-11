Here's how you can set this up and execute it:

## Prerequisites

1. Install GitHub CLI: In Mac using homebrew, brew install gh

  Follow the official installation instructions for your operating system at GitHub CLI Installation : https://github.com/cli/cli#installation

2. Authenticate GitHub CLI:

  gh auth login

Ensure you have appropriate permissions:
Make sure the authenticated user has permissions to access the repositories you want to query.

# Get CodeOwners in all repos

bash fetchCodeowners.sh                    # Prompts for input
bash fetchCodeowners.sh your_org_name      # Provide an org name directly
