#!/bin/bash

# inspired by: https://www.easysoft.com/support/kb/kb01045.html

# GOROOT is no longer needed

#mkdir -p $HOME/golang/packages
#mkdir -p ~/golang/go/bin

#export GOROOT=$HOME/golang/go
#export PATH=$PATH:$GOROOT/bin
#export GOPATH=$HOME/golang/packages

source ./gopath.sh

# see: https://github.com/alexbrainman/odbc/wiki
go get github.com/alexbrainman/odbc

go get github.com/sirupsen/logrus
go get github.com/jmoiron/sqlx

