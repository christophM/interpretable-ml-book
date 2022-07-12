#!/bin/sh

git clone -b gh-pages git@github.com:christophM/interpretable-ml-book.git out
git rm -rf out/*
cp -r manuscript/_book/* out/
Rscript vgwort/vgwort-insert-zaehlmarken.R
cd out
touch .nojekyll
git add .nojekyll
git add --all ./*
git commit -m "Update Book" --allow-empty
git push origin gh-pages

