This file describes changes in the GAP package TwistedConjugacy.

## 3.3.0 (2026-04-09)

### Added
- Add a better implementation of `IsFinite` for twisted conjugacy classes,
  double cosets, orbits of affine actions and group derivation images.

### Changed
- `ReidemeisterNumber` now immediately returns `infinity` if the source group
  is finite but the range group is infinite.
- Overhauled manual creation.
- Changes to examples in the manual.
- Renamed `CHANGES.md` to `CHANGELOG.md`.
- Janitorial changes.

### Fixed
- Fixed bugs in `Intersection` for cosets of PcpGroups.

## 3.2.0 (2026-02-11)

### Added
- Added support for Reidemeister generating functions.

### Changed
- Renamed many of the existing functions available for Reidemeister zeta
  functions.
- Janitorial changes.

## 3.1.2 (2025-11-14)

### Changed
- Improve references in the documentation.

### Fixed
- Fix faulty URLs in the documentation.

## 3.1.1 (2025-10-12)

### Added
- Affine actions can now be compared using the equality (`=`) operator.

### Changed
- Assertion variable renamed (again) to `TWC.ASSERT`.
- Update license text to latest version.
- Update installation instructions in manual.
- More changes to file structure.
- Small improvements to the documentation of derivations and affine actions.
- Janitorial changes.

## 3.1.0 (2025-09-14)

### Added
- Functionality for affine actions added.

### Changed
- Now requires Polycyclic version >= 2.17.
- Assertion variable renamed to `TWC_ASSERT`.
- Package tests no longer require the SmallGrp and TransGrp packages.
- Large changes to file structure.

### Fixed
- Ensured that this package does not break the Polycyclic test suite.

## 3.0.0 (2025-07-21)

### Added
- Added method for `(Representatives)ReidemeisterClasses` and
  `ReidemeisterNumber` with no restrictions on the homomorphisms or the source
  and target groups.
- `(Representatives)ReidemeisterClasses` now accepts a normal subgroup as
  optional input, and will then only return the (representatives of the)
  Reidemeister classes that intersect this normal subgroup.
- `RepresentativeTwistedConjugation` and `IsTwistedConjugate` again accept
  lists as input, replacing the need for the separate functions
  `RepresentativeTwistedConjugationMultiple` and
  `IsTwistedConjugateMultiple`.
- Added more methods related to double cosets (of PcpGroups).
- Added methods related to group derivations between finite groups and between
  PcpGroups.

### Changed
- Now requires GAP version >= 4.14.
- Switched the order of the homomorphisms in the definition of the twisted
  conjugation action, which is very likely to break scripts relying on older
  versions of this package.
- Improved the efficiency of `CoincidenceGroup` in certain cases.
- Improved the efficiency of `CoincidenceReidemeisterSpectrum` for non-abelian
  groups.
- Overhauled the documentation.
- Many smaller changes.

## 2.4.0 (2024-12-05)

### Added
- Added methods for intersections of arbitrary subgroups and cosets in
  PcpGroups.
- Added method to test membership in a double coset of a PcpGroup.

### Changed
- Algorithms for infinite polycyclic groups again require the Polycyclic
  package, since many methods would otherwise run forever due to the lack of
  finiteness checks in existing methods.
- Renamed `FullReidemeisterSpectrum` to `TotalReidemeisterSpectrum`, to avoid
  confusion with a spectrum being 'full'.
- Replaced `ToggleSafeMode@TwistedConjugacy` by variable
  `ASSERT@TwistedConjugacy`.

## 2.3.0 (2024-09-17)

### Added
- Added `FullReidemeisterSpectrum`.
- Documented `RepresentativesReidemeisterClasses`.
- Added `ToggleSafeMode@TwistedConjugacy`, to use built-in assertions
  (including those in Polycyclic) to check for any errors.

### Changed
- Now requires GAP version >= 4.13.
- Polycyclic version >= 2.16 is now an extension instead of a suggested
  package.

## 2.2.0 (2024-02-13)

### Added
- Added `IsNilpotentByFinite` and `IsPolycyclicByFinite` properties.

