#!/bin/bash
set +x  # turn off trace
set -e  # turn on exit immediately

# project related variables
PROJECT_PATH="github.com/aclisp"
PROJECT_NAME="dbgate-watch"

# always get PWD of this shell script, even if it is called from any path
THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# construct the golang dirs under .build
GOPATH=$THISDIR/.build
mkdir -p $GOPATH/bin
mkdir -p $GOPATH/pkg
mkdir -p $GOPATH/src
mkdir -p $GOPATH/lib
mkdir -p $GOPATH/tmp
# make project related dirs
mkdir -p $GOPATH/src/$PROJECT_PATH
PROJECT=$PROJECT_PATH/$PROJECT_NAME
WORKDIR=$GOPATH/src/$PROJECT
rm -f $WORKDIR  # workdir is a link
ln -s $THISDIR $WORKDIR  # link to the real src

# setup golang variables, so that go is aware of the new gopath
echo "Build the default (debug) version..."
echo "GOPATH is $GOPATH"
export GOPATH
go fmt $PROJECT
go vet $PROJECT
go build -o $THISDIR/dbgate-watch $PROJECT

echo "Done."
