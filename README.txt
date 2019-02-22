$Id: README.txt 1821623 2018-01-19 11:34:19Z kkolinko $

The Apache Tomcat Website Instructions
---------------------------------------

***NOTE***
DO NOT EDIT THE .html files in the docs directory.
Please follow the directions below for updating the website.
***NOTE***

The Tomcat web site is based on .xml files which are transformed
into .html files using XSLT and Ant.

In order to make modifications to the Tomcat web site, you need to first check out
the Tomcat site from SVN. To check out the Tomcat site into a sub-directory
called tomcat-site in the current directory:

Complete checkout:

  svn checkout https://svn.apache.org/repos/asf/tomcat/site/trunk tomcat-site

Sparse checkout:

  It is faster as it omits subdirectories that you might be currently not
  interested in, but keeps the main Tomcat site.

  The commands:

    svn checkout --depth immediates https://svn.apache.org/repos/asf/tomcat/site/trunk tomcat-site
    cd tomcat-site
    svn update --set-depth immediates docs
    svn update --set-depth infinity xdocs jk-xdocs native-xdocs
    svn update --set-depth infinity docs/articles docs/res

  This checkout omits a number of subdirectories inside of docs/. You will
  see them as empty subdirectories there. It you need to work on any of
  them, you can retrieve their contents using the
  "svn update --set-depth infinity" command.

Once you have the site checked out locally, cd into your
tomcat-site directory and execute:

  ant

This will build the documentation from xdocs/ into the docs/ directory. The
output will show you which files got re-generated.

If you would like to make modifications to the web site documents,
you simply need to edit the files in the xdocs/ directory.

The files in xdocs/stylesheets are the global files for the site. If you make a
modification to project.xml, it will affect the left side navigation for the
web site and all of your .html files will be re-generated.

Once you have built your documentation and confirmed that your changes are
OK, you can commit your changed .xml and .html files into Subversion.

The Subversion repository is configured with svn-pub-sub module so that
when you commit changes into the docs/ directory, they are automatically
reflected on the live tomcat.apache.org site. This happens almost
immediately, so go to http://tomcat.apache.org/ and have fun.


To update the documentation for Tomcat 7.0.x, 8.0.x, 8.5.x or 9.0.x:
=====================================================================

1. If you are using the "sparse" checkout feature, make sure that
   subdirectories in the docs/ directory for the relevant Tomcat versions
   are fully present in your working copy.

   The commands are:

   cd tomcat-site
   svn up --set-depth infinity docs/tomcat-7.0-doc
   svn up --set-depth infinity docs/tomcat-8.0-doc
   svn up --set-depth infinity docs/tomcat-8.5-doc
   svn up --set-depth infinity docs/tomcat-9.0-doc

2. Create build.properties file if you have not done so yet and set
   "base.path" property in it. E.g.

      base.path=..

   The documentation bundles will be downloaded and untarred into
   "${base.path}/tomcat-site-docs/"

3. Set the version numbers in build.properties.default

4. Go into your tomcat-site directory and execute one of "release-x"
   targets in build.xml that corresponds to the version of Tomcat which
   documentation you are updating.

   The commands are:

   cd tomcat-site
   ant release-7
   ant release-8
   ant release-85
   ant release-9

5. Check the changes with "svn status" command.

   You will see
    a) Modified files ('M')
    b) New files ('?')
    c) Deleted/missing files ('!')

   Apply "svn add" to the new files.

   Apply "svn delete" to the missing files.

6. Commit the changes. 

7. Check that all changes were committed: execute "svn status" command.
   The expected result is that its output is empty. If it is not empty,
   repeat steps 5 & 6.

8. Committed changes are reflected on the live site automatically.
   Go to http://tomcat.apache.org/ and have fun.


To update the documentation for Tomcat Native or Tomcat Connectors:
====================================================================

If you are using "sparse" checkout, make sure that subdirectories for the
relevant Tomcat components are fully present in your working copy.

   The commands are:

   cd tomcat-site
   svn up --set-depth infinity docs/connectors-doc
   svn up --set-depth infinity docs/native-doc
   svn up --set-depth infinity docs/native-1.1-doc

One way to update documentation is to:

 - Build it in those projects, e.g. as a part of release process,
   and to replace docs/native-doc or docs/connectors-doc with the docs
   that you have built.

Another way is to call the bring the sources into this project and build
them here.

For the latter:

1. One of two variants:

A)

   Use "svn switch" command to switch jk-xdocs, native-xdocs or native-1.1-xdocs
   directories to xdocs directory of trunk or tag in those projects.

   The command looks like the following:

   To switch to current development versions:

      svn switch "^/tomcat/jk/trunk/xdocs" jk-xdocs
      svn switch "^/tomcat/native/trunk/xdocs" native-xdocs
      svn switch --ignore-ancestry "^/tomcat/native/branches/1.1.x/xdocs" native-1.1-xdocs

   To switch to tags for released versions:

      svn switch "^/tomcat/jk/tags/JK_1_2_xx/xdocs" jk-xdocs
      svn switch "^/tomcat/native/tags/TOMCAT_NATIVE_1_2_xx/xdocs" native-xdocs
      svn switch "^/tomcat/native/tags/TOMCAT_NATIVE_1_1_xx/xdocs" native-1.1-xdocs

   To switch back to empty directories:

      svn switch "^/tomcat/site/trunk/jk-xdocs" jk-xdocs
      svn switch "^/tomcat/site/trunk/native-xdocs" native-xdocs
      svn switch "^/tomcat/site/trunk/native-1.1-xdocs" native-1.1-xdocs


   To check to what URLs switched directories are mapped:

      svn info jk-xdocs
      svn info native-xdocs
      svn info native-1.1-xdocs

B)

   Or just copy the contents of "xdocs" directory from source
   distributive of released version into empty jk-xdocs or native-xdocs
   directories.

2. cd into your tomcat-site directory and execute one of the following
commands:

   ant release-jk
   ant release-native
   ant release-native-1.1

3. Check the changes with "svn status" command.

 - Remember that there may be deleted / missing files or new files.

4. Commit the changes.

5. Committed changes are reflected on the live site automatically.
   Go to http://tomcat.apache.org/ and have fun.
