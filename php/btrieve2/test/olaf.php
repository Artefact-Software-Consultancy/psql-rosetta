#!/usr/bin/env php

<?php
/*
 * Inspired by code provided by Linda Anderson
 * to use the Btrieve2 API from Python.
 */

// note: Btrieve status code 22 : data buffer length overrun
 
/*
 *  https://phptherightway.com/#php_and_utf8
 *  Tell PHP that we're using UTF-8 strings until the end of the script
 */ 
mb_internal_encoding('UTF-8');
$utf_set = ini_set('default_charset', 'utf-8');
if (!$utf_set) {
    throw new Exception('could not set default_charset to utf-8, please ensure it\'s set on your system!');
}
// conclusion: utf-8 encode & decode should no longer be needed

//$mypath="./btrievePhp.php";
$mypath = getcwd() ; /*
if (is_link($mypath)) {
    echo "Symlink!";
    $mypath=readlink($mypath);
}
else {
    $mypath=dirname($mypath); // . '/btrievePhp.php';
} */
echo "Path: " . $mypath;


$btrievelib =  $mypath . '/btrievePhp.php'; // this sucks with symlinks?

/*
 * load the .so file (extension) assuming it was not loaded using php.ini
 * see: https://www.php.net/manual/en/function.dp.php
 * already handled by btrievePhp.php ?
 */
if (!extension_loaded('btrievePhp')) {
    /*
     * load the module (only works from cli)
     * "enable_dl = On" needs to be set in php.ini
     */
    if (!dl('btrievePhp.so')) {
        $msg="Could not load PHP extenstion btrievePhp.so";
        echo $msg . PHP_EOL;
        exit;
    }
}

//use MonologLogger;
//use MonologHandlerStreamHandler;

//$logger = new Logger('btrieve2');
//$logger->pushHandler(new SteamHandler(DIR.'/btrieve2php.log'));

try {
    //$logger->info('About to attempt to import the Btrieve2 API library');
    $msg='SWIG library ' . $btrievelib . ' has issues';
    if (! @include_once($btrievelib)) {
        if (! file_exists($btrievelib)) {
            $msg='SWIG library ' . $btrievelib . ' can not be found' ;
        }
	//$logger->error($msg);
        throw new Exception ( $msg );
    }
}
catch(Exception $e) {
    echo PHP_EOL;
    echo "Message : " . $e->getMessage() . PHP_EOL;
    echo "Code : " . $e->getCode() . PHP_EOL;
    //$logger->error($msg);
    //$logger->error($e->getMessage());
}

$btrieveFileName = "/usr/local/psql/data/" . "Test_Table.mkd";
$recordFormat = "<iB32sBBBH"; // https://docs.python.org/3.5/library/struct.html#struct-format-strings
/*
 * Python :
 * https://docs.python.org/3.5/library/struct.html#struct-format-strings
 *  < : byte order little-endian (size standard, allignment none)
 *  i : int | integer (size 4)
 *  B : unsigned char | integer (size 1)
 * 32 :
 *  s : char[] | bytes (size defined upfront --> 32 )
 *  B : unsigned char | integer (size 1)
 *  B : unsigned char | integer (size 1)
 *  B : unsigned char | integer (size 1)
 *  H : unsigned short | integer (size 2)
 *
 * see : https://www.php.net/manual/en/function.pack.php
 *       
 */
$recordFormat = "ICa32CCCv"; // machine depended sizes are nasty and might provide issues!
$recordFormatNamed = "Iid/Ca1/a32name/Ca2/Ca3/Ca4/va5"; // fields must be named!
$recordLength = 42;
$keyFormat = "i";

$spf = "%-' 32s";

/* Create a session: */
$btrieveClient = new BtrieveClient(0x4232, 0); // ServiceAgent=B2

/* Specify FileAttributes for the new file: */
$btrieveFileAttributes = new BtrieveFileAttributes();
$rc = $btrieveFileAttributes->SetFixedRecordLength($recordLength);
/* Specify Key 0 as an autoinc: */
$btrieveKeySegment = new BtrieveKeySegment();
$rc = $btrieveKeySegment->SetField(0, 4, Btrieve::DATA_TYPE_AUTOINCREMENT);
$btrieveIndexAttributes = new BtrieveIndexAttributes();
$rc = $btrieveIndexAttributes->AddKeySegment($btrieveKeySegment);
$rc = $btrieveIndexAttributes->SetDuplicateMode(false);
$rc = $btrieveIndexAttributes->SetModifiable(true);

