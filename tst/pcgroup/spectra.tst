gap> START_TEST( "Testing TwistedConjugacy for PcGroups: Reidemeister spectra" );

# Preparation
gap> filt := IsPcGroup;;

# For given group, calculate spectra of group, subgroups and quotients
# Reidemeister spectrum only, endomorphisms take too long
gap> G := PcGroupCode( 57308604420143, 252 );;
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
gap> G1 := PcGroupCode( 17750835801, 32 );;
gap> ReidemeisterSpectrum( G1 );
[ 6, 8, 10, 14 ]
gap> ExtendedReidemeisterSpectrum( G1 );
[ 1, 2, 4, 5, 6, 7, 8, 10, 14 ]

#
gap> G2 := PcGroupCode( 17734058326, 32 );;
gap> ReidemeisterSpectrum( G2 );
[ 2, 3, 5, 9, 17 ]
gap> ExtendedReidemeisterSpectrum( G2 );
[ 1, 2, 3, 5, 9, 17 ]

#
gap> G3 := PcGroupCode( 553128533058418720, 96 );;
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
