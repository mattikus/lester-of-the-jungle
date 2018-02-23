#!/bin/bash

set -e -u -o pipefail

echo ARGS="$@"
env
repo_url=https://github.com/mattikus/lester-of-the-jungle
lita_dir=/lester

mkdir -p $lita_dir
cd $lita_dir

# Grab the latest copy of lester
if [[ ! -d ${lita_dir}/.git ]]; then
  git clone --depth 1 $repo_url $lita_dir
else
  git fetch --depth 1 origin
  git reset --hard origin/master
fi

bundle install
exec bundle exec lita "$@"
