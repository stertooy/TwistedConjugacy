This file describes changes in the GAP package 'TwistedConjugacy'.

1.1.0 (05/08/2020)
------------------

- Improved calculation of Reidemeister number for (finite) abelian groups
- CoincidenceGroup now works for homomorphisms with nilpotent range
- IsTwistedConjugate can now always be applied to (non-endomorphic)
  homomorphisms. A result is guaranteed if the range is nilpotent-by-finite,
  or if the homomorphisms are endomorphisms with finite Reidemeister number
- ReidemeisterClasses can now always be applied to (non-endomorphic)
  homomorphisms. A result is guaranteed if the range is nilpotent-by-finite,
  or if the homomorphisms are endomorphisms
- InducedEndomorphism and RestrictedEndomorphism replaced by
  InducedHomomorphism and RestrictedHomomorphism respectively
- Manual, in pdf format, is included under /doc. The manual can be recreated
  by running the "makedoc.g" script
- Now requires GAP 4.11 and polycyclic 2.16, to prevent wrong results due
  to bugs in the polycyclic package


1.0.1 (07/06/2020)
------------------

- Improvements to PrintObj for ReidemeisterClasses
- Test Suite now has full coverage
- Some functions in HelpFunctions.gi now have local scope
- Updated documentation to include examples


1.0.0 (19/02/2020)
------------------

- Initial release