### Changed
- Now requires GAP version >= 4.12 and optionally Polycyclic version >= 2.16.
- `ReidemeisterSpectrum` is now much more efficient for (large) non-abelian
  groups.
- `RepresentativeTwistedConjugation` and `IsTwistedConjugate` no longer take
  lists as input, this functionality has been moved to new functions called
  `RepresentativeTwistedConjugationMultiple` and `IsTwistedConjugateMultiple`.
- Code for infinite groups is now less dependent on the Polycyclic package
  being loaded.

## 2.1.0 (2023-03-16)

### Added
- Added `RepresentativeAutomorphismClasses`,
  `RepresentativesEndomorphismClasses` and
  `RepresentativesHomomorphismClasses`, which can be applied to finite groups.
  They give output similar to GAP's built-in `AllHomomorphismClasses` function,
  but should be faster for abelian and non-2-generated groups.
- `CoincidenceGroup` can now take 3 or more endomorphisms as argument.
- `RepresentativeTwistedConjugation` and `IsTwistedConjugate` can now take
  lists as input, and will try to solve the multiple twisted conjugacy problem.

### Changed
- Now requires GAP version >= 4.11 and optionally Polycyclic version >= 2.15.1.
- Many efficiency improvements, both speed- and memory-related. In particular
  calculating Reidemeister spectra of finite groups should be much faster.
- `CoincidenceGroup`, `RepresentativeTwistedConjugation` and
  `IsTwistedConjugate` now work for any pair of endomorphisms between any two
  polycyclic groups.
- `FixedPointGroup` now works for any endomorphism of any polycyclic group.

### Fixed
- Fixed a bug that made `ReidemeisterSpectrum` not work for the trivial group.

## 2.0.0 (2021-05-01)

### Added
- The documentation has been largely rewritten.
- Changed how the manual is generated. The manual can be recreated using
  AutoDoc by running the `makedoc.g` script in the main package directory.
- Improved available tests.
- Implemented `StabiliserOfExternalSet` for Reidemeister classes.
- Improved calculation of Reidemeister numbers for (finite) abelian groups.
- Improved calculation of Reidemeister spectra for finite abelian groups.
- Added `CoincidenceReidemeisterSpectrum`.
- Added `IsRationalReidemeisterZeta`.

### Changed
- Lowered requirements to GAP version >= 4.9 and GAPDoc version >= 1.6.1.
- Polycyclic is now a suggested package instead of required. Version >= 2.13.1
  is required, although version >= 2.16 is recommended.
- AutoDoc is now a suggested package, version >= 2018.02.14 is required.
- Renamed `gap` subfolder to `lib`.
- `IsTwistedConjugate` can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is
  nilpotent-by-finite or if the homomorphisms are endomorphisms with finite
  Reidemeister number.
- `ReidemeisterClasses` can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is
  nilpotent-by-finite or if the homomorphisms are endomorphisms.
- Applying `Size` to an infinite Reidemeister class will now return `infinity`
  instead of running indefinitely, if the range is nilpotent-by-finite.
- Reidemeister Zeta functions expanded to pairs of endomorphisms of finite
  groups, instead of a single endomorphism.
- Changed the output of `ReidemeisterZetaCoefficients` to accommodate for the
  above change.
- `CoincidenceGroup` is much more efficient for homomorphisms between finite
  groups.
- `CoincidenceGroup` can now always be applied to homomorphisms between
  distinct groups. A result is only guaranteed, however, if the range is
  nilpotent-by-finite or if the homomorphisms are endomorphisms with finite
  Reidemeister number.
- `InducedEndomorphism` and `RestrictedEndomorphism` replaced by the more
  general `InducedHomomorphism` and `RestrictedHomomorphism` respectively.
- Finite PcpGroups will now automatically be converted to PcGroups.

## 1.0.1 (2020-06-07)

### Added
- Updated documentation to include examples.
- Test suite now has full coverage.

### Changed
- Improvements to `PrintObj` for Reidemeister classes.
- Some functions in `HelpFunctions.gi` now have local scope.

## 1.0.0 (2020-02-19)

### Added
- Initial release.
