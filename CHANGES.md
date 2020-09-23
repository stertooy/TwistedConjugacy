This file describes changes in the GAP package 'TwistedConjugacy'.

1.1.0 (23/09/2020)
------------------

- Improved calculation of Reidemeister number for (finite) abelian groups
- CoincidenceGroup now works for homomorphisms with nilpotent-by-finite range
- IsTwistedConjugate can now always be applied to (non-endomorphic)
  homomorphisms. A result is guaranteed if the range is nilpotent-by-finite,
  or if the homomorphisms are endomorphisms with finite Reidemeister number
- ReidemeisterClasses can now always be applied to (non-endomorphic)
  homomorphisms. A result is guaranteed if the range is nilpotent-by-finite,
  or if the homomorphisms are endomorphisms
- InducedEndomorphism and RestrictedEndomorphism replaced by
  InducedHomomorphism and RestrictedHomomorphism respectively
- Some changes to how the manual is generated. The manual can be recreated
  by running the "makedoc.g" script in the main package directory
- Now requires GAP 4.11 and polycyclic 2.16, to prevent wrong results due
  to bugs in the polycyclic package
- Now requires AutoDoc package, to ensure users can compile the documentation
- Applying "Size" to an infinite Reidemeister class will now return infinite
  instead of running indefinitely, if the range is nilpotent-by-finite.


1.0.1 (07/06/2020)
------------------

- Improvements to PrintObj for ReidemeisterClasses
- Test Suite now has full coverage
- Some functions in HelpFunctions.gi now have local scope
- Updated documentation to include examples


1.0.0 (19/02/2020)
------------------

- Initial release
