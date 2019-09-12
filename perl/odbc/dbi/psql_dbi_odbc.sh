#!/usr/bin/env perl
use strict;
use warnings;

# check:
# odbcinst -q -d <--- drivers
# odbsinst -q -s <--- dsn

use DBI;

my $dbname='demodata';
my $dbuser='';
my $dbpass='';
my $dbquery='SELECT COUNT(*) FROM Person';

my @data;

my $dbh = DBI->connect('DBI:ODBC:' . $dbname, $dbuser, $dbpass) or die "Could not connect to database: $DBI::errstr";

my $sth = $dbh->prepare($dbquery) or die "Couldn't prepare statement: " . $dbh->errstr;

$sth->execute() or die "Couldn't execute statement: ". $sth->errstr;

while (@data = $sth->fetchrow_array()) {
    print "$data[0] records found in table 'Person' of database '$dbname'.\n"
}
