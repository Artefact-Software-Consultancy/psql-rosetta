# Accessing Pervasive.SQL from bash

[Bash](https://www.gnu.org/software/bash/) or [Bourne Again SHell](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) is or used to be the default shell for Linux distributions although there are alternatives.
Chances are if you use these you are also familiar with Bash and can port code if needed.

No extensive directory structure is present as options are rather limited and no actual coding is required; all in all we just execute a provided utility.

## Coding in Bash
Further links in case you are interested in programming bash:
* [Bash FAQ](http://mywiki.wooledge.org/BashFAQ)
* [Bash Guide](http://mywiki.wooledge.org/BashGuide)
* [Bash Manual](http://gnu.org/s/bash/manual)
* [Bash Hackers](http://wiki.bash-hackers.org/)
* [Bash Quotes](http://mywiki.wooledge.org/Quotes)
* [Shell Check](http://www.shellcheck.net/)
* [Bash programming How-To](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html)
* [Advanced Bash-Scripting Guide](http://tldp.org/LDP/abs/html/)
And zillion others widely ranging quality wise.

## The good news
All this is not necessary, as Pervasive.SQL has various commandline tools available.
These are documented [here](https://docs.actian.com/psql/psqlv13/uguide/uguide.Command_Line_Interface_Utilities.htm).
Among them is __[isql](https://docs.actian.com/psql/psqlv13/uguide/uguide.isql.htm#ww138933)/isql64__ which, if DDF-files are available and the database is 'Named' and can be access using a DSN (see []dsnadd](
). In short the database must be accessible using ODBC. Check using 'odbcinst -q -d' and 'odbcinst -q -s'.
Isql can be used to query a database using [SQL](https://docs.actian.com/psql/psqlv13/sqlref/sqlintro.htm) statements. It can also be scripted.

## The bad news
As mentioned __isql__ has some limitations. But most of all it allows only access using ODBC. If you want to access a database differently and none of the supplied commandline utilities suite your needs you must resort to programming.

## The example
I wrote a simple bash script 'psql.sh' which reads from a file called 'psqltest.sql' in the same directory the query it needs to execute.
Adjust at will. 

