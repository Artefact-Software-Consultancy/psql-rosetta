#!/usr/bin/env python3
'''
    Slightly adapted from the example provided
    by Linda Anderson from Actian Corporation.
    Origin: Linda's blog about Swig + Btrieve2 API + Python (Windows)
    Also checkout the article of Goldstar's Bill Bach (Windows & Linux)
    Adjust paths (data+lib) as required.
''' 
import os
import sys
import struct
lib="lib"
if (sys.maxsize > 2**31):
    lib="lib64"
#sys.path.append('/usr/local/psql/' + lib)
#sys.path.append(os.path.dirname(os.path.realpath(__file__)))
sys.path.append(os.getcwd())
try:
    import btrievePython as btrv
except ImportError as error:
    print("Unable to import Btrieve2 API")
    print(error.__class__.__name__ + " : " + error.msg)
    print("Path:")
    print(':'.join(x for x in sys.path if x))
    exit(1)
except Exception as exception:
    print(exception, False)
    print(exception.__class__.__name__ + " : " + exception.msg)
    exit(1)

btrieveFileName = "/usr/local/psql/data/" + "Test_Table.mkd"
recordFormat = "<iB32sBBBH"
recordLength = 42
keyFormat = "<i"

# Create a session:
btrieveClient = btrv.BtrieveClient(0x4232, 0) # ServiceAgent=B2

# Specify FileAttributes for the new file:
btrieveFileAttributes = btrv.BtrieveFileAttributes()
rc = btrieveFileAttributes.SetFixedRecordLength(recordLength)
# Specify Key 0 as an autoinc:
btrieveKeySegment = btrv.BtrieveKeySegment()
rc = btrieveKeySegment.SetField(0, 4, btrv.Btrieve.DATA_TYPE_AUTOINCREMENT)
btrieveIndexAttributes = btrv.BtrieveIndexAttributes()
rc = btrieveIndexAttributes.AddKeySegment(btrieveKeySegment)
rc = btrieveIndexAttributes.SetDuplicateMode(False)
rc = btrieveIndexAttributes.SetModifiable(True)

# Create the file:
rc = btrieveClient.FileCreate(btrieveFileAttributes, btrieveIndexAttributes,
btrieveFileName, btrv.Btrieve.CREATE_MODE_OVERWRITE)
if (rc == btrv.Btrieve.STATUS_CODE_NO_ERROR):
     print('\nFile "' + btrieveFileName + '" created successfully!')
else:
     print('\nFile "' + btrieveFileName + '" not created; error: ', rc)

# Allocate a file object:
btrieveFile = btrv.BtrieveFile()
# Open the file:
rc = btrieveClient.FileOpen(btrieveFile, btrieveFileName, None, btrv.Btrieve.OPEN_MODE_NORMAL)
if (rc == btrv.Btrieve.STATUS_CODE_NO_ERROR):
     print('File open successful!\n')
else:
     print('File open failed - status: ', rc, '\n')

# Create Key 1 as a String with Null Indicator Byte:
btrieveKey1aSegment = btrv.BtrieveKeySegment()
rc = btrieveKey1aSegment.SetField(4, 1, btrv.Btrieve.DATA_TYPE_NULL_INDICATOR_SEGMENT)
rc = btrieveKey1aSegment.SetDescendingSortOrder(True)
btrieveKey1bSegment = btrv.BtrieveKeySegment()
rc = btrieveKey1bSegment.SetField(5, 32, btrv.Btrieve.DATA_TYPE_CHAR)
btrieveIndex1Attributes = btrv.BtrieveIndexAttributes()
rc = btrieveIndex1Attributes.AddKeySegment(btrieveKey1aSegment)
rc = btrieveIndex1Attributes.AddKeySegment(btrieveKey1bSegment)
rc = btrieveIndex1Attributes.SetDuplicateMode(btrv.Btrieve.DUPLICATE_MODE_ALLOWED_NONREPEATING)
rc = btrieveIndex1Attributes.SetModifiable(True)
rc = btrieveFile.IndexCreate(btrieveIndex1Attributes)
if (rc == btrv.Btrieve.STATUS_CODE_NO_ERROR):
 print('Index 1 created successfully!')
else:
 print('Index 1 not created; error: ', rc, ': ', btrv.Btrieve.StatusCodeToString(rc)) 

# Insert records:
iinserting = True
while iinserting:
     new_name = input('Insert name (Q to quit): ' )
     if new_name.lower() == 'q':
          iinserting = False
     else:
          record = struct.pack(recordFormat, 0, 0, new_name.ljust(32).encode('UTF-8'), 0, 22, 1, 2018)
          rc = btrieveFile.RecordCreate(record)
          if (rc == btrv.Btrieve.STATUS_CODE_NO_ERROR):
               print(' Insert successful!')
          else:
               print(' Insert failed - status: ', rc)

# Get Record count:
btrieveFileInfo = btrv.BtrieveFileInformation()
rc = btrv.BtrieveFile.GetInformation(btrieveFile, btrieveFileInfo)
print('\nTotal Records inserted =', btrieveFileInfo.GetRecordCount())

'''
# Close the file:
rc = btrieveClient.FileClose(btrieveFile)
if (rc == btrv.Btrieve.STATUS_CODE_NO_ERROR):
     print('File closed successful!')
else:
     print('File close failed - status: ', rc)
'''

'''
   next few lines of code by Bill Bach
'''
# Display all records in sorted order 
print('\nHere is a list of the names in alphabetical order:')
readLength = btrieveFile.RecordRetrieveFirst(1, record, 0)
while (readLength > 0):
     recordUnpacked = struct.unpack(recordFormat, record)
     print('   ID:', recordUnpacked[0], ' Name:', recordUnpacked[2].decode())
     readLength = btrieveFile.RecordRetrieveNext(record, 0)

'''
   Linda's code continues
'''
# Look up record by name
ireading = True
while ireading:
     find_name = input('\nFind name (Q to quit): ' )
     if find_name.lower() == 'q':
          ireading = False
     else:
          foundOne = False
          record = struct.pack(recordFormat, 0, 0, ' '.ljust(32).encode('UTF-8'), 0, 0, 0, 0)
          readLength = btrieveFile.RecordRetrieveFirst(btrv.Btrieve.INDEX_NONE, record, 0)
          while (readLength > 0):
               recordUnpacked = struct.unpack(recordFormat, record)
               myid = recordUnpacked[0]
               myname = recordUnpacked[2].decode().strip()
               if (myname == find_name): 
                    print(' Matching record found: ID:', myid, ' Name:', myname)
                    foundOne = True
               readLength = btrieveFile.RecordRetrieveNext(record, 0)
          if (foundOne == False):
               print(' No record found matching "'+find_name+'"')
          status = btrieveFile.GetLastStatusCode()
          if (status != btrv.Btrieve.STATUS_CODE_END_OF_FILE):
               print(' Read error: ', status, btrv.Btrieve.StatusCodeToString(status))

'''
    code copied from original post to finish Linda's extended example posting
'''
# Close the file:
rc = btrieveClient.FileClose(btrieveFile)
if (rc == btrv.Btrieve.STATUS_CODE_NO_ERROR):
     print('File closed successful!')
else:
     print('File close failed - status: ', rc)
