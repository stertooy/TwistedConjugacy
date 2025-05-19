gap> START_TEST( "Testing TwistedConjugacy for PermGroups: Reidemeister spectra" );

# Preparation
gap> filt := IsPermGroup;;

#
gap> T := TrivialGroup( filt );;
gap> ReidemeisterSpectrum( T );
[ 1 ]
gap> ExtendedReidemeisterSpectrum( T );
[ 1 ]
gap> CoincidenceReidemeisterSpectrum( T );
[ 1 ]
gap> TotalReidemeisterSpectrum( T );
[ 1 ]

#
gap> C2 := CyclicGroup( filt, 2 );;
gap> ReidemeisterSpectrum( C2 );
[ 2 ]
gap> ExtendedReidemeisterSpectrum( C2 );
[ 1, 2 ]
gap> CoincidenceReidemeisterSpectrum( C2 );
[ 1, 2 ]
gap> TotalReidemeisterSpectrum( C2 );
[ 1, 2 ]

#
gap> C3 := CyclicGroup( filt, 3 );;
gap> ReidemeisterSpectrum( C3 );
[ 1, 3 ]
gap> ExtendedReidemeisterSpectrum( C3 );
[ 1, 3 ]
gap> CoincidenceReidemeisterSpectrum( C3 );
[ 1, 3 ]
gap> TotalReidemeisterSpectrum( C3 );
[ 1, 3 ]

#
gap> C4 := CyclicGroup( filt, 4 );;
gap> ReidemeisterSpectrum( C4 );
[ 2, 4 ]
gap> ExtendedReidemeisterSpectrum( C4 );
[ 1, 2, 4 ]
gap> CoincidenceReidemeisterSpectrum( C4 );
[ 1, 2, 4 ]
gap> TotalReidemeisterSpectrum( C4 );
[ 1, 2, 4 ]

#
gap> C2xC2 := AbelianGroup( filt, [ 2, 2 ] );;
gap> ReidemeisterSpectrum( C2xC2 );
[ 1, 2, 4 ]
gap> ExtendedReidemeisterSpectrum( C2xC2 );
[ 1, 2, 4 ]
gap> CoincidenceReidemeisterSpectrum( C2xC2 );
[ 1, 2, 4 ]
gap> TotalReidemeisterSpectrum( C2xC2 );
[ 1, 2, 4 ]

#
gap> C6 := CyclicGroup( filt, 6 );;
gap> ReidemeisterSpectrum( C6 );
[ 2, 6 ]
gap> ExtendedReidemeisterSpectrum( C6 );
[ 1, 2, 3, 6 ]
gap> CoincidenceReidemeisterSpectrum( C6 );
[ 1, 2, 3, 6 ]
gap> TotalReidemeisterSpectrum( C6 );
[ 1, 2, 3, 6 ]

#
gap> D6 := DihedralGroup( filt, 6 );;
gap> ReidemeisterSpectrum( D6 );
[ 3 ]
gap> ExtendedReidemeisterSpectrum( D6 );
[ 1, 2, 3 ]
gap> CoincidenceReidemeisterSpectrum( D6 );
[ 1, 2, 3, 4, 6 ]
gap> TotalReidemeisterSpectrum( D6 );
[ 1, 2, 3, 4, 6 ]

#
gap> C8 := CyclicGroup( filt, 8 );;
gap> ReidemeisterSpectrum( C8 );
[ 2, 4, 8 ]
gap> ExtendedReidemeisterSpectrum( C8 );
[ 1, 2, 4, 8 ]
gap> CoincidenceReidemeisterSpectrum( C8 );
[ 1, 2, 4, 8 ]
gap> TotalReidemeisterSpectrum( C8 );
[ 1, 2, 4, 8 ]

#
gap> C4xC2 := AbelianGroup( filt, [ 4, 2 ] );;
gap> ReidemeisterSpectrum( C4xC2 );
[ 2, 4, 8 ]
gap> ExtendedReidemeisterSpectrum( C4xC2 );
[ 1, 2, 4, 8 ]
gap> CoincidenceReidemeisterSpectrum( C4xC2 );
[ 1, 2, 4, 8 ]
gap> TotalReidemeisterSpectrum( C4xC2 );
[ 1, 2, 4, 8 ]

#
gap> C2xC2xC2 := AbelianGroup( filt, [ 2, 2, 2 ] );;
gap> ReidemeisterSpectrum( C2xC2xC2 );
[ 1, 2, 4, 8 ]
gap> ExtendedReidemeisterSpectrum( C2xC2xC2 );
[ 1, 2, 4, 8 ]
gap> CoincidenceReidemeisterSpectrum( C2xC2xC2 );
[ 1, 2, 4, 8 ]
gap> TotalReidemeisterSpectrum( C2xC2xC2 );
[ 1, 2, 4, 8 ]

#
gap> D8 := DihedralGroup( filt, 8 );;
gap> ReidemeisterSpectrum( D8 );
[ 3, 5 ]
gap> ExtendedReidemeisterSpectrum( D8 );
[ 1, 2, 3, 5 ]
gap> CoincidenceReidemeisterSpectrum( D8 );
[ 1, 2, 3, 4, 5, 6, 8 ]
gap> TotalReidemeisterSpectrum( D8 );
[ 1, 2, 3, 4, 5, 6, 8 ]

#
gap> Q8 := QuaternionGroup( filt, 8 );;
gap> ReidemeisterSpectrum( Q8 );
[ 2, 3, 5 ]
gap> ExtendedReidemeisterSpectrum( Q8 );
[ 1, 2, 3, 5 ]
gap> CoincidenceReidemeisterSpectrum( Q8 );
[ 1, 2, 3, 4, 5, 8 ]
gap> TotalReidemeisterSpectrum( Q8 );
[ 1, 2, 3, 4, 5, 6, 8 ]

#
gap> C2xC2xC4 := AbelianGroup( filt, [ 2, 2, 4 ] );;
gap> ReidemeisterSpectrum( C2xC2xC4 );
[ 2, 4, 8, 16 ]
gap> ExtendedReidemeisterSpectrum( C2xC2xC4 );
[ 1, 2, 4, 8, 16 ]
gap> CoincidenceReidemeisterSpectrum( C2xC2xC4 );
[ 1, 2, 4, 8, 16 ]
gap> TotalReidemeisterSpectrum( C2xC2xC4 );
[ 1, 2, 4, 8, 16 ]

#
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

#
gap> G1 := Group( [ (4,6), (3,4)(5,6), (1,2) ] );;
gap> ReidemeisterSpectrum( G1 );
[ 2, 4, 6, 8, 10 ]
gap> ExtendedReidemeisterSpectrum( G1 );
[ 1, 2, 3, 4, 5, 6, 8, 10 ]

#
gap> G2 := Group( [ (6,8), (5,8,7,6), (3,4)(6,8), (1,2)(6,8) ] );;
gap> ReidemeisterSpectrum( G2 );
[ 2, 3, 4, 5, 6, 8, 10, 12, 16, 20 ]

#
gap> G3 := Group( [ (1,3)(2,6)(4,7)(5,8), (1,6,3)(4,8,7), (1,7,4,3)(2,8,5,6) ] );;
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
