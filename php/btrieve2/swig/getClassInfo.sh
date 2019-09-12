#!/usr/bin/env php

<?php
/*
 * see: http://clivern.com/how-to-test-php-classes-and-objects/
 */

$btrievelib =  __DIR__ . '/btrievePhp.php';

try {
    //$logger->info('About to attempt to import the Btrieve2 API library');
    $msg='SWIG library ' . $btrievelib . ' has issues';
    if (! @include_once($btrievelib)) {
	if (! file_exists($btrievelib)) {
	    $msg='SWIG library ' . $btrievelib . ' can not be found' ;
	}
        throw new Exception ( $msg );
    }
}
catch(Exception $e) {
    echo "Message : " . $e->getMessage() . PHP_EOL;
    echo "Code : " . $e->getCode() . PHP_EOL;
    //$logger->error($msg);
    //$logger->error($e->getMessage());
}

function classInfo($myclass) {
    echo "-- Examining " .$myclass ."\n";
    // check if it exists
    if (class_exists($myclass)) {
	echo "Mathods:";
	$class_methods = get_class_methods($myclass);
	foreach ($class_methods as $method_name) {
	    echo "$method_name\n";
	}
	echo "Vars:";
	var_dump(get_class_vars($myclass));
    }
    else {
	echo "Class does not exists.";
    }
}

// main

// get declared classes
echo "Declared classes:";
print_r(get_declared_classes());

/* grep class btrievePhp.php */
classInfo('Btrieve');
classInfo('BtrieveClient');
classInfo('BtrieveFile');
classInfo('BtrieveFileAttributes');
classInfo('BtrieveFileInformation');
classInfo('BtrieveFilter');
classInfo('BtrieveBulkRetrieveAttributes');
classInfo('BtrieveBulkRetrieveResult');
classInfo('BtrieveIndexAttributes');
classInfo('BtrieveBulkCreatePayload');
classInfo('BtrieveBulkCreateResult');
classInfo('BtrieveKeySegment');
classInfo('BtrieveVersion');
classInfo('BtrieveCollection');
classInfo('BtrieveDocumentSet');

echo '\n';

?>
