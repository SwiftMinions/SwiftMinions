#!/bin/sh

source ./not_so_important.sh

printf "${RED}pod trunking...\n"

pod trunk push $PWD/../SwiftMinions.podspec --allow-warnings

