##########################################################################
### Variables
###

# note that for right now, we are only copying the html and texinfo
# versions of the developer manual (though all other versions are built)
IMAGE_FILES := daikon-logo.gif daikon-logo.png daikon-logo.eps gui-ControlPanel.jpg gui-ControlPanel.eps gui-InvariantsDisplay-small.jpg gui-InvariantsDisplay-small.eps context-gui.jpg context-gui.eps dfepl-flow.png
IMAGE_PARTIAL_PATHS := $(addprefix images/,$(IMAGE_FILES))
DOC_FILES_NO_IMAGES := Makefile daikon.texinfo config-options.texinfo invariants-doc.texinfo daikon.ps daikon.pdf daikon.html developer.texinfo developer.html CHANGES
DOC_FILES := ${DOC_FILES_NO_IMAGES} $(IMAGE_PARTIAL_PATHS)
DOC_PATHS := $(addprefix doc/,$(DOC_FILES))
DOC_FILES_USER := daikon.ps daikon.pdf daikon.html developer.html
EMACS_PATHS := emacs/daikon-context-gui.el
README_FILES := README-daikon-java README-dist README-dist-doc
README_PATHS := $(addprefix doc/,$(README_FILES))
SCRIPT_FILES := Makefile java-cpp.pl daikon.pl lines-from \
	daikon.cshrc daikon.bashrc daikonenv.bat cygwin-runner.pl \
	dfepl dtrace-perl dtype-perl \
	kvasir-dtrace \
	convertcsv.pl \
	trace-untruncate trace-untruncate-fast.c trace-purge-fns.pl trace-purge-vars.pl \
	trace-add-nonces.pl \
	checkargs.pm util_daikon.pm \
	runcluster.pl decls-add-cluster.pl extract_vars.pl dtrace-add-cluster.pl
SCRIPT_PATHS := $(addprefix scripts/,$(SCRIPT_FILES))
# This is so toublesome that it isn't used except as a list of dependences for make commands
DAIKON_JAVA_FILES := $(shell find java \( -name '*daikon-java*' -o -name CVS -o -name 'ReturnBytecodes.java' -o -name 'AjaxDecls.java' -o -name '*ajax-ship*' \) -prune -o -name '*.java' -print) $(shell find java/daikon -follow \( -name '*daikon-java*' -o -name CVS -o -name 'ReturnBytecodes.java' -o -name 'AjaxDecls.java' -o -name '*ajax-ship*' \) -prune -o -name '*.java' -print)
DAIKON_RESOURCE_FILES := daikon/config/example-settings.txt daikon/simplify/daikon-background.txt
AJAX_JAVA_FILES := $(shell find java/ajax-ship/ajax \( -name '*daikon-java*' -o -name CVS -o -name 'ReturnBytecodes.java' -o -name 'AjaxDecls.java' \) -prune -o -name '*.java' -print)
# Find might be cleaner, but this works.
# I don't know why, but a "-o name ." clause makes find err, so use grep instead
# WWW_FILES := $(shell cd doc/www; find . \( -name '*~' -o -name '.*~' -o -name CVS -o -name .cvsignore -o -name '.\#*' -o -name '*.bak' -o -name uw -o name . -o name .. \) -prune -o -print)
# WWW_FILES := $(shell cd doc/www; find . \( \( -name '*~' -o -name '.*~' -o -name CVS -o -name .cvsignore -o -name '.\#*' -o -name '*.bak' -o -name uw \) -prune -a -type f \) -o -print | grep -v '^.$$')
WWW_FILES := $(shell cd doc/www; find . -type f -print | egrep -v '~$$|CVS|.cvsignore|/.\#|.bak$$|uw/')
#WWW_DIR := /home/httpd/html/daikon/
WWW_ROOT := /afs/csail.mit.edu/group/pag/docroot/www.pag.csail.mit.edu/daikon/
WWW_DIR := $(WWW_ROOT)
# This needs not to be hardcoded to a particular users directory if
# anyone else is going to use it.
# MERNST_DIR := /g2/users/mernst
# This is the current directory!  Maybe I don't need a variable for it.
#INV_DIR := $(MERNST_DIR)/research/invariants
INV_DIR := $(shell pwd)
JDKDIR ?= /afs/csail/group/pag/software/pkg/jdk

# Files to copy to the website
WWW_DAIKON_FILES := faq.html index.html mailing-lists.html StackAr.html \
				    anoncvs.html download/index.html download/doc/index.html \
					pubs-sources/abstract-headfoot.html \
					pubs-sources/abstract-headfoot-testsubject.html  \
					pubs-sources/index-headfoot.html \
					pubs-sources/fix-homedir-tilde.pl \
				    pubs-sources/Makefile

# Staging area for the distribution
STAGING_DIST := $(INV_DIR)/dist

# build the windows version of dfej here
MINGW_DFEJ_LOC := $(INV_DIR)

# The crosscompile is stored here
#MINGW_TOOLS := /var/autofs/net/pag/g2/users/mernst/bin/src/mingw32-linux-x86-glibc-2.1

MINGW_TOOLS := /afs/csail/group/pag/software/pkg/mingw32-linux-x86-glibc-2.1

