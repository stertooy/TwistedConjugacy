gap> START_TEST( "Testing TwistedConjugacy for PermGroups: Reidemeister spectra" );

# Preparation
gap> filt := IsPermGroup;;

# For given group, calculate spectra of group, subgroups and quotients
# Reidemeister spectrum only, endomorphisms take too long
gap> G := Group( [ (11,16)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,2,4)(3,5,7)(6,8,9), (1,3,6)(2,5,8)(4,7,9), (10,11,12,13,14,15,16) ] );;
gap> ReidemeisterSpectrum( G );
[ 4, 6, 8, 10, 12, 15, 20, 30 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 2, 3, 4, 5, 6, 8, 10, 12, 15, 20, 30 ]

# All spectra
gap> H := Subgroup( G, [ G.1, G.2, G.3 ] );;
gap> ReidemeisterSpectrum( H );
[ 4, 6 ]
gap> ExtendedReidemeisterSpectrum( H );
[ 1, 2, 3, 4, 6 ]
gap> CoincidenceReidemeisterSpectrum( H );
[ 1, 2, 3, 4, 6, 8, 12 ]
gap> TotalReidemeisterSpectrum( H );
[ 1, 2, 3, 4, 6, 8, 12 ]

# All spectra
gap> Q := FactorGroup( G, Subgroup( G, [ G.3, G.4 ] ) );;
gap> ReidemeisterSpectrum( Q );
[ 2, 4, 8, 10 ]
gap> ExtendedReidemeisterSpectrum( Q );
[ 1, 2, 4, 5, 8, 10 ]
gap> CoincidenceReidemeisterSpectrum( Q );
[ 1, 2, 4, 5, 7, 8, 10, 14, 16, 28 ]
gap> TotalReidemeisterSpectrum( Q );
[ 1, 2, 4, 5, 7, 8, 10, 14, 16, 28 ]

# All spectra
gap> D := DerivedSubgroup( G );;
gap> ReidemeisterSpectrum( D );
[ 1, 3, 7, 9, 21, 63 ]
gap> ExtendedReidemeisterSpectrum( D );
[ 1, 3, 7, 9, 21, 63 ]
gap> CoincidenceReidemeisterSpectrum( D );
[ 1, 3, 7, 9, 21, 63 ]
gap> TotalReidemeisterSpectrum( D );
[ 1, 3, 7, 9, 21, 63 ]

# Coincidence spectra between different groups
gap> CoincidenceReidemeisterSpectrum( H, Q );
[ 7, 8, 14, 16, 28 ]
gap> CoincidenceReidemeisterSpectrum( Q, H );
[ 3, 4, 6, 8, 12 ]
gap> CoincidenceReidemeisterSpectrum( H, D );
[ 63 ]
gap> CoincidenceReidemeisterSpectrum( D, H );
[ 4, 8, 12 ]
gap> CoincidenceReidemeisterSpectrum( Q, D );
[ 63 ]
gap> CoincidenceReidemeisterSpectrum( D, Q );
[ 4, 16, 28 ]

# Try some small groups
# All spectra
gap> T := TrivialGroup( filt );;
gap> ReidemeisterSpectrum( T );
[ 1 ]
gap> ExtendedReidemeisterSpectrum( T );
[ 1 ]
gap> CoincidenceReidemeisterSpectrum( T );
[ 1 ]
gap> TotalReidemeisterSpectrum( T );
[ 1 ]

# All spectra
gap> C3 := CyclicGroup( filt, 3 );;
gap> ReidemeisterSpectrum( C3 );
[ 1, 3 ]
gap> ExtendedReidemeisterSpectrum( C3 );
[ 1, 3 ]
gap> CoincidenceReidemeisterSpectrum( C3 );
[ 1, 3 ]
gap> TotalReidemeisterSpectrum( C3 );
[ 1, 3 ]

# All spectra
gap> C4 := CyclicGroup( filt, 4 );;
gap> ReidemeisterSpectrum( C4 );
[ 2, 4 ]
gap> ExtendedReidemeisterSpectrum( C4 );
[ 1, 2, 4 ]
gap> CoincidenceReidemeisterSpectrum( C4 );
[ 1, 2, 4 ]
gap> TotalReidemeisterSpectrum( C4 );
[ 1, 2, 4 ]

# All spectra
gap> D6 := DihedralGroup( filt, 6 );;
gap> ReidemeisterSpectrum( D6 );
[ 3 ]
gap> ExtendedReidemeisterSpectrum( D6 );
[ 1, 2, 3 ]
gap> CoincidenceReidemeisterSpectrum( D6 );
[ 1, 2, 3, 4, 6 ]
gap> TotalReidemeisterSpectrum( D6 );
[ 1, 2, 3, 4, 6 ]

# All spectra
gap> Q8 := QuaternionGroup( filt, 8 );;
gap> ReidemeisterSpectrum( Q8 );
[ 2, 3, 5 ]
gap> ExtendedReidemeisterSpectrum( Q8 );
[ 1, 2, 3, 5 ]
gap> CoincidenceReidemeisterSpectrum( Q8 );
[ 1, 2, 3, 4, 5, 8 ]
gap> TotalReidemeisterSpectrum( Q8 );
[ 1, 2, 3, 4, 5, 6, 8 ]

# All spectra
gap> C2xC2xC2 := AbelianGroup( filt, [ 2, 2, 2 ] );;
gap> ReidemeisterSpectrum( C2xC2xC2 );
[ 1, 2, 4, 8 ]
gap> ExtendedReidemeisterSpectrum( C2xC2xC2 );
[ 1, 2, 4, 8 ]
gap> CoincidenceReidemeisterSpectrum( C2xC2xC2 );
[ 1, 2, 4, 8 ]
gap> TotalReidemeisterSpectrum( C2xC2xC2 );
[ 1, 2, 4, 8 ]

