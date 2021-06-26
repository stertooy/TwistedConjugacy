This file describes changes in the GAP package TwistedConjugacy.


2.1.0 (06/06/2021)
------------------

- Various improvements to efficiency, both speed- and memory-related.

- Fixed a bug that made ReidemeisterSpectrum not work for the trivial group.

- FixedPointGroup now works for any automorphism of an infinite PCP-group
- CoincidenceGroup now works for any pair of isomorphisms between infinite
  PCP-groups
- RepresentativeTwistedConjugation and IsTwistedConjugate now work for
  pairs of isomorphisms between infinite PCP-groups

- CoincidenceGroup can now take 3 or more endomorphisms as argument
- RepresentativeTwistedConjugation and IsTwistedConjugate can now take lists
  as input, and will try to solve the multiple twisted conjugacy problem


2.0.0 (01/05/2021)
------------------

- Lowered requirements to GAP version >= 4.9 and GAPDoc version >= 1.6.1
- Polycyclic is now a suggested package instead of required. Version >= 2.13.1
  is required, although version >= 2.16 is recommended
- AutoDoc is now a suggested package, version >= 2018.02.14 is required

- The documentation has been largely rewritten.

- Changed how the manual is generated. The manual can be recreated using
  AutoDoc by running the "makedoc.g" script in the main package directory.
- Renamed "gap" subfolder to "lib"
- Improved available tests


- IsTwistedConjugate can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is
  nilpotent-by-finite or if the homomorphisms are endomorphisms with finite
  Reidemeister number

- ReidemeisterClasses can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is
  nilpotent-by-finite or if the homomorphisms are endomorphisms
- Applying "Size" to an infinite Reidemeister class will now return "infinity"
  instead of running indefinitely, if the range is nilpotent-by-finite
- Implemented "StabiliserOfExternalSet" for Reidemeister classes

- Improved calculation of Reidemeister numbers for (finite) abelian groups

- Improved calculation of Reidemeister spectra for finite abelian groups
- Added CoincidenceReidemeisterSpectrum
- Significant improvements in calculation time for
  ExtendedReidemeisterSpectrum

- Reidemeister Zeta functions expanded to pairs of endomorphisms of finite
  groups, instead of a single endomorphism
- Changed the output of ReidemeisterZetaCoefficients to accomodate for the
  above change
- Added IsRationalReidemeisterZeta
- ReidemeisterZeta now returns either a rational function or "fail"

- CoincidenceGroup is much more efficient for homomorphisms between finite
  groups
- CoincidenceGroup can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is
  nilpotent-by-finite or if the homomorphisms are endomorphisms with finite
  Reidemeister number

- InducedEndomorphism and RestrictedEndomorphism replaced by the more general
  InducedHomomorphism and RestrictedHomomorphism respectively

- Finite PcpGroups will now automatically be converted to PcGroups


1.0.1 (07/06/2020)
------------------

- Improvements to PrintObj for ReidemeisterClasses
- Test Suite now has full coverage
- Some functions in HelpFunctions.gi now have local scope
- Updated documentation to include examples


1.0.0 (19/02/2020)
------------------

- Initial release