DFEJ_DIR := $(INV_DIR)/dfej
DFEC_DIR := $(INV_DIR)/dfec
C_RUNTIME_PATHS := front-end/c/daikon_runtime.h front-end/c/daikon_runtime.cc
# Old C front end
# EDG_DIR := $(INV_DIR)/edg/dist
# EDG_DIR := $(INV_DIR)/c-front-end
# $(EDG_DIR)/edgcpfe is distributed separately (not in the main tar file)
# EDG_FILES := $(EDG_DIR)/dump_trace.h $(EDG_DIR)/dump_trace.c $(EDG_DIR)/dfec $(EDG_DIR)/dfec.sh

DIST_DIR := $(WWW_ROOT)/dist
MIT_DIR  := $(WWW_ROOT)/mit
DIST_BIN_DIR := $(DIST_DIR)/binaries
DIST_PAG_BIN_DIR := /afs/csail/group/pag/projects/invariants/binaries
# Files that appear in the top level of the distribution directory
DIST_DIR_FILES := daikon.tar.gz daikon-logo.gif daikon.jar
DIST_DIR_PATHS := daikon.tar.gz daikon.zip doc/images/daikon-logo.gif daikon.jar
# # Location for NFS-mounted binaries
# NFS_BIN_DIR := /g2/users/mernst/research/invariants/binaries

CVS_REPOSITORY := /afs/csail.mit.edu/group/pag/projects/invariants/.CVS

# It seems like these should come from their standard locations (jhp)
#RTJAR := /g2/users/mernst/java/jdk/jre/lib/rt.jar
#TOOLSJAR := /g2/users/mernst/java/jdk/lib/tools.jar
RTJAR := $(JDKDIR)/jre/lib/rt.jar
TOOLSJAR := $(JDKDIR)/lib/tools.jar

JUNIT_VERSION := junit3.8.1

# for "chgrp, we need to use the number on debian, 14127 is invariants"
INV_GROUP := 14127

RM_TEMP_FILES := rm -rf `find . \( -name UNUSED -o -name CVS -o -name SCCS -o -name RCS -o -name '*.o' -o -name '*~' -o -name '.*~' -o -name '.cvsignore' -o -name '*.orig' -o -name 'config.log' -o -name '*.java-*' -o -name '*to-do' -o -name 'TAGS' -o -name '.\#*' -o -name '.deps' -o -name jikes -o -name dfej -o -name dfej-linux -o -name dfej-linux-x86 -o -name 'dfej-solaris*' -o -name 'dfej-dynamic' -o -name daikon-java -o -name daikon-output -o -name core -o -name '*.bak' -o -name '*.rej' -o -name '*.old' -o -name '.nfs*' -o -name '\#*\#' \) -print`


## Examples of better ways to get the lists:
# PERL_MODULES := $(wildcard *.pm)
# PERL_SCRIPTS := $(wildcard *.pl)
# PERL_SCRIPTS += em_analyze em_reports cppp
# PERL_MODULE_TEXI := $(patsubst %.pm,%.texi,$(PERL_MODULES))
# PERL_MODULE_INFO := $(patsubst %.pm,%.info,$(PERL_MODULES))
# PERL_MODULE_MAN := $(patsubst %.pm,%.man,$(PERL_MODULES))
# PERL_MODULE_HTML := $(patsubst %.pm,%.html,$(PERL_MODULES))


###########################################################################
### Rules
###

### Default tag
help:
	@echo "Targets:"
	@echo " compile compile-java"
	@echo " junit test"
	@echo " tags TAGS"
	@echo " install PAG specific files pag-install"
	@echo "Creating the Daikon distribution:"
	@echo " daikon.tar daikon.jar    -- just makes the tar files"
	@echo " staging                  -- moves all release file to $inv/dist"
	@echo " test-staged-dist         -- tests the distribution in $inv/dist"
	@echo " staging-to-www           -- copies $inv/dist to website"
	@echo " "
	@echo "This Makefile is for manipulations of the entire invariants module."
	@echo "Daikon proper can be found in the java/daikon subdirectory."

### Compiling the code

compile: compile-java

compile-java:
	cd java && $(MAKE) all

clean-java:
	cd java && $(MAKE) clean

### Kvasir (C front end)

kvasir/kvasir/Makefile.in:
	cvs -d $(CVS_REPOSITORY) co -P valgrind-kvasir
	ln -s valgrind-kvasir kvasir
	cd kvasir && cvs -d $(CVS_REPOSITORY) co -P kvasir
	touch $@

kvasir/config.status: kvasir/kvasir/Makefile.in
	cd kvasir && ./configure --prefix=`pwd`/inst

kvasir/coregrind/valgrind: kvasir/config.status
	cd kvasir && $(MAKE)

