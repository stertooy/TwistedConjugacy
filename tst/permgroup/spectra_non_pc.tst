gap> START_TEST( "Testing TwistedConjugacy for PermGroups: Reidemeister spectra of non-polycyclic groups" );

# Preparation
gap> filt := IsPermGroup;;
gap> G := Group( [ (3,4)(5,6), (1,2,3)(4,5,7) ] );;
gap> A := AlternatingGroup( filt, 6 );;
gap> S := SymmetricGroup( filt, 5 );;

#
gap> ReidemeisterSpectrum( G );
[ 4, 6 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 4, 6 ]
gap> CoincidenceReidemeisterSpectrum( G );
[ 1, 4, 6, 168 ]
gap> FSpec := FullReidemeisterSpectrum( G );;
gap> Length( FSpec ) = 38 and FSpec{[1..16]} = [1..16];
true

#
gap> ReidemeisterSpectrum( A );
[ 3, 5, 7 ]
gap> ExtendedReidemeisterSpectrum( A );
[ 1, 3, 5, 7 ]
gap> CoincidenceReidemeisterSpectrum( A );
[ 1, 3, 5, 7, 360 ]

#
gap> ReidemeisterSpectrum( S );
[ 7 ]
gap> ExtendedReidemeisterSpectrum( S );
[ 1, 2, 7 ]
gap> CoincidenceReidemeisterSpectrum( S );
[ 1, 2, 7, 60, 64, 66, 120 ]

#
gap> CoincidenceReidemeisterSpectrum( A, S );
[ 120 ]
gap> CoincidenceReidemeisterSpectrum( S, A );
[ 180, 184, 360 ]

#
gap> STOP_TEST( "spectra_non_pc.tst" );
