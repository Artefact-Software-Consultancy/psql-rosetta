# Btrieve / Pervasive.SQL / ZEN : Rosetta-code example repository project

## Idea
Provide documented example code for all database access methods supported by Pervasive.SQL on all platforms using all popular languages. Preferably useful for both beginner and advanced user as a reference guide.

## Name
See:
* [Rosetta Stone](https://en.wikipedia.org/wiki/Rosetta_Stone)
* [Rosetta Code](https://rosettacode.org/wiki/Rosetta_Code)

## Background
For many years it struck me that code/coding examples were scarce. Also they varied over time (platforms, languages supported), but most of all stuck in time. Not very appealing for a starter, whether (s)he would be new to a programming language or to Pervasive.SQL.
Over the years I developed ideas on how to improve this and made some efforts writing code.
The task ahead is quite extensive. Especially if one wants to do a proper job.
Ideas change, new projects or tasks got in between, etc. Long story short it took some time and the result is very different than at first anticipated as my first idea was to write a single reference application which could later be ported to other languages/platforms.

## Layout
Based on the paragraph [Database Access Methods](https://docs.actian.com/psql/psqlv13/#page/welcome%2Flibwelcome.htm%23ww143310) in the Actian Pervasive.SQL V13 online documentation I created a [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) shellscript (mk_dirs.sh), taking a single argument being the programminglanguage name, which creates a directory structure listing all the database access methods as subdirectories. By using this script I was forced to look into and document all(?!) possibilities regardless how odd. All subdirectories contain their own markdown ReadMe file describing the (im)possibilities and code if provided.
All programminglanguages have a ReadMe markdown file in their root directory describing the ins and outs, what is and isn't implemented as well as a Results markdown file to register what has been tested on which platform.

## Missing files versus Copyright
The goals was not to infringe any copyrights, so headers must be copied from SDKs which can be downloaded from the Actian website. The same goes for example code which can be copy/pasted from the website. It would be great if example code (& headers) could be made available from a repository.

# Improvements
I very much welcome improvements, comments and other contributions.
Personally I can think of a view:
* All code should confirm to coding standards.
* Refactoring/cleanup of code.
* All code should be very rich in comments. Annotate all database calls.
* All code should be made very defensive: if an error occurs it should be reported or at least logged.
* All code should be properly tested. Preferably on all relevant platforms. Which on turn should be documented.
* Code must be written or adapted for other platforms. Notably: Mac, IOS, Android
* Some obvious languages/platforms are missing. Notably: Win/VS: c#, VB.net, Win/Embarcadero C++, Win/MingW or other GNU C/C++, IOS/Objective C, Android/Java, Mac/making the bash-shell scripts compatible/supportive.
* Also some languages which used to be supported/were important do not have sample code yet. What springs to mind: Cobol, Delphi, ... ? And some are no longer important: (Visual) Basic (pre .net), Pascal, Turboc (DOS), Watcom C/C++ (DOS)
* Integrated platforms are not listed. For example [Magic](https://www.magicsoftware.com) It probably makes no sense in listing them. Other platforms used in the past: [Clarion](http://www.softvelocity.com/) and [Power Builer](https://www.powerbuilder.eu/)
* Another subject which requires attention is web-based development. One can think of: Windows/ASP, Python/Flask, Python/Django, Ruby/Ruby-on-rails and Javascript, NodeJS. Optionally expanded by new kids on the block such as Dart/Flutter, Meteor, etc. although a lot of them are based on Javascript.
* Drivers. Currently especially one springs to mind: [SQLAlchemy-Pervasive](https://github.com/SacNaturalFoods/sqlalchemy-pervasive) : it needs some serious TLC.
* Currently a strong focus is on database connectivity.
Ultimately an application supporting commandline, curses (TUI), GUI while using all calls available in APIs (Btrieve, Btrieve2, ODBC, JDBC) would be a real bonus. It would cater for demoing, illustrating how calls should be used and obviously would provide a great test, especially if the code could be run using test automation.
This would be a major thing to design and implement properly. Some baby steps in this process alone would be great.

I am fully aware that most code does not comply to above standards. Refactoring all code would take a lot of time which would pospone the initial release or maybe even prevent it.
For this reason I am releasing code which does not meet my views on proper coding.

## Credits
See the Credits.md file. This file applies to the entire project.

## License
See the License.md file. This file applies to the entire project.

## Warning
For sake of completeness and uniformity all access methods mentioned in the programmers manual are listed as options for all languages. The combinations can be quite absurd or exotic. Obviously especially those are not implemented (yet) and/or properly tested.
All code and documentation in this repository is provided as is.