kvasir/kvasir/vgskin_kvasir.so: kvasir/coregrind/valgrind kvasir/kvasir/*.[ch]
	cd kvasir/kvasir && $(MAKE)

kvasir/inst/bin/valgrind: kvasir/coregrind/valgrind
	cd kvasir && $(MAKE) install

kvasir/inst/lib/valgrind/vgskin_kvasir.so: kvasir/kvasir/vgskin_kvasir.so
	cd kvasir/kvasir && $(MAKE) install

kvasir: kvasir/inst/bin/valgrind kvasir/inst/lib/valgrind/vgskin_kvasir.so

build-kvasir: kvasir

### Testing the code

test:
	cd tests && $(MAKE) all

junit:
	cd java && $(MAKE) junit

### Tags

tags: TAGS

TAGS:
	cd java && $(MAKE) tags

###########################################################################
### Test the distribution
###

DISTTESTDIR := /tmp/daikon.dist
DISTTESTDIRJAVA := /tmp/daikon.dist/daikon/java

# Test that the files in the staging area are correct.
test-staged-dist: $(STAGING_DIST)
	-rm -rf $(DISTTESTDIR)
	mkdir $(DISTTESTDIR)
	(cd $(DISTTESTDIR); tar xzf $(STAGING_DIST)/download/daikon.tar.gz)
	## First, test daikon.jar.
	(cd $(DISTTESTDIR)/daikon/java && \
	  $(MAKE) CLASSPATH=$(DISTTESTDIR)/daikon/daikon.jar junit)
	## Second, test the .java files.
	# No need to add to classpath: ":$(DISTTESTDIRJAVA)/lib/java-getopt.jar:$(DISTTESTDIRJAVA)/lib/junit.jar"
	# Use javac, not jikes; jikes seems to croak on longer-than-0xFFFF
	# method or class.
	(cd $(DISTTESTDIRJAVA)/daikon; touch ../java/ajax; rm `find . -name '*.class'`; make CLASSPATH=$(DISTTESTDIRJAVA):$(RTJAR):$(TOOLSJAR) all_javac)
	(cd $(DISTTESTDIR)/daikon/java && $(MAKE) CLASSPATH=$(DISTTESTDIRJAVA) junit)
	# Test the main target of the makefile
	cd $(DISTTESTDIR)/daikon && make

# I would rather define this inside the cvs-test rule.  (In that case I
# must use "$$FOO", not $(FOO), to refer to it.)
TESTCVS=/scratch/$(USER)/daikon.cvs
TESTCVSJAVA=$(TESTCVS)/invariants/java

cvs-test:
	-rm -rf $(TESTCVS)
	mkdir -p $(TESTCVS)
	cd $(TESTCVS) && cvs -Q -d $(CVS_REPOSITORY) co invariants
	cd $(TESTCVSJAVA)/daikon && make CLASSPATH=$(TESTCVSJAVA):$(TESTCVSJAVA)/lib/java-getopt.jar:$(TESTCVSJAVA)/lib/junit.jar:.:$(RTJAR):$(TOOLSJAR)


###########################################################################
### Distribution
###

# Main distribution

# The staging target builds all of the files that will be distributed
# to the website in the directory $(STAGING_DIST).  This includes:
# daikon.tar.gz, daikon.zip, daikon.jar, javadoc, dfej-linux-x86
# (static version), dfej.exe (mingw windows) and the documentation.
# See the dist target for moving these files to the website.
# Note that this process does NOT include: dfej-cygwin.exe, dfej-solaris,
# dfej-macosx, dfec-linux-x86.tar.gz and dfec-solaris.tar.gz.  These
# must be built separately.
staging: doc/CHANGES update-doc-dist-date-and-version
	/bin/rm -rf $(STAGING_DIST)
	install -d $(STAGING_DIST)/download
	# Build the main tarfile for daikon
	@echo "]2;Building daikon.tar"
	$(MAKE) daikon.tar
	mv daikon.jar $(STAGING_DIST)/download
	# Build javadoc
	@echo "]2;Building Java doc"
	install -d $(STAGING_DIST)/download/jdoc
	cd java; make 'JAVADOC_DEST=$(STAGING_DIST)/download/jdoc' doc
	# Copy the documentation
	@echo "]2;Copying documentation"
	install -d $(STAGING_DIST)/download/doc
	cd doc && cp -pf $(DOC_FILES_USER) $(STAGING_DIST)/download/doc
	cp -pR doc/images $(STAGING_DIST)/download/doc
	cp -pR doc/daikon_manual_html $(STAGING_DIST)/download/doc
	cd doc/www && cp --parents -pf $(WWW_DAIKON_FILES) $(STAGING_DIST)
	# Build static dfej and copy to staging dir
	@echo "]2;Building static dfej"
	$(MAKE) static-dfej-linux-x86
	install -d $(STAGING_DIST)/download/bin
	cp $(DFEJ_DIR)/src/dfej-linux-x86 $(STAGING_DIST)/download/bin
	# Build the windows (mingw) version of dfej and copy to staging dir
	@echo "]2;Building mingw dfej"
	$(MAKE) mingw
	cp $(MINGW_DFEJ_LOC)/build_mingw_dfej/src/dfej.exe \
	  $(STAGING_DIST)/download/bin/dfej.exe
	# all distributed files should be readonly
	chmod -R -w $(STAGING_DIST)
	# compare new list of files in tarfile to previous list
	@echo "]2;New or removed files"
	@echo "***** New or removed files:"
	tar tzf $(WWW_ROOT)/download/daikon.tar.gz | sort > /tmp/old_tar.txt
	tar tzf $(STAGING_DIST)/download/daikon.tar.gz | sort > /tmp/new_tar.txt
	-diff -u /tmp/old_tar.txt /tmp/new_tar.txt

# Copy the files in the staging area to the website.  This will copy
# all of the files in staging, but will not delete any files in the website
# that are not in staging.  T
staging-to-www: $(STAGING_DIST)
	(cd $(STAGING_DIST) && tar cf - .) | (cd $(WWW_ROOT) && tar xfBp -)
	@echo "**Update the dates and sizes in the various index files**"
	update-link-dates $(DIST_DIR)/index.html
	$(MAKE) update-dist-version-file
	@echo "*****"
	@echo "Don't forget to send mail to daikon-announce and commit changes."
	@echo "(See sample messages in ~mernst/research/invariants/mail/daikon-lists.mail.)"
	@echo "*****"


# Webpages of publications that use Daikon
pubs:
	$(MAKE) -C doc/www pubs

doc/CHANGES: doc/daikon.texinfo doc/config-options.texinfo \
			 doc/invariants-doc.texinfo
	@echo "******************************************************************"
	@echo "** doc/CHANGES file is not up-to-date with respect to doc files."
	@echo "** doc/CHANGES must be modified by hand."
	@echo "** Try:"
	@echo "     diff -u -s --from-file   $(WWW_ROOT)/dist/doc doc/*.texinfo"
	@echo "** (or maybe  touch doc/CHANGES )."
	@echo "******************************************************************"
	@exit 1


doc-all:
	# "make" in doc directory may fail the first time, but do show output.
	-cd doc && $(MAKE) all
	cd doc && $(MAKE) all

# Perl command compresses multiple spaces to one, for first 9 days of month.
TODAY := $(shell date "+%B %e, %Y" | perl -p -e 's/  / /')

update-doc-dist-date-and-version:
	$(MAKE) update-doc-dist-date
	$(MAKE) update-doc-dist-version

# Update the documentation with a new distribution date (today).
# This is done immediately before releasing a new distribution.
update-doc-dist-date:
	perl -wpi -e 'BEGIN { $$/="\n\n"; } s/(\@c Daikon version .* date\n\@center ).*(\n)/$$1${TODAY}$$2/;' doc/daikon.texinfo doc/developer.texinfo
	perl -wpi -e 's/(Daikon version .*, released ).*(\.)$$/$$1${TODAY}$$2/' doc/README-dist doc/README-dist-doc doc/www/download/index.html doc/daikon.texinfo doc/developer.texinfo
	perl -wpi -e 's/(public final static String release_date = ").*(";)$$/$$1${TODAY}$$2/' java/daikon/Daikon.java
	touch doc/CHANGES

# Update the documentation according to the version number in VERSION.
# This isn't done as part of "make dist" because then subsequent "make www"
# would show the new version.
# I removed the dependence on "update-dist-version-file" because this rule
# is invoked at the beginning of a make.
update-doc-dist-version:
	perl -wpi -e 'BEGIN { $$/="\n\n"; } s/(Daikon version )[0-9]+(\.[0-9]+)*/$$1 . "$(shell cat doc/VERSION)"/e;' doc/daikon.texinfo doc/README-dist doc/README-dist-doc doc/www/download/index.html doc/developer.texinfo
	perl -wpi -e 's/(public final static String release_version = ")[0-9]+(\.[0-9]+)*(";)$$/$$1 . "$(shell cat doc/VERSION)" . $$3/e;' java/daikon/Daikon.java
	perl -wpi -e 's/(VG_\(details_version\)\s*\(")[0-9]+(\.[0-9]+)*("\);)$$/$$1 . "$(shell cat doc/VERSION)" . $$3/e' kvasir/kvasir/memcheck/mc_main.c
	cvs ci -m "Update version number for new Daikon distribution" kvasir/kvasir/memcheck/mc_main.c
	touch doc/CHANGES

