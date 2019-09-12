#!/usr/bin/env perl
# also see: https://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_1.html

use strict;
use warnings;

# check:
# odbcinst -q -d <--- drivers
# odbcinst -q -s < dsn

use DBI;

my $dbname='demodata';
my $dbuser='';
my $dbpass='';
my $dbquery='SELECT COUNT(*) FROM Person';

my @data;

#my $drvconstr="DRIVER={/usr/local/psql/lib/libodbcci.so};SERVERNAME=localhost;DBQ=demodata;";
my $drvconstr="DRIVER={/usr/local/psql/lib64/libodbcci.so};SERVERNAME=localhost;DBQ=demodata;";

#my $dbh = DBI->connect('DBI:ODBC:' . $dbname, $dbuser, $dbpass) or die "Could not connect to database: $DBI::errstr";
my $dbh = DBI->connect('DBI:ODBC:' . $drvconstr) or die "Could not connect to database: $DBI::errstr";


my $sth = $dbh->prepare($dbquery) or die "Couldn't prepare statement: " . $dbh->errstr;

$sth->execute() or die "Couldn't execute statement: ". $sth->errstr;

while (@data = $sth->fetchrow_array()) {
    print "$data[0] records found in table 'Person' of database '$dbname'.\n"
}
