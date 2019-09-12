#!/usr/bin/env perl

# check: https://stackoverflow.com/questions/728597/how-can-my-perl-script-find-its-module-in-the-same-directory#728763
#        https://www.perlmonks.org/bare/?node_id=375341

use 5.28.0; # could work with older versions (not tested)
use strict;
use warnings;

#use FindBin;
#use Cwd;
use File::Basename;
use lib dirname (__FILE__);

use Encode qw/encode decode/;;
use utf8; # https://www.perlmonks.org/?node_id=1042907
use Try::Tiny;
use Data::Dumper; # for debugging purposes

my $false=0;
my $true=1;

try {
    use lib q{.};
    use btrievePerl; # Btrieve2 API wrapped using SWIG
} catch {
    print "Something went wrong importing the BtrievePerl Btrieve2 API wrapper library";
    warn "caught error: $_";
    die;
};

my $btrieveFileName = '/usr/local/psql/data/' . 'Test_table.mkd';

#my $recordFormat = '<iB32sBBBH';
# Python :
# https://docs.python.org/3.5/library/struct.html#struct-format-strings
#  < : byte order little-endian (size standard, allignment none)
#  i : int | integer (size 4)
#  B : unsigned char | integer (size 1)
# 32 :
#  s : char[] | bytes (size defined upfront --> 32 ?)
#  B : unsigned char | integer (size 1)
#  B : unsigned char | integer (size 1)
#  B : unsigned char | integer (size 1)
#  H : unsigned short | integer (size 2)
# Perl :
# https://perldoc.perl.org/functions/pack.html
#$recordFormat = '<IC32aCCCv';
# according to docs Endian-modifiers must be at the end
# and: The > or < modifiers can only be used on floating-point formats on big-
#      or little-endian machines. Otherwise, attempting to use them raises an exception.
#my $recordFormat = 'IC32aCCCv';
my $recordFormat = 'V1C1A32C3v1';
 
my $recordLength = 42;
#$keyFormat = '<i'; # Python
my $keyFormat = 'I'; #<'; # Perl