/*
 * Function provided (on IRC FreeNode ##PHP by Ryan Bittarman
 * obviously as with all internet copy/pasted code: use at own risk
 * with remark:
 * it wouldn't be very efficient if you're shoving kb of string into it and shortening it to 32 bytes, you could probably just add a mb_substr($str, 0, $maxlen); infront to truncate it to a safe length before starting to cut down the chars
 * 
 * currently not used, yet sprinf is not multibyte-safe!
 */
function trimToBytes($in, $bytes = 32) {
    while (strlen($in) > $bytes) {
        $in = mb_substr($in, 0, mb_strlen($in) - 1);
    }
    while (strlen($in) < $bytes) {
        $in .= "\0";
    }
    return $in;
}


/* Create the file: */
$rc = $btrieveClient->FileCreate($btrieveFileAttributes, $btrieveIndexAttributes, $btrieveFileName, Btrieve::CREATE_MODE_OVERWRITE);
print(PHP_EOL);
if ($rc == Btrieve::STATUS_CODE_NO_ERROR) {
     print('File "' . $btrieveFileName . '" created successfully!');
}
else{
     print('File "' . $btrieveFileName . '" not created; error: ' . $rc);
}
print(PHP_EOL);

/* Allocate a file object: */
$btrieveFile = new BtrieveFile();
/* Open the file: */
$owner="";
$rc = $btrieveClient->FileOpen($btrieveFile, $btrieveFileName, $owner, Btrieve::OPEN_MODE_NORMAL);
if ($rc == Btrieve::STATUS_CODE_NO_ERROR) {
     print('File open successful!' . PHP_EOL);
}
else {
     print('File open failed - status: ' . $rc . PHP_EOL);
}

/* Create Key 1 as a String with Null Indicator Byte */
$btrieveKey1aSegment = new BtrieveKeySegment();
$rc = $btrieveKey1aSegment->SetField(4, 1, Btrieve::DATA_TYPE_NULL_INDICATOR_SEGMENT);
$rc = $btrieveKey1aSegment->SetDescendingSortOrder(true);

$btrieveKey1bSegment = new BtrieveKeySegment();
$rc = $btrieveKey1bSegment->SetField(5, 32, Btrieve::DATA_TYPE_CHAR);

$btrieveIndex1Attributes = new BtrieveIndexAttributes();
$rc = $btrieveIndex1Attributes->AddKeySegment($btrieveKey1aSegment);
$rc = $btrieveIndex1Attributes->AddKeySegment($btrieveKey1bSegment);

$rc = $btrieveIndexAttributes->SetDuplicateMode(Btrieve::DUPLICATE_MODE_ALLOWED_NONREPEATING);
$rc = $btrieveIndexAttributes->SetModifiable(true);

$rc = $btrieveFile->IndexCreate($btrieveIndex1Attributes);
if ($rc == Btrieve::STATUS_CODE_NO_ERROR) {
     print('Index 1 created successfully' . PHP_EOL);
}
else {
     print('Index 1 not created; error - status: ' . $rc . "(" . Btrieve::StatusCodeToString($rc) . ")" . PHP_EOL);
}

/* Insert records: */
$iinserting = true;
while ($iinserting) {
     $new_name = readline('Insert name (Q to quit): ' ); // no limits in length?!
     //if (strtolower($new_name) == 'q') {
     if (mb_strtolower($new_name) == 'q') {
          $iinserting = false;
     }
     else {
          //$record = struct.pack($recordFormat, 0, 0, $new_name.ljust(32).encode('UTF-8'), 0, 22, 1, 2018)
          //$sbdata = trimToBytes($new_name, 32);
          $sbdata=sprintf($spf, $new_name);
          $record = pack($recordFormat, 0, 0, $sbdata, 0, 22, 1, 2018);
          $rc = $btrieveFile->RecordCreate($record);
          if ($rc == Btrieve::STATUS_CODE_NO_ERROR) {
               print(' Insert successful!' . PHP_EOL);
          }
          else {
               print(' Insert failed - status: ' . $rc . PHP_EOL);
          }
     }
}

