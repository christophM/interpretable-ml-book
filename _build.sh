#!/bin/sh
set -e # Exit with nonzero exit code if anything fails

# Create datasets
Rscript scripts/prepare_data.R

cd manuscript
# Create references
make -B 11-references.Rmd
# Compile pdf version of book for leanpub
make pdf
# Compile web version of book
make html
# Compile epub version of book for leanpub
make epub

cd ..

