#!/usr/bin/env perl

# Hard work, don't do it. Plaform dependent. Use DBI as everybody else does!
# Not supported by Debian. Requires: dh-make-perl --build --cpan UnixODBC
# Which results in Error 1 without a .deb package.
# Yet another reason not to use it.

# UNTESTED CODE due to lack of UnixODBC.pm on my development system (Debian Buster)

use strict;
use warnings;

use UnixODBC 'all'; # https://metacpan.org/pod/UnixOdbc

my $dbname='demodata';
my $dbuser='';
my $dbpass='';
my $dbquery='SELECT COUNT(*) FROM Person';

my $r; # result
my $evh; # Environment handle
my $cnh; # Connection handle
my $sth; # Statement handle
my $buf; # Buffer for results
my $rlen; # Length of Returned Value
my $diagrecno = 1;
my $sqlstate;

# allocate Environment handle
$r = SQLAllocHandle($SQL_HANDLE_ENV, $SQL_NULL_HANDLE, $evh);

if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_ENV, $evh, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# force ODBC version is required?

# allocate Connection handle
$r = SQLAllocHandle($SQL_HANDLE_DBC, $evh, $cnh);
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_ENV, $evh, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# connect to datasource (DSN)
my $DSN = $dbname;
$r = SQLConnect($cnh, $DSN, $SQL_NTS, $dbuser, $SQL_NTS, $dbpass, $SQL_NTS);
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_DBC, $cnh, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# allocate Statement handle
$r = SQLAllocHandle($SQL_HANDLE_STMT, $cnh, $sth);
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_STMT, $sth, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# prepare SQL query
my $query = $dbquery;
$r = SQLPrepare($sth, $query, length($query));
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_STMT, $sth, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# execute SQL query
$r = SQLExecute($sth);
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_STMT, $sth, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# loop to retrieve data rows
my $column=1;
while (1) {
    # fetch row
    $r = SQLFetch($sth);
    last if $r==$SQL_NO_DATA;
    # we only have one column when issuing a count, so no need to iterate
    $r = $SQLGetData($sth, $column, $SQL_C_CHAR, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\t";
}
print " people in table Person.\n";

# clean up
# phase 1: deallocate statement handle
$r = SQLFreeHandle($SQL_HANDLE_STMT, $sth);
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_STMT, $sth, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# phase 2 : disconnect from DSN
$r = SQLDisconnect($cnh);
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_DBC, $cnh, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# phase 3 : deallocate Connection handle
$r = SQLFreeConnect($cnh);
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_DBC, $cnh, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

# phase 4 : deallocate Environment handle
$r = SQLFreeHandle($SQL_HANDLE_ENV, $evh);
if (($r!=$SQL_SUCCESS) && ($r!=$SQL_NO_DATA)) {
    SQLGetDiagRec($SQL_HANDLE_ENV, $evh, $diagrecno, $sqlstate, $native, $buf, $SQL_MAX_MESSAGE_LENGTH, $rlen);
    print "$buf\n";
    exit 1
}