# Update the version number.
# This is done immediately after releasing a new version; thus, VERSION
# refers to the next version to be released, not the previously-released one.
# This isn't a part of the "update-dist-version" target because if it is,
# the "shell cat" command gets the old VERSION file.
# (Note that the last element of VERSION may be negative, such as "-1".
# This is useful in order to make the next version end with ".0".)
update-dist-version-file:
	perl -wpi -e 's/\.(-?[0-9]+)$$/"." . ($$1+1)/e' doc/VERSION

# Perhaps daikon.jar shouldn't include JUnit or the test files.
daikon.jar: java/lib/ajax.jar $(DAIKON_JAVA_FILES) $(patsubst %,java/%,$(DAIKON_RESOURCE_FILES))
	-rm -rf $@ /tmp/${USER}/daikon-jar
	install -d /tmp/${USER}/daikon-jar
	cd java && $(MAKE) JAVAC='javac -g -d /tmp/${USER}/daikon-jar -classpath ${INV_DIR}/java:${INV_DIR}/java/lib/java-getopt.jar:${INV_DIR}/java/lib/junit.jar:$(TOOLSJAR)' all_directly
	cd java/utilMDE && $(MAKE) JAVAC='javac -g -d /tmp/${USER}/daikon-jar -classpath .:${INV_DIR}/java/lib/junit.jar' all_notest
	## Old untarring code:
	#  tar xzf java/lib/java-getopt-1.0.8.tar.gz -C /tmp/${USER}/daikon-jar
	#  tar xzf java/lib/OROMatcher-1.1.tar.gz -C /tmp/${USER}/daikon-jar
	#  mv /tmp/${USER}/daikon-jar/OROMatcher-1.1.0a/com /tmp/${USER}/daikon-jar
	#  rm -rf /tmp/${USER}/daikon-jar/OROMatcher-1.1.0a
	# jar does not seem to accept the -C argument.  MDE 6/14/2001
	# jar xf java/lib/java-getopt.jar -C /tmp/${USER}/daikon-jar
	# jar xf java/lib/junit.jar -C /tmp/${USER}/daikon-jar
	(cd /tmp/${USER}/daikon-jar; jar xf $(INV_DIR)/java/lib/java-getopt.jar)
	# (cd /tmp/${USER}/daikon-jar; jar xf $(INV_DIR)/java/lib/jtb-1.1.jar)
	(cd /tmp/${USER}/daikon-jar; jar xf $(INV_DIR)/java/lib/ajax.jar)
	(cd /tmp/${USER}/daikon-jar; jar xf $(INV_DIR)/java/lib/junit.jar)
	(cd java; cp -f --parents --target-directory=/tmp/${USER}/daikon-jar $(DAIKON_RESOURCE_FILES))
	cd /tmp/${USER}/daikon-jar && jar cf $@ *
	mv /tmp/${USER}/daikon-jar/$@ $@
	rm -rf /tmp/${USER}/daikon-jar