/* Get Record count: */
$btrieveFileInfo = new BtrieveFileInformation();
/*
 * ERROR/inconsistent!
 * The next call fails if ported directly from Python!
 * C/C++ online documentation for this call: https://docs.actian.com/psql/btrieve2v13/html/classBtrieveFile.html#acedb5e5ae01bda6adcc130e2383ec645
 * The SWIG implementation for Perl & Python demand 2 parameters:
 * Python: $rc = $btrieveFile->GetInformation($btrieveFile, $btrieveFileInfo);
 * Perl: rc = btrievePerl::BtrieveFile::GetInformation($btrieveFile, $btrieveFileInfo);
 * The C/C++ definition seems to require one.
 * grep GetInformation btrievePhp.php --> function GetInformation($btrieveFileInformation)
 * grep GetInformation btrievePerl.pm --> *GetInformation = *btrievePerlc::BtrieveFile_GetInformation;
 * grep GetInformation btrievePython.py -->  def GetInformation(self, btrieveFileInformation):
 * PHP also needs only one: btrieveFileInformation
 */
//$rc = $btrieveFile->GetInformation($btrieveFile, $btrieveFileInfo);
$rc = $btrieveFile->GetInformation($btrieveFileInfo); // only one parameter!? (perl & python take 2)
print(PHP_EOL . 'Total Records inserted = ' . $btrieveFileInfo->GetRecordCount());

/* Display all records in sorted order */
/* --> depends on db definition, especially indices */
print(PHP_EOL . 'Here is a list of the names in alphabetical order:' . PHP_EOL);
$index = 1; //BTRIEVE::INDEX_NONE;
$recordSize = 0; //$recordLength ;
$readLength = $btrieveFile->RecordRetrieveFirst($index, $record, $recordSize);
//var_dump($readLength); // always -1 ??? ---> not if we omit a non-used index
while ($readLength > 0){
     $recordUnpacked = unpack($recordFormatNamed, $record);
     //var_dump($record);
     //var_dump($recordUnpacked);
     $id = $recordUnpacked['id'];
     $name = trim($recordUnpacked['name']);
     //print('   ID:' . $recordUnpacked[0] . ' Name:' .  utf8_decode($recordUnpacked[2]) . PHP_EOL); //.decode());
     print('   ID:' . $id . ' Name:' .  $name . PHP_EOL);
     $readLength = $btrieveFile->RecordRetrieveNext($record, 0);
}

/* Look up record by name */
$ireading = true;
while ($ireading) {
	 print(PHP_EOL);
     $find_name = readline('Find name (Q to quit): ' );
     //if (strtolower($find_name) == 'q') {
     if (mb_strtolower($find_name) == 'q') {
          $ireading = false;
     }
     else {
          $foundOne = false;
          //$record = pack($recordFormat, 0, 0, ' '.ljust(32).encode('UTF-8'), 0, 0, 0, 0);
          //$sbdata = trimToBytes(' ', 32);
          $sbdata = sprintf($spf, ' ');
          $record = pack($recordFormat, 0, 0, $sbdata, 0, 0, 0, 0); // why?
          $readLength = $btrieveFile->RecordRetrieveFirst(Btrieve::INDEX_NONE, $record, 0);
          while ($readLength > 0) {
			   //var_dump($record);
               $recordUnpacked = unpack($recordFormatNamed, $record);
               //if ($recordUnpacked[2] == utf8_encode(printf("%32s",$find_name))) {
               //if ($recordUnpacked[2] == sprintf("%32s",$find_name)) {
               //$sbata = trimToBytes($find_name, 32);
               //$sbdata = sprintf($spf, $find_name);
               //var_dump($recordUnpacked);
               $id = $recordUnpacked['id'];
               $name = trim($recordUnpacked['name']);
               //if ($recordUnpacked[2] == $sbname) {
               if ($name == $find_name) {
                    //print(' Matching record found: ID:' . $recordUnpacked[0] . ' Name:' . utf8_decode($recordUnpacked[2]) . PHP_EOL); //.decode());
                    print(' Matching record found: ID:' . $id . ' Name:' . $name . PHP_EOL);
                    $foundOne = true;
               }
               $readLength = $btrieveFile->RecordRetrieveNext($record, 0);
          }
          if ($foundOne == false) {
               print(' No record found matching "' . $find_name . '"' . PHP_EOL);
          }
          $status = $btrieveFile->GetLastStatusCode();
          if ($status != Btrieve::STATUS_CODE_END_OF_FILE) {
               print(' Read error: ' . $status . Btrieve::StatusCodeToString($status) . PHP_EOL);
          }
     }
}

/* Close the file: */
$rc = $btrieveClient->FileClose($btrieveFile);
if ($rc == Btrieve::STATUS_CODE_NO_ERROR) {
     print('File closed successful!' . PHP_EOL);
}
else {
     print('File close failed - status: ' . $rc . PHP_EOL);
}
