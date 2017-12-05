#!/bin/sh
set -e # Exit with nonzero exit code if anything fails


# Copied from here: https://gist.github.com/domenic/ec8b0fc8ab45f39403dd

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

BUILD_COMMIT_MSG="Update book (travis build ${TRAVIS_BUILD_NUMBER})"

BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)

# Run compile script
Rscript --vanilla -e "bookdown::render_book('./', 'bookdown::gitbook')"

## Only deploy when on master branch of main repository
if [ ["$TRAVIS_PULL_REQUEST" = "false" AND "$BRANCH"="master"]]; then
  # Clone the existing gh-pages for this repo into out/
  # Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deply)
  git clone -b $TARGET_BRANCH https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git out
  cd out
  git rm -rf *
  cp -r ../_book/* ./
  touch .nojekyll
  git add .nojekyll

  git add --all *

  # Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
  git config credential.helper "store --file=.git/credentials"
  echo "https://${GH_TOKEN}:@github.com" > .git/credentials
  git commit -m "${BUILD_COMMIT_MSG}"

  # Now that we're all set up, we can push.
  git push origin $TARGET_BRANCH

fi
