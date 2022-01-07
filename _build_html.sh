#!/bin/sh
set -e # Exit with nonzero exit code if anything fails

# Create datasets
Rscript scripts/prepare_data.R

cd manuscript
# Create references
make -B 11-references.Rmd
# Compile html version of book for gh-pages
make html
cd ..

