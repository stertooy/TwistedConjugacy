gap> START_TEST( "Testing TwistedConjugacy for crystallographic PcpGroups: Reidemeister spectra" );

#
gap> G := AbelianPcpGroup( 1 );;
gap> ReidemeisterSpectrum( G );
[ 2, infinity ]
gap> H := DihedralPcpGroup( 0 );;
gap> ReidemeisterSpectrum( H );
[ infinity ]
gap> phi := GroupHomomorphismByImages( G, G, [ G.1 ], [ G.1^-1 ] );;
gap> K := SemidirectProductWithAutomorphism@TwistedConjugacy( G, phi );;
gap> ReidemeisterSpectrum( K );
[ infinity ]

#
gap> H := AbelianPcpGroup( 2 );;
gap> RepresentativesAutomorphismClasses( H );
fail

#
gap> mats := [ [ [ 0, -1 ], [ 1, -1 ] ] ];;
gap> P := AbelianPcpGroup( [ 3 ] );;
gap> G := SplitExtensionPcpGroup( P, mats );;
gap> ReidemeisterSpectrum( G );
[ 4, infinity ]

#
gap> mats := [ [ [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 0, 0, 0, -1 ], [ 0, 0, -1, 0 ] ], [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, -1, 0 ], [ 0, 0, 0, -1 ] ], [ [ 0, -1, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 0, 0, -1 ], [ 0, 0, 1, 0 ] ] ];;
gap> P := Image( IsomorphismPcpGroup( Group( mats ) ) );;
gap> G := SplitExtensionPcpGroup( P, mats );;
gap> ReidemeisterSpectrum( G );
[ 4, 8, infinity ]
gap> C := CRRecordBySubgroup( G, FittingSubgroup( G ) );;
gap> c := [ 0, 0, 0, 0, 1, 1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, -1, 1, 0 ];;
gap> H := ExtensionCR( C, c );;
gap> ReidemeisterSpectrum( H );
[ 4, 8, infinity ]
gap> c := [ 0, 0, 0, 0, 1, 1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, -1, 0, 1 ];;
gap> K := ExtensionCR( C, c );;
gap> ReidemeisterSpectrum( K );
[ infinity ]

#
gap> STOP_TEST( "spectra.tst" );
