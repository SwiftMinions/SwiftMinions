#!/bin/sh

source ./not_so_important.sh

if ! cmp -s Cartfile.resolved Carthage/Cartfile.resolved; then
  printf "${RED}Dependencies out of date with cache.${NC} Bootstrapping...\n"
  carthage bootstrap --project-directory $PWD/../ --platform iOS
else
  printf "${GREEN}Cache up-to-date.${NC} Skipping bootstrap...\n"
fi

