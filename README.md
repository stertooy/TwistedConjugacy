[![Build Status](https://github.com/sTertooy/TwistedConjugacy/actions/workflows/CI.yml/badge.svg)](https://github.com/stertooy/TwistedConjugacy/actions/workflows/CI.yml?query=branch%3Amain)
[![Code Coverage](https://codecov.io/gh/sTertooy/TwistedConjugacy/branch/main/graph/badge.svg)](https://codecov.io/gh/sTertooy/TwistedConjugacy)
[![License](https://img.shields.io/badge/license-GPLv2%2B-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![Manual](https://img.shields.io/badge/docs-html-blue)](https://stertooy.github.io/TwistedConjugacy/doc/chap0_mj.html)
[![Release](https://img.shields.io/github/release/stertooy/twistedconjugacy.svg)](https://github.com/stertooy/twistedconjugacy/releases)

The GAP 4 package TwistedConjugacy
==================================

by Sam Tertooy <sam.tertooy@kuleuven.be>



About
-----

The TwistedConjugacy package provides methods to solve the twisted conjugacy
(search) problem, calculate Reidemeister classes, numbers, spectra and zeta
functions, as well as construct coincidence groups of group homomorphisms.

These methods are, for the most part, designed to be used on (group
homomorphisms between) finite and polycyclic groups, the latter requiring
the use of the Polycyclic package.

Moreover, if Polycyclic is loaded, this package also allows calculating
intersections of arbitrary subgroups and cosets, as well as solving the
membership problem for double cosets in polycyclic groups.


This package requires GAP version 4.13 or later. The extension for 
polycyclically presented groups requires Polycyclic version 2.16 or later.



Installation
------------

Either place the folder in the pkg subdirectory of your gap folder, or in any
other folder where you have write permission. You can verify if GAP recognizes
the TwistedConjugacy package using the following command:

    gap> LoadPackage("TwistedConjugacy");
	─────────────────────────────────────────────────────────────────────────────
	Loading  TwistedConjugacy 2.4.0 (Computation with twisted conjugacy classes)
	by Sam Tertooy (https://stertooy.github.io/).
	Homepage: https://stertooy.github.io/TwistedConjugacy/
	Report issues at https://github.com/stertooy/TwistedConjugacy/issues
	─────────────────────────────────────────────────────────────────────────────
	true

The manual may be compiled by running the 'makedoc.g' script, located in the
package's main directory. This requires the AutoDoc package. The manual is
also available on the webpages of this package, at
<https://stertooy.github.io/TwistedConjugacy/doc/chap0_mj.html>



Support
-------

Please report any problems you may encounter using TwistedConjugacy at
<https://github.com/stertooy/TwistedConjugacy>



License
-------

The TwistedConjugacy package is licensed under the GNU General Public License
v2.0 or later. A copy of this license is included.
