#!/usr/bin/env bash
#set -ex
VERSIONS=$(asdf list all python | grep "^3\." | grep -v dev \
  | grep -v "^3\.[0-5]\.")

for version in $VERSIONS; do
#  echo "$version"
  stat "../python-x64/$version" >/dev/null || echo "../python-x64/$version not found"
  stat "../python-arm64/$version" >/dev/null || echo "../python-arm64/$version not found"
done
