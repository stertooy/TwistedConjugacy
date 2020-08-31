[![Build Status](https://travis-ci.org/sTertooy/TwistedConjugacy.svg?branch=master)](https://travis-ci.org/sTertooy/TwistedConjugacy)
[![Code Coverage](https://codecov.io/github/sTertooy/TwistedConjugacy/coverage.svg?branch=master&token=)](https://codecov.io/gh/sTertooy/TwistedConjugacy)

The GAP 4 package `TwistedConjugacy'
====================================

by Sam Tertooy <sam.tertooy@hotmail.com>


Introduction
------------

This package is designed to be used for either finite groups or for
(infinite) polycyclically presented groups (pcp-groups).

This package requires GAP version 4.11 or later, with the following packages
(and their dependencies) installed:
- Polycyclic (version >= 2.16)
- GAPDoc (version >= 1.6.3)
- AutoDoc (version >= 2019.09.04)



Installation
------------

Either place the folder in the pkg subdirectory of your gap folder, or in 
any other folder where you have write permission. You can verify if GAP 
recognizes the TwistedConjugacy package using the following command:

    gap> LoadPackage("TwistedConjugacy");
	─────────────────────────────────────────────────────────────────────────────
	Loading  TwistedConjugacy 1.1.0 (Computation with twisted conjugacy classes)
	by Sam Tertooy (https://stertooy.github.io/).
	Homepage: https://sTertooy.github.io/TwistedConjugacy/
	Report issues at https://github.com/sTertooy/TwistedConjugacy/issues
	─────────────────────────────────────────────────────────────────────────────
	true

If you are using a custom directory, make a 'pkg' subdirectory and place
the TwistedConjugacy folder in this subdirectory. You will need to tell 
GAP to look for packages in this directory using the -l option:

	sh > gap -l ';mydirectory/';

The manual may be compiled by running the 'makedoc.g' script, located in
the package's main directory.  It is also available on the webpages of this
package, at <https://stertooy.github.io/TwistedConjugacy/doc/chap0.html>



Support
-------
 
Please report any problems you may encounter using `TwistedConjugacy' 
at <https://github.com/sTertooy/TwistedConjugacy>



License
-------

The `TwistedConjugacy' package is licensed under the GNU General
Public License v2.0 or later. A copy of this license is included.
