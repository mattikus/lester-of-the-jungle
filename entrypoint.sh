#!/bin/bash

set -e -u -o pipefail

echo ARGS="$@"
env
repo_url=https://github.com/mattikus/lester-of-the-jungle
lita_dir=/run/lester

# Grab the latest copy of lester
git clone --depth 1 $repo_url $lita_dir

cd $lita_dir
bundle install
exec bundle exec lita "$@"
