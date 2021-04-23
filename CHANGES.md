This file describes changes in the GAP package 'TwistedConjugacy'.


1.1.0 (23/04/2021)
------------------

- CoincidenceGroup works more efficiently for finite groups
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

- Changed how the manual is generated. The manual can be recreated by running
  the "makedoc.g" script in the main package directory
- Renamed "gap" subfolder to "lib"
- Now requires the AutoDoc package, which is needed to recreate the manual
- Lowered requirements to GAP version >= 4.9 and Polycylic version >= 2.13.1,
  however, Polycyclic 2.16 is still heavily recommended


1.0.1 (07/06/2020)
------------------

- Improvements to PrintObj for ReidemeisterClasses
- Test Suite now has full coverage
- Some functions in HelpFunctions.gi now have local scope
- Updated documentation to include examples


1.0.0 (19/02/2020)
------------------

- Initial release
