# daikon-dev.cshrc
# This file should be kept in sync with daikon-dev.bashrc.

if (! $?LC_ALL) setenv LC_ALL en_US

scriptdir=`/bin/dirname $0`       # may be relative path
DAIKONDIR=`cd $scriptdir/.. && pwd`    # ensure absolute path

setenv DAIKONBIN ${DAIKONDIR}/scripts
setenv PLUMEBIN ${DAIKONDIR}/utils/plume-lib/bin
setenv INV ${DAIKONDIR}
setenv inv ${INV}
setenv DAIKONCLASS_SOURCES 1
setenv PAG /afs/csail.mit.edu/group/pag
setenv pag ${PAG}

## Set this directory to the directory containing the JDK.
if (! $?JAVA_HOME) setenv JAVA_HOME /afs/csail/group/pag/software/pkg/jdk

setenv PATH /usr/local/bin:${PATH}:/afs/csail/group/pag/projects/invariants/binaries:$DAIKONDIR/front-end/c

if ($?debuglogin) echo "about to source daikon.cshrc: ${INV}/scripts/daikon.cshrc"
source ${INV}/scripts/daikon.cshrc
if ($?debuglogin) echo "sourced daikon.cshrc from daikon-dev.cshrc"

setenv LD_LIBRARY_PATH /usr/X11R6/lib:/usr/local/lib:/usr/lib:/lib

setenv CLASSPATH `echo $CLASSPATH | path-remove.pl`

# In general, Java programmers should not set CLASSPATH.
# setenv DAIKON_LIBS `/usr/bin/perl -e 'print join(":", @ARGV);' ${INV}/java/lib/*.jar`
# # Using ${INV}/utils/plume-lib seems undesirable.  If a new version of plume-lib
# # deprecates a method, then Daikon won't compile for developers; however,
# # changing Daikon's source code would cause Daikon not to compile for ordinary
# # users.
# # setenv CLASSPATH .:${CLASSPATH}:${DAIKON_LIBS}:${INV}/plume-lib/java/junit-4.12.jar:${INV}/plume-lib/java/plume.jar
# unsetenv DAIKON_LIBS

setenv LACKWIT_HOME ${INV}/front-end/c/lackwit

# Remove duplicates so path and classpath don't get too long
if (-x ${PLUMEBIN}/path-remove.pl) then
  if ($?CLASSPATH) setenv CLASSPATH `echo $CLASSPATH | ${PLUMEBIN}/path-remove.pl`
  setenv PATH `echo $PATH | ${PLUMEBIN}/path-remove.pl`
endif

# Enable use of group bibliographies, and the "bibfind" command.
# Private comments in bib files are not to be shared outside the group.
setenv BIBINPUTS .:$PAG/doc/wisdom/latest-read-only/bib:..:
alias bibfind 'java -jar $pag/software/arch/common/pkg/lookup.jar -l -f $PAG/doc/wisdom/latest-read-only/bib/bibroot'

if (! $?EDITOR) setenv EDITOR emacsclient
if (! $?ALTERNATE_EDITOR) setenv ALTERNATE_EDITOR emacs
if (! $?VISUAL) setenv VISUAL emacsclient
