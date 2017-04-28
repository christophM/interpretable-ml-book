#!/bin/sh
set -e # Exit with nonzero exit code if anything fails


# Copied from here: https://gist.github.com/domenic/ec8b0fc8ab45f39403dd

SOURCE_BRANCH="master"
TARGET_BRANCH="master"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    ./_build.sh
    exit 0
fi


# Clone the existing gh-pages for this repo into out/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deply)
git clone -b $TARGET_BRANCH https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git out
cd out
# Run our compile script
chmod +x ./_build.sh
./_build.sh
git add --all *


# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" > .git/credentials
git commit -m "Update book"


# Now that we're all set up, we can push.
git push origin $TARGET_BRANCH