java/lib/ajax.jar: $(AJAX_JAVA_FILES)
	-rm -rf $@ /tmp/${USER}/ajax-jar
	mkdir -p /tmp/${USER}/ajax-jar
	javac -g -d /tmp/${USER}/ajax-jar $(AJAX_JAVA_FILES)
	cd /tmp/${USER}/ajax-jar && jar cf ajax.jar *
	mv /tmp/${USER}/ajax-jar/ajax.jar $@
	rm -rf /tmp/${USER}/ajax-jar

# This rule creates the files that comprise the distribution, but does
# not copy them anywhere.
# This rule could be changed to check out a fresh version of the
# repository, then tar from there.  Then there would be no need to be so
# careful about not including extraneous files in the distribution, and one
# could make a distribution even if there were diffs in the current
# checkout.
daikon.tar daikon.zip: doc-all $(DOC_PATHS) $(EDG_FILES) $(README_PATHS) $(DAIKON_JAVA_FILES) daikon.jar java/Makefile

	install -d $(STAGING_DIST)
	-rm -rf /tmp/daikon
	mkdir /tmp/daikon

	mkdir /tmp/daikon/doc
	cp -p doc/README-dist /tmp/daikon/README
	cp -p doc/README-dist-doc /tmp/daikon/doc/README
	cd doc && cp -p $(DOC_FILES_NO_IMAGES) /tmp/daikon/doc
	mkdir /tmp/daikon/doc/images
	cd doc && cp -p $(IMAGE_PARTIAL_PATHS) /tmp/daikon/doc/images
	cp -pR doc/daikon_manual_html /tmp/daikon/doc

	# Emacs
	mkdir /tmp/daikon/emacs
	cp -p $(EMACS_PATHS) /tmp/daikon/emacs

	# Auxiliary programs
	mkdir /tmp/daikon/bin
	cp -p $(SCRIPT_PATHS) /tmp/daikon/bin

	# Java example files
	mkdir /tmp/daikon/examples
	cp -pR examples/{StackAr,QueueAr} /tmp/daikon/examples
	# Keep .java files, delete everything else
	cd /tmp/daikon && find examples -name '*.java' -prune -o \( -type f -o -name CVS -o -name daikon-output -o -name daikon-java -o -name daikon-instrumented \) -print | xargs rm -rf

	# Perl example files
	mkdir /tmp/daikon/examples/perl-examples
	cp -p examples/perl-examples/{Birthday.{pm,accessors},{test_bday,standalone}.pl} /tmp/daikon/examples/perl-examples

	# C example files for dfec
	cp examples/c-examples.tar.gz /tmp/daikon/examples
	cd /tmp/daikon/examples && tar zxf c-examples.tar.gz
	rm /tmp/daikon/examples/c-examples.tar.gz

	# C example files for Kvasir
	mkdir /tmp/daikon/examples/kvasir-examples
	mkdir /tmp/daikon/examples/kvasir-examples/bzip2
	cp -p examples/kvasir-examples/bzip2/bzip2.c /tmp/daikon/examples/kvasir-examples/bzip2

	# chgrp -R $(INV_GROUP) /tmp/daikon

	cp -p daikon.jar /tmp/daikon
	# # Now we are ready to make the daikon-compiled distribution
	# (cd /tmp; tar cf daikon-compiled.tar daikon)
	# cp -pf /tmp/daikon-compiled.tar .

	## Now make the daikon distribution
	# First add some more files to the distribution

	cp -p Makefile-dist /tmp/daikon/Makefile

	# Daikon itself
	(cd java; tar chf /tmp/daikon-java.tar --exclude daikon-java --exclude daikon-output --exclude Makefile.user daikon)
	(mkdir /tmp/daikon/java; cd /tmp/daikon/java; tar xf /tmp/daikon-java.tar; rm /tmp/daikon-java.tar)
	cp -p doc/README-daikon-java /tmp/daikon/java/README
	cp -p java/Makefile /tmp/daikon/java/Makefile
	# Maybe I should do  $(MAKE) doc
	# Don't do  $(MAKE) clean  which deletes .class files
	(cd /tmp/daikon/java; $(RM_TEMP_FILES))

	# Java support files
	## utilMDE
	(cd java/utilMDE; $(MAKE) utilMDE.tar.gz)
	cd java && tar zxf utilMDE/utilMDE.tar.gz -C /tmp/daikon/java
	rm -rf /tmp/daikon/java/utilMDE/doc
	## getopt
	tar zxf java/lib/java-getopt-1.0.8.tar.gz -C /tmp/daikon/java
	## Apache packages
	mkdir /tmp/daikon/java/org
	mkdir /tmp/daikon/java/org/apache
	## JTB
	cp -pR java/jtb /tmp/daikon/java/
	## Ajax
	cp -pR java/ajax-ship /tmp/daikon/java
	rm -rf /tmp/daikon/java/ajax-ship/ajax
	cp -pf java/lib/ajax.jar /tmp/daikon/java/ajax-ship/

	## JUnit
	# This is wrong:
	#   unzip java/lib/$(JUNIT_VERSION).zip -d /tmp/daikon/java
	#   (cd /tmp/daikon/java; ln -s $(JUNIT_VERSION)/junit .)
	# Need to extract a jar file in the zip file, then unjar that.
	# (src.jar only contains .java files, not .class files.)
	mkdir /tmp/daikon/tmp-junit
	unzip java/lib/$(JUNIT_VERSION).zip $(JUNIT_VERSION)/cpl-v10.html $(JUNIT_VERSION)/src.jar -d /tmp/daikon/tmp-junit
	(cd /tmp/daikon/tmp-junit; unzip $(JUNIT_VERSION)/src.jar; rm -f $(JUNIT_VERSION)/src.jar; mv $(JUNIT_VERSION)/cpl-v10.html junit; rmdir $(JUNIT_VERSION); chmod -R +x *; find . -type f -print | xargs chmod -x; rm -rf META-INF TMP; mv junit /tmp/daikon/java/)
	rm -rf /tmp/daikon/tmp-junit
	(cd /tmp/daikon/java/junit; javac -g `find . -name '*.java'`)

	## Front ends
	mkdir /tmp/daikon/front-end

	# # C/C++ instrumenter -- now distributed separately
	# mkdir /tmp/daikon/front-end/c
	# cp -p $(C_RUNTIME_PATHS) /tmp/daikon/front-end/c

	# Java instrumenter
	# The -h option saves symbolic links as real files, to avoid problem
	# with the fact that I've made dfej into a symbolic link.
	(cd $(DFEJ_DIR)/..; tar chf /tmp/dfej.tar --exclude '*.o' --exclude 'src/dfej' --exclude 'src.tar' dfej)
	# (cd /tmp/daikon; tar xf /tmp/dfej.tar; mv dfej front-end/java; rm /tmp/dfej.tar)
	# For debugging
	(cd /tmp/daikon; tar xf /tmp/dfej.tar; mv dfej front-end/java)
	# the subsequence rm -rf shouldn't be necessary one day,
	# but for the time being (and just in case)...
	# (cd /tmp/daikon/java-front-end; $(MAKE) distclean; (cd src; $(MAKE) distclean); $(RM_TEMP_FILES))
	(cd /tmp/daikon/front-end/java; $(MAKE) distclean; $(RM_TEMP_FILES) )

	# Perl front end
	# mkdir /tmp/daikon/front-end/perl
	cp -pR front-end/perl /tmp/daikon/front-end
	(cd /tmp/daikon/front-end/perl; $(RM_TEMP_FILES) )

	# Kvasir C front end
	cd /tmp/daikon; cvs -d $(CVS_REPOSITORY) co -P valgrind-kvasir
	mv /tmp/daikon/valgrind-kvasir /tmp/daikon/kvasir
	cd /tmp/daikon/kvasir; cvs -d $(CVS_REPOSITORY) co -P kvasir
	find /tmp/daikon/kvasir -name '.cvsignore' | xargs rm
	find /tmp/daikon/kvasir -name 'CVS' -type d | xargs rm -rf
	find /tmp/daikon/kvasir/kvasir -name '*.txt' -type f | xargs rm
	rm -rf /tmp/daikon/kvasir/kvasir/unittest-files

	## Tools
	cp -pR tools /tmp/daikon
	(cd /tmp/daikon/tools; $(RM_TEMP_FILES); rm -f kmeans/kmeans; (cd hierarchical; rm -f clgroup cluster den difftbl) )

	## Make the source distribution proper
	rm -rf `find /tmp/daikon -name CVS`
	(cd /tmp; tar cf daikon.tar daikon)
	gzip -c /tmp/daikon.tar > $(STAGING_DIST)/download/daikon.tar.gz
	# cp -pf /tmp/daikon.tar
	rm -f /tmp/daikon.zip
	(cd /tmp; zip -r daikon daikon)
	cp -pf /tmp/daikon.zip $(STAGING_DIST)/download/daikon.zip

