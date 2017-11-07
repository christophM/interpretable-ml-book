#!/bin/sh

git checkout --orphan gh-pages
git rm -rf .

# create a hidden file .nojekyll
touch .nojekyll
git add .nojekyll

git commit -m"Initial commit"
git push origin gh-pages