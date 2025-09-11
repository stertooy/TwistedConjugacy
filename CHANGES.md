This file describes changes in the GAP package TwistedConjugacy.


3.1.0 (2025-09-14)
------------------

- Now requires Polycyclic version >= 2.17

- Functionality for affine actions added
- Assertion variable renamed to `TWC_ASSERT`

- Ensured that this package does not break the Polycyclic test suite
- Package tests no longer require the SmallGrp and TransGrp packages

- Large changes to file structure



3.0.0 (2025-07-21)
------------------

- Now requires GAP version >= 4.14

- Switched the order of the homomorphisms in the definition of the twisted
  conjugation action, which is very likely to break scripts relying on older
  versions of this package
  
- Added method for (Representatives)ReidemeisterClasses and ReidemeisterNumber
  with no restrictions on the homomorphisms or the source and target groups
- (Representatives)ReidemeisterClasses now accepts a normal subgroup as
  optional input, and will then only return the (representatives of the)
  Reidemeister classes that intersect this normal subgroup

- RepresentativeTwistedConjugation and IsTwistedConjugate again accept lists as
  input, replacing the need for the separate functions
  RepresentativeTwistedConjugationMultiple and IsTwistedConjugateMultiple

- Added more methods related to double cosets (of PcpGroups)

- Added methods related to group derivations between finite groups and between
  PcpGroups

- Improved the efficiency of CoincidenceGroup in certain cases
- Improved the efficiency of CoincidenceReidemeisterSpectrum for non-abelian
  groups
  
- Overhauled the documentation
- Many smaller changes



2.4.0 (2024-12-05)
------------------

- Added methods for intersections of arbitrary subgroups and cosets in
  PcpGroups
- Added method to test membership in a double coset of a PcpGroup

- Algorithms for infinite polycyclic groups again require the Polycyclic
  package, since many methods would otherwise run forever due to the lack of
  finiteness checks in existing methods

- Renamed FullReidemeisterSpectrum to TotalReidemeisterSpectrum, to avoid
  confusion with a spectrum being 'full'
  
- Replaced ToggleSafeMode@TwistedConjugacy by variable ASSERT@TwistedConjugacy



2.3.0 (2024-09-17)
------------------

- Now requires GAP version >= 4.13
- Polycyclic version >= 2.16 is now an extension instead of a suggested package

- Added FullReidemeisterSpectrum
- Documented RepresentativesReidemeisterClasses

- Added ToggleSafeMode@TwistedConjugacy, to use built-in assertions (including
  those in Polycyclic) to check for any errors.



2.2.0 (2024-02-13)
------------------

- Now requires GAP version >= 4.12 and optionally Polycyclic version >= 2.16

- ReidemeisterSpectrum is now much more efficient for (large) non-abelian
  groups

- RepresentativeTwistedConjugation and IsTwistedConjugate no longer take lists
  as input, this functionality has been moved to new functions called
  RepresentativeTwistedConjugationMultiple and IsTwistedConjugateMultiple

- Added IsNilpotentByFinite and IsPolycyclicByFinite properties
- Code for infinite groups is now less dependent on the Polycyclic package
  being loaded



2.1.0 (2023-03-16)
------------------

- Now requires GAP version >= 4.11 and optionally polycyclic version >= 2.15.1

- Many efficiency improvements, both speed- and memory-related. In particular
  calculating Reidemeister spectra of finite groups should be much faster

- Added RepresentativeAutomorphismClasses, RepresentativesEndomorphismClasses
  and RepresentativesHomomorphismClasses, which can be applied to finite
  groups. They give output similar to GAP's built-in AllHomomorphismClasses
  function, but should be faster for abelian and non-2-generated groups

- Fixed a bug that made ReidemeisterSpectrum not work for the trivial group

- CoincidenceGroup, RepresentativeTwistedConjugation and IsTwistedConjugate
  now work for any pair of endomorphisms between any two polycyclic groups
- FixedPointGroup now works for any endomorphism of any polycyclic group

- CoincidenceGroup can now take 3 or more endomorphisms as argument
- RepresentativeTwistedConjugation and IsTwistedConjugate can now take lists
  as input, and will try to solve the multiple twisted conjugacy problem



2.0.0 (2021-05-01)
------------------

- Lowered requirements to GAP version >= 4.9 and GAPDoc version >= 1.6.1
- Polycyclic is now a suggested package instead of required. Version >= 2.13.1
  is required, although version >= 2.16 is recommended
- AutoDoc is now a suggested package, version >= 2018.02.14 is required

- The documentation has been largely rewritten.

- Changed how the manual is generated. The manual can be recreated using
  AutoDoc by running the "makedoc.g" script in the main package directory
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
- Changed the output of ReidemeisterZetaCoefficients to accommodate for the
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



1.0.1 (2020-06-07)
------------------

- Improvements to PrintObj for ReidemeisterClasses
- Test Suite now has full coverage
- Some functions in HelpFunctions.gi now have local scope
- Updated documentation to include examples



1.0.0 (2020-02-19)
------------------

- Initial release