# Rule for daikon.tar.gz
%.gz : %
	-rm -rf $@
	gzip -c $< > $@


### Front end binaries

## C/C++ front end

dist-dfec: dist-dfec-linux

dist-dfec-linux:
	cd $(DFEC_DIR) && $(MAKE) dfec dfec-static
	cp -pf $(DFEC_DIR)/src/dfec-static $(DIST_BIN_DIR)/dfec-linux-x86
	cp -pf $(DFEC_DIR)/src/dfec $(DIST_BIN_DIR)/dfec-linux-x86-dynamic
	update-link-dates $(DIST_DIR)/index.html
	# cp -pf $(DFEC_DIR)/src/dfec $(NFS_BIN_DIR)

## Java front end

.PRECIOUS: $(DFEJ_DIR)/src/dfej
$(DFEJ_DIR)/src/dfej:
	cd $(DFEJ_DIR) && $(MAKE)

## Don't distribute executables for now

# Make the current dfej the one used by the PAG group
# (Warning:  As of 7/3/2002 the DIST_PAG_BIN_DIR version is not used by
# $inv/tests/Makefile.common!)
dist-dfej-pag: $(DIST_PAG_BIN_DIR)/dfej

$(DIST_PAG_BIN_DIR)/dfej: $(DFEJ_DIR)/src/dfej
	cp -pf $< $@

