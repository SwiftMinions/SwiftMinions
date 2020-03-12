#!/bin/sh

source ./not_so_important.sh

carthage build --project-directory $PWD/../ --no-skip-current --platform iOS 