# some help functions
sub ltrim { my $s = shift; $s =~ s/^\s+//;       return $s };
sub rtrim { my $s = shift; $s =~ s/\s+$//;       return $s };
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

# Create a session:
my $btrieveClient = btrievePerl::BtrieveClient->new("0x4232", 0); # ServiceAgent=B2

# Specify FileAttributes for the new file:
my $btrieveFileAttributes = btrievePerl::BtrieveFileAttributes->new();
my $rc = $btrieveFileAttributes->SetFixedRecordLength($recordLength);
# Specify Key 0 as an autoinc:
my $btrieveKeySegment = btrievePerl::BtrieveKeySegment->new();
$rc = $btrieveKeySegment->SetField(0, 4, $btrievePerl::Btrieve::DATA_TYPE_AUTOINCREMENT);
my $btrieveIndexAttributes = btrievePerl::BtrieveIndexAttributes->new();
$rc = $btrieveIndexAttributes->AddKeySegment($btrieveKeySegment);
$rc = $btrieveIndexAttributes->SetDuplicateMode($false);
$rc = $btrieveIndexAttributes->SetModifiable($true);

print("\n");
#print("File to be used: " . $btrieveFileName . "\n");
# Create the file:
$rc = $btrieveClient->FileCreate($btrieveFileAttributes, $btrieveIndexAttributes, $btrieveFileName, $btrievePerl::Btrieve::CREATE_MODE_OVERWRITE);
if ($rc == $btrievePerl::Btrieve::STATUS_CODE_NO_ERROR)
{
     print("File '" . $btrieveFileName . "' created successfully!");
}
else
{
     print("File '" . $btrieveFileName . "' not created; error: " + $rc);
}
print("\n");

# Allocate a file object:
my $btrieveFile = btrievePerl::BtrieveFile->new();
# Open the file:
$rc = $btrieveClient->FileOpen($btrieveFile, $btrieveFileName, undef, $btrievePerl::Btrieve::OPEN_MODE_NORMAL);
if ($rc == $btrievePerl::Btrieve::STATUS_CODE_NO_ERROR)
{
     print("File open successful!" . "\n");
}
else
{
     print("File open failed - status: " . $rc . "\n");
}

# Create Key 1 as a String with Null Indicator Byte:
my $btrieveKey1aSegment = btrievePerl::BtrieveKeySegment->new();
$rc = $btrieveKey1aSegment->SetField(4, 1, $btrievePerl::Btrieve::DATA_TYPE_NULL_INDICATOR_SEGMENT);
$rc = $btrieveKey1aSegment->SetDescendingSortOrder($true);

my $btrieveKey1bSegment = btrievePerl::BtrieveKeySegment->new();
$rc = $btrieveKey1bSegment->SetField(5, 32, $btrievePerl::Btrieve::DATA_TYPE_CHAR);

my $btrieveIndex1Attributes = btrievePerl::BtrieveIndexAttributes->new();
$rc = $btrieveIndex1Attributes->AddKeySegment($btrieveKey1aSegment);
$rc = $btrieveIndex1Attributes->AddKeySegment($btrieveKey1bSegment);
$rc = $btrieveIndex1Attributes->SetDuplicateMode($btrievePerl::Btrieve::DUPLICATE_MODE_ALLOWED_NONREPEATING);
$rc = $btrieveIndex1Attributes->SetModifiable($true);
$rc = $btrieveFile->IndexCreate($btrieveIndex1Attributes);
if ($rc == $btrievePerl::Btrieve::STATUS_CODE_NO_ERROR)
{
	print('Index 1 created successfully!' . "\n");
}
else
{
	print('Index 1 not created; error: ' . $rc . ': ' . btrievePerl::Btrieve::StatusCodeToString($rc));
}

# Insert records:
my $iinserting = $true;
while ("$iinserting" eq "$true")
{
	 print("Insert name (Q to quit): " );
     chomp(my $new_name = <STDIN>);
     #print("Entry was : " . $new_name . "\n");
     if (lc($new_name) eq "q")
     {
		  print(" Input finished.\n");
          $iinserting = $false;
     }
     else
     {
          # next line originates from Python; most likely incompatible with Perl
          # python: https://docs.python.org/3.5/library/struct.html#struct.pack
          # perl: https://perldoc.perl.org/functions/pack.html 
          #$record = struct.pack($recordFormat, 0, 0, $new_name.ljust(32).encode('UTF-8'), 0, 22, 1, 2018);
          #$record = pack($recordFormat, 0, 0, encode('UTF-8', $new_name), 0, 22, 1, 2018);
          #my $new_name2 = sprintf("%-32s", $new_name); # UTF-8 should be global, so no need to encode ---> false
          my $new_name2 = encode('UTF-8', $new_name); # left just format is now enfoced by 'A' in the recordformat
          my $record = pack($recordFormat, 0, 0, $new_name2, 0, 22, 1, 2018);
          #print Dumper($new_name2);
          #print Dumper($record);
          my $rc = $btrieveFile->RecordCreate($record);
          if ($rc == $btrievePerl::Btrieve::STATUS_CODE_NO_ERROR)
          {
               print(" Insert successful!\n");
          }
          else
          {
               print(" Insert failed - status: " . $rc);
          }
      }
}

# Get Record count:
my $btrieveFileInfo = btrievePerl::BtrieveFileInformation->new();
$rc = btrievePerl::BtrieveFile::GetInformation($btrieveFile, $btrieveFileInfo);
print("\n" . "Total Records inserted = " . $btrieveFileInfo->GetRecordCount() . "\n");

# Display all records in sorted order 
print("\n" . 'Here is a list of the names in alphabetical order:' . "\n");
my $record = pack($recordFormat, 0, 0, encode('utf-8', ' '), 0, 0, 0, 0); # why? --> otherwise next line fails!
my $readLength = $btrieveFile->RecordRetrieveFirst(1, $record, 0); # use Index 0
while ($readLength > 0)
{
     #$recordUnpacked = unpack($recordFormat, $record); # needs templating with names, see https://perldoc.perl.org/functions/unpack.html
     # unpack : https://www.perlmonks.org/?node_id=224666
     (my $myid , my $mya1 , my $myname, my $mya2, my $mya3 , my $mya4, my $mya5) = unpack($recordFormat, $record);
     #print("myid=".$myid."\n");
     #print("mya1=".$mya1."\n");
     #print("myname=".$myname."\n");
     #print("mya2=".$mya2."\n");
     #print("mya3=".$mya3."\n");
     #print("mya4=".$mya4."\n");
     #print("mya5=".$mya5."\n");
     $myname = trim(decode('utf-8', $myname));
     print('   ID:' . $myid . ' Name:' . $myname . "\n");
     $readLength = $btrieveFile->RecordRetrieveNext($record, 0);
}

# Look up record by name
my $ireading = $true;
while ("$ireading" eq "$true")
{
     print("\n" . 'Find name (Q to quit): ' );
     chomp(my $find_name = <STDIN>);
     if (lc($find_name) eq "q")
     {
          $ireading = $false;
     }
     else
     {
          my $foundOne = $false;
          #my $data = sprintf("%-32s", ' '); # UTF-8 encoding should already be handled
          my $data = encode('utf-8', ' ');
          my $record = pack($recordFormat, 0, 0, $data, 0, 0, 0, 0); # why?
          my $readLength = $btrieveFile->RecordRetrieveFirst($btrievePerl::Btrieve::INDEX_NONE, $record, 0);
          while ($readLength > 0)
          {
               #my $recordUnpacked[] = unpack($recordFormat, $record);
               #my $myid = $recordUnpacked[0];
               #$myname = $recordUnpacked[2]; #.decode().strip()
               
               (my $myid , my $mya1 , my $myname, my $mya2, my $mya3 , my $mya4, my $mya5) = unpack($recordFormat, $record);
               $myname = trim(decode('utf-8', $myname));
               if ("$myname" eq "$find_name")
               { 
                    print(' Matching record found: ID:' . $myid . ' Name:' . $myname . "\n");
                    $foundOne = $true;
               }
               $readLength = $btrieveFile->RecordRetrieveNext($record, 0);
          }
          if ("$foundOne" eq "$false")
          {
               print(' No record found matching "' . $find_name . '"');
          }
          my $status = $btrieveFile->GetLastStatusCode();
          if ($status != $btrievePerl::Btrieve::STATUS_CODE_END_OF_FILE)
          {
               print(' Read error: ' . $status . " : " . btrieve::Btrieve::StatusCodeToString($status));
		  }
	}
}

# Close the file:
$rc = $btrieveClient->FileClose($btrieveFile);
if ($rc == $btrievePerl::Btrieve::STATUS_CODE_NO_ERROR)
{
     print("\nFile closed successful!\n");
}
else
{
     print("\nFile close failed - status: " . $rc . "\n");
}
