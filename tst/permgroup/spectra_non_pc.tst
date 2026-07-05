gap> START_TEST( "Testing TwistedConjugacy for PermGroups: Reidemeister spectra of non-polycyclic groups" );

# Preparation
gap> filt := IsPermGroup;;
gap> G := SL( filt, 2, 7 );;
gap> A := AlternatingGroup( filt, 7 );;

#
gap> ReidemeisterSpectrum( G );
[ 7, 11 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 7, 11 ]
gap> CoincidenceReidemeisterSpectrum( G );
[ 1, 7, 11, 336 ]

#
gap> ReidemeisterSpectrum( A );
[ 7, 9 ]
gap> ExtendedReidemeisterSpectrum( A );
[ 1, 7, 9 ]
gap> CoincidenceReidemeisterSpectrum( A );
[ 1, 7, 9, 2520 ]

#
gap> CoincidenceReidemeisterSpectrum( A, G );
[ 336 ]
gap> CoincidenceReidemeisterSpectrum( G, A );
[ 15, 22, 24, 2520 ]

#
gap> STOP_TEST( "spectra_non_pc.tst" );