# All spectra
gap> C2xC2xC4 := AbelianGroup( filt, [ 2, 2, 4 ] );;
gap> ReidemeisterSpectrum( C2xC2xC4 );
[ 2, 4, 8, 16 ]
gap> ExtendedReidemeisterSpectrum( C2xC2xC4 );
[ 1, 2, 4, 8, 16 ]
gap> CoincidenceReidemeisterSpectrum( C2xC2xC4 );
[ 1, 2, 4, 8, 16 ]
gap> TotalReidemeisterSpectrum( C2xC2xC4 );
[ 1, 2, 4, 8, 16 ]

# Coincidence spectra between different groups
gap> CoincidenceReidemeisterSpectrum( C4, Q8 );
[ 2, 4, 6, 8 ]
gap> CoincidenceReidemeisterSpectrum( Q8, C4 );
[ 2, 4 ]
gap> CoincidenceReidemeisterSpectrum( C2xC2xC2, Q8 );
[ 4, 8 ]
gap> CoincidenceReidemeisterSpectrum( Q8, C2xC2xC2 );
[ 2, 4, 8 ]
gap> CoincidenceReidemeisterSpectrum( C2xC2xC4, Q8 );
[ 2, 4, 6, 8 ]
gap> CoincidenceReidemeisterSpectrum( Q8, C2xC2xC4 );
[ 4, 8, 16 ]

# Some more groups
#
gap> G1 := Group( [ (1,2,6,10)(3,14,12,15)(4,8,11,7)(5,16,13,9), (1,3)(2,7)(4,5)(6,12)(8,10)(9,15)(11,13)(14,16), (1,4)(2,8)(3,5)(6,11)(7,10)(9,15)(12,13)(14,16), (1,5,6,13)(2,9,10,16)(3,11,12,4)(7,14,8,15), (1,6)(2,10)(3,12)(4,11)(5,13)(7,8)(9,16)(14,15) ] );;
gap> ReidemeisterSpectrum( G1 );
[ 6, 8, 10, 14 ]
gap> ExtendedReidemeisterSpectrum( G1 );
[ 1, 2, 4, 5, 6, 7, 8, 10, 14 ]

#
gap> G2 := Group( [ (2,8)(4,11)(6,13)(9,15), (1,2,5,8)(3,13,10,6)(4,7,11,14)(9,16,15,12), (1,3,5,10)(2,6,8,13)(4,9,11,15)(7,12,14,16), (1,4)(2,7)(3,9)(5,11)(6,12)(8,14)(10,15)(13,16), (1,5)(2,8)(3,10)(4,11)(6,13)(7,14)(9,15)(12,16) ] );;
gap> ReidemeisterSpectrum( G2 );
[ 2, 3, 5, 9, 17 ]
gap> ExtendedReidemeisterSpectrum( G2 );
[ 1, 2, 3, 5, 9, 17 ]

#
gap> G3 := Group( [ (2,3,7)(4,5,8), (1,2)(3,7)(4,6)(5,8), (1,3)(2,7)(4,8)(5,6), (1,4)(2,6)(3,7)(5,8), (1,5)(2,7)(3,6)(4,8), (1,6)(2,4)(3,5)(7,8) ] );;
gap> ReidemeisterSpectrum( G3 );
[ 2, 5, 7, 8, 11 ]
gap> ExtendedReidemeisterSpectrum( G3 );
[ 1, 2, 3, 4, 5, 7, 8, 11 ]

#
gap> G4 := AbelianGroup( filt, [ 2, 3, 5, 6, 24, 30 ] );;
gap> ReidemeisterSpectrum( G4 ) = 2*DivisorsInt( 64800 );
true
gap> ExtendedReidemeisterSpectrum( G4 ) = DivisorsInt( 129600 );
true
gap> CoincidenceReidemeisterSpectrum( G4 ) = DivisorsInt( 129600 );
true
gap> TotalReidemeisterSpectrum( G4 ) = DivisorsInt( 129600 );
true

#
gap> G5 := AbelianGroup( filt, [ 2, 3, 5, 17, 24 ] );;
gap> ReidemeisterSpectrum( G5 ) = 4*DivisorsInt( 3060 );
true
gap> ExtendedReidemeisterSpectrum( G5 ) = DivisorsInt( 12240 );
true
gap> CoincidenceReidemeisterSpectrum( G5 ) = DivisorsInt( 12240 );
true
gap> TotalReidemeisterSpectrum( G5 ) = DivisorsInt( 12240 );
true

#
gap> G6 := AbelianGroup( filt, [ 512, 512 ] );;
gap> ReidemeisterSpectrum( G6 ) = DivisorsInt( 262144 );
true
gap> ExtendedReidemeisterSpectrum( G6 ) = DivisorsInt( 262144 );
true
gap> CoincidenceReidemeisterSpectrum( G6 ) = DivisorsInt( 262144 );
true
gap> TotalReidemeisterSpectrum( G6 ) = DivisorsInt( 262144 );
true

#
gap> G7 := AbelianGroup( filt, [ 2, 4, 4, 8, 16, 32, 64, 128, 128, 256, 512 ] );;
gap> ReidemeisterSpectrum( G7 ) = 16*DivisorsInt( 1125899906842624 );
true
gap> ExtendedReidemeisterSpectrum( G7 ) = DivisorsInt( 18014398509481984 );
true
gap> CoincidenceReidemeisterSpectrum( G7 ) = DivisorsInt( 18014398509481984 );
true
gap> TotalReidemeisterSpectrum( G7 ) = DivisorsInt( 18014398509481984 );
true

#
gap> STOP_TEST( "spectra.tst" );
