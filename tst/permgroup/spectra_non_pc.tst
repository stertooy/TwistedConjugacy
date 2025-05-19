gap> START_TEST( "Testing TwistedConjugacy for PermGroups: Reidemeister spectra of non-polycyclic groups" );

# Preparation
gap> filt := IsPermGroup;;
gap> G := SL( filt, 2, 5 );;
gap> A := AlternatingGroup( filt, 5 );;

#
gap> ReidemeisterSpectrum( G );
[ 5, 9 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 5, 9 ]
gap> CoincidenceReidemeisterSpectrum( G );
[ 1, 5, 9, 120 ]

#
gap> ReidemeisterSpectrum( A );
[ 3, 5 ]
gap> ExtendedReidemeisterSpectrum( A );
[ 1, 3, 5 ]
gap> CoincidenceReidemeisterSpectrum( A );
[ 1, 3, 5, 60 ]
gap> TotalReidemeisterSpectrum( A );
[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 15, 16, 17, 18, 20, 22, 30, 32, 60 ]

#
gap> CoincidenceReidemeisterSpectrum( A, G );
[ 120 ]
gap> CoincidenceReidemeisterSpectrum( G, A );
[ 1, 3, 5, 60 ]

#
gap> STOP_TEST( "spectra_non_pc.tst" );
