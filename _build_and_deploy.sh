#!/bin/sh
set -e # Exit with nonzero exit code if anything fails


# Copied from here: https://gist.github.com/domenic/ec8b0fc8ab45f39403dd

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

BUILD_COMMIT_MSG="Build book"

if [ "$TRAVIS_COMMIT_MESSAGE" = "$BUILD_COMMIT_MSG" ]; then
  echo "Skipping build; last commit was a build commit."
  exit 0
fi



# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    ./_build.sh
    exit 0
fi


# Run compile script
Rscript --vanilla -e "bookdown::render_book('./', 'bookdown::gitbook')"


# Clone the existing gh-pages for this repo into out/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deply)
git clone -b $TARGET_BRANCH https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git out
cd out
git rm -rf *
cp -r ../_book/* ./
git add --all *


# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" > .git/credentials
git commit -m "${BUILD_COMMIT_MSG}"

# Now that we're all set up, we can push.
git push origin $TARGET_BRANCH