# Make the current dfej the one distributed to the world
dist-dfej: dist-dfej-pag dist-dfej-linux-x86 dist-dfej-windows

dist-dfej-solaris: $(DIST_BIN_DIR)/dfej-solaris

$(DIST_BIN_DIR)/dfej-solaris: $(DFEJ_DIR)/src/dfej-solaris
	cp -pf $< $@
	# strip $@
	chmod +r $@
	update-link-dates $(DIST_DIR)/index.html
	# cat /dev/null | mail -s "make dist-dfej   has been run" kataoka@cs.washington.edu mernst@csail.mit.edu

dist-dfej-cygwin: $(DIST_BIN_DIR)/dfej-cygwin.exe

$(DIST_BIN_DIR)/dfej-cygwin.exe: $(DFEJ_DIR)/src/dfej-cygwin.exe
	cp -pf $< $@
	# strip $@
	chmod +r $@
	update-link-dates $(DIST_DIR)/index.html
	# cat /dev/null | mail -s "make dist-dfej   has been run" kataoka@cs.washington.edu mernst@csail.mit.edu

static-dfej-linux-x86: $(DFEJ_DIR)/src/dfej
	# Move away the dynamic version and build the static one.
	# The result is in $(DFEJ_DIR)/src/dfej-linux-x86
	-mv -f $(DFEJ_DIR)/src/dfej $(DFEJ_DIR)/src/dfej-dynamic
	-mv -f $(DFEJ_DIR)/src/dfej-linux-x86 $(DFEJ_DIR)/src/dfej
	cd $(DFEJ_DIR)/src && $(MAKE) LDFLAGS=-static
	mv -f $(DFEJ_DIR)/src/dfej $(DFEJ_DIR)/src/dfej-linux-x86
	mv -f $(DFEJ_DIR)/src/dfej-dynamic $(DFEJ_DIR)/src/dfej

dist-dfej-linux-x86: $(DFEJ_DIR)/src/dfej static-dfej-linux-x86
	# Now copy it over
	cp -pf $(DFEJ_DIR)/src/dfej-linux-x86 $(DIST_BIN_DIR)/dfej-linux-x86
	cp -pf $(DFEJ_DIR)/src/dfej $(DIST_BIN_DIR)/dfej-linux-x86-dynamic
	strip $(DIST_BIN_DIR)/dfej-linux-x86 $(DIST_BIN_DIR)/dfej-linux-x86-dynamic
	chmod +r $(DIST_BIN_DIR)/dfej-linux-x86 $(DIST_BIN_DIR)/dfej-linux-x86-dynamic
	update-link-dates $(DIST_DIR)/index.html
	# # Unstripped, to permit better debugging
	# cp -pf $(DFEJ_DIR)/src/dfej $(NFS_BIN_DIR)
	# cat /dev/null | mail -s "make dist-dfej   has been run" kataoka@cs.washington.edu mernst@csail.mit.edu

# use this target to test building mingw without distributing anything
mingw : mingw_exe

# Creates the build_mingw_dfej directory.  This probably needs to be redone
# when dfej is changed to include new object files or other Makefile changes.
# Path must include /g2/users/mernst/bin/src/mingw32-linux-x86-glibc-2.1/cross-tools/bin
$(MINGW_DFEJ_LOC)/build_mingw_dfej:
	cd dfej && $(MAKE) distclean
	mkdir $(MINGW_DFEJ_LOC)/build_mingw_dfej
	# Bad hacks to fix problems in mingw32.  Need to be resolved
	#cp /g6/users/jhp/mingw32/crt2.o $(MINGW_DFEJ_LOC)/build_mingw_dfej
	#mkdir $(MINGW_DFEJ_LOC)/build_mingw_dfej/src
	#cp /g6/users/jhp/mingw32/crt2.o $(MINGW_DFEJ_LOC)/build_mingw_dfej/src
	#cp /usr/i386-glibc21-linux/include/regex.h $(MINGW_DFEJ_LOC)/build_mingw_dfej/src
	# Configure mingw version
	(PATH=$(MINGW_TOOLS)/cross-tools/bin:$$PATH; echo $$PATH; cd $(MINGW_DFEJ_LOC)/build_mingw_dfej &&  ~/research/invariants/dfej/configure --prefix=/tmp/dfej_Xmingw --host=i386-mingw32msvc)
	cd dfej && ./configure

