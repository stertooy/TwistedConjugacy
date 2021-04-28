This file describes changes in the GAP package 'TwistedConjugacy'.


2.0.0 (29/04/2021)
------------------

- Lowered requirements to GAP version >= 4.9 and GAPDoc version >= 1.6.1
- Polycyclic is now a suggested package instead of required. Version >= 2.13.1
  is required, although version >= 2.16 is recommended
- AutoDoc is now a suggested package, version >= 2018.02.14 is required
- Changed how the manual is generated. The manual can be recreated using
  AutoDoc by running the "makedoc.g" script in the main package directory.
- Renamed "gap" subfolder to "lib"
- Improved available tests
  
- CoincidenceGroup is much more efficient for homomorphisms between finite
  groups
- CoincidenceGroup can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is 
  nilpotent-by-finite or if the homomorphisms are endomorphisms with finite
  Reidemeister number

- InducedEndomorphism and RestrictedEndomorphism replaced by the more general
  InducedHomomorphism and RestrictedHomomorphism respectively
  
- IsTwistedConjugate can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is 
  nilpotent-by-finite or if the homomorphisms are endomorphisms with finite
  Reidemeister number

- ReidemeisterClasses can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is 
  nilpotent-by-finite or if the homomorphisms are endomorphisms
- Applying "Size" to an infinite Reidemeister class will now return "infinity"
  instead of running indefinitely, if the range is nilpotent-by-finite
 
- Improved calculation of Reidemeister numbers for (finite) abelian groups

- Improved calculation of Reidemeister spectra for finite abelian groups
- Added CoincidenceReidemeisterSpectrum
- Significant improvements in calculation time for 
  ExtendedReidemeisterSpectrum

- Reidemeister Zeta functions expanded to Coincidence Reidemeister Zeta
  functions
- Changed the output of ReidemeisterZetaCoefficients to accomodate for the
  above change
- Added IsRationalReidemeisterZeta function to quickly confirm rationality
  without actually calculating the zeta function
- ReidemeisterZeta now returns either a rational function or "fail"

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
