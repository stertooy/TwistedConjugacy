[![Build Status](https://github.com/sTertooy/TwistedConjugacy/workflows/CI/badge.svg?branch=master)](https://github.com/sTertooy/TwistedConjugacy/actions?query=workflow%3ACI+branch%3Amaster)
[![Code Coverage](https://codecov.io/gh/sTertooy/TwistedConjugacy/branch/master/graph/badge.svg)](https://codecov.io/gh/sTertooy/TwistedConjugacy)

The GAP 4 package TwistedConjugacy
====================================

by Sam Tertooy <sam.tertooy@kuleuven.be>



About
------------

The TwistedConjugacy package provides methods to calculate Reidemeister
classes, numbers, spectra and zeta functions, as well as coincidence groups
of group homomorphisms. These methods are, for the most part, designed to be
used with (group homomorphisms between) finite groups and, if the package
polycyclic is also installed, polycyclically presented groups.

This package requires GAP version 4.9 or later, with the following packages
(and their dependencies) installed:
- GAPDoc (version >= 1.6.1)

The following packages (and their dependencies) are optional, though are
recommended:
- Polycyclic (version >= 2.13.1)
- AutoDoc (version >= 2018.02.14)

Note that is recommended to install Polycyclic version >= 2.16, to avoid some
known bugs which could lead to wrong results. It is also recommended to install
the computer algebra system PARI/GP.



Installation
------------

Either place the folder in the pkg subdirectory of your gap folder, or in any
other folder where you have write permission. You can verify if GAP recognizes
the TwistedConjugacy package using the following command:

    gap> LoadPackage("TwistedConjugacy");
	─────────────────────────────────────────────────────────────────────────────
	Loading  TwistedConjugacy 2.1.0 (Computation with twisted conjugacy classes)
	by Sam Tertooy (https://stertooy.github.io/).
	Homepage: https://sTertooy.github.io/TwistedConjugacy/
	Report issues at https://github.com/sTertooy/TwistedConjugacy/issues
	─────────────────────────────────────────────────────────────────────────────
	true

The manual may be compiled by running the 'makedoc.g' script, located in the
package's main directory.  It is also available on the webpages of this
package, at <https://stertooy.github.io/TwistedConjugacy/doc/chap0.html>



Support
-------

Please report any problems you may encounter using TwistedConjugacy at
<https://github.com/sTertooy/TwistedConjugacy>



License
-------

The TwistedConjugacy package is licensed under the GNU General Public License
v2.0 or later. A copy of this license is included.
