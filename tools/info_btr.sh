#!/bin/bash

BTRFILE=/usr/local/psql/data/Test_Table.mkd
BUTIL=/usr/local/psql/bin/butil

$BUTIL -ver
$BUTIL -stat $BTRFILE


