gap> START_TEST( "Testing TwistedConjugacy for PermGroups: Reidemeister spectra of non-polycyclic groups" );

# Preparation
gap> filt := IsPermGroup;;
gap> G := SL( filt, 2, 5 );;
gap> A := AlternatingGroup( filt, 5 );;
gap> S := SymmetricGroup( filt, 5 );;

#
gap> ReidemeisterSpectrum( G );
[ 5, 9 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 5, 9 ]
gap> CoincidenceReidemeisterSpectrum( G );
[ 1, 5, 9, 120 ]
gap> TSpec := TotalReidemeisterSpectrum( G );;
gap> Length( TSpec ) = 28 and TSpec{[1..10]} = [1..10];
true

#
gap> ReidemeisterSpectrum( A );
[ 3, 5 ]
gap> ExtendedReidemeisterSpectrum( A );
[ 1, 3, 5 ]
gap> CoincidenceReidemeisterSpectrum( A );
[ 1, 3, 5, 60 ]

#
gap> ReidemeisterSpectrum( S );
[ 7 ]
gap> ExtendedReidemeisterSpectrum( S );
[ 1, 2, 7 ]
gap> CoincidenceReidemeisterSpectrum( S );
[ 1, 2, 7, 60, 64, 66, 120 ]

#
gap> CoincidenceReidemeisterSpectrum( A, S );
[ 2, 8, 120 ]
gap> CoincidenceReidemeisterSpectrum( S, A );
[ 30, 32, 60 ]

#
gap> STOP_TEST( "spectra_non_pc.tst" );