# dfej-src/build_mingw_dfej/src/dfej.exe:
# 	cd dfej-src/build_mingw_dfej; setenv PATH /g2/users/mernst/bin/src/mingw32-linux-x86-glibc-2.1/cross-tools/bin:$(PATH); $(MAKE)

mingw_exe: $(MINGW_DFEJ_LOC)/build_mingw_dfej $(MINGW_DFEJ_LOC)/build_mingw_dfej/src/dfej.exe

$(MINGW_DFEJ_LOC)/build_mingw_dfej/src/dfej.exe: dfej/src/*.cpp dfej/src/*.h
	(cd $(MINGW_DFEJ_LOC)/build_mingw_dfej && export PATH=$(MINGW_TOOLS)/cross-tools/bin:${PATH} && $(MAKE))

dist-dfej-windows: $(MINGW_DFEJ_LOC)/build_mingw_dfej \
				   $(MINGW_DFEJ_LOC)/build_mingw_dfej/src/dfej.exe mingw_exe
	cp -pf $(MINGW_DFEJ_LOC)/build_mingw_dfej/src/dfej.exe \
		   $(DIST_BIN_DIR)/dfej.exe
	chmod +r $(DIST_BIN_DIR)/dfej.exe
	update-link-dates $(DIST_DIR)/index.html

## Cross-compiling DFEJ to create a Windows executable (instructions by
## Michael Harder <mharder@MIT.EDU>):
# 1.  Get the mingw32 cross-compiler for Linux.  Details are avaliable at:
# http://www.mingw.org/mingwfaq.shtml#faq-cross.  A pre-built version for
# Linux is available at:
# http://www.devolution.com/~slouken/SDL/Xmingw32/mingw32-linux-x86-glibc-2.1.tar.gz
# 
# 2.  Extract mingw32-linux-x86-glibc-2.1.tar.gz.  The cross compiler tools
# are in cross-tools/bin.  The tools start with "i386-mingw32msvc-".  These
# tools need to be in your path when you build the Windows binary (including
# when you configure the Windows binary).
# 
# 
# The following instructions are adapted from daikon/java-front-end/INSTALL
# 
# 3.  Make a separate directory to build the Windows executable.
# 
# mkdir build_mingw; cd build_mingw
# 
# 4.  Run the dfej configure script, with a target platform of
# "i386-mingw32msvc".  Assume the dfej source is at ~/daikon/java-front-end.
# 
# ~/daikon/java-front-end/configure --prefix=/tmp/dfej_Xmingw
# --host=i386-mingw32msvc
# 
# Add additional arguments to configure as desired.  I don't know what the
# "--prefix" flag is for, but they use it in the jikes INSTALL instructions.
# 
# 5.  Run "make".  This should make the Windows binary at
# build_mingw/src/dfej.exe.  Copy this file to a Windows machine, and run
# it.  You should at least get the Daikon usage message.


###########################################################################
### Utilities
###

#
# Copies PAG specific files to the website and group area
WWW_PAG_FILES := doc/www/mit/eclipse-pag.html \
				 doc/www/mit/index.html \
				 doc/www/mit/pag-account.html \
				 scripts/log2html.php \
				 scripts/emacs_launch.php
GROUP_FILES   := scripts/pag-daikon.bashrc scripts/pag-daikon.cshrc

pag-install:
	install --mode=ugo=r -p $(WWW_PAG_FILES) $(MIT_DIR)
	install --mode=ugo=r -p $(GROUP_FILES) /afs/csail/group/pag/software/bin
	install --mode=ugo=r -p emacs/daikon-group.el \
	  /afs/csail/group/pag/software/config/emacs-daikon-group.el

showvars:
	@echo "DAIKON_JAVA_FILES = " $(DAIKON_JAVA_FILES)
	@echo "AJAX_JAVA_FILES = " $(AJAX_JAVA_FILES)
	@echo "WWW_FILES = " $(WWW_FILES)
	@echo "DIST_DIR_PATHS = " $(DIST_DIR_PATHS)



## v2 is now obsolete, so there is no longer any need to perform these steps.
# Only run the "setup" targets once.
setup-v2-and-v3: setup-v2-and-v3-tests setup-v2-and-v3-daikon

setup-v2-and-v3-daikon:
	mv java/daikon daikon.ver3
	cvs update -d -P -r ENGINE_V2_PATCHES java/daikon
	mv java/daikon daikon.ver2
	ln -s daikon.ver3 java/daikon

setup-v2-and-v3-tests:
	mv tests tests.ver3
	cvs update -d -P -r ENGINE_V2_PATCHES tests
	mv tests tests.ver2
	ln -s tests.ver3 java/daikon


# To set up the version-2 and version-3 directories:
# Use the above setup-v2-and-v3 target after updating your invariants
# directory so that it only contains V3 stuff.

use-%: daikon-is-symlink
	[ -e daikon.$* ]
	[ -e tests.$* ]
	rm -f java/daikon
	ln -s ../daikon.$* java/daikon
	$(MAKE) tags >& /dev/null &
	rm -f tests
	ln -s tests.$* tests

daikon-is-symlink:
	[ ! -e java/daikon ] || [ -L java/daikon ] # daikon must be symlink if it exists
	[ ! -e tests ] || [ -L tests ] # tests must be symlink if it exists
