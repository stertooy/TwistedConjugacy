gap> START_TEST( "Testing TwistedConjugacy for crystallographic PcpGroups: Reidemeister spectra" );

#
gap> G := AbelianPcpGroup( 1 );;
gap> ReidemeisterSpectrum( G );
[ 2, infinity ]
gap> G := DihedralPcpGroup( 0 );;
gap> ReidemeisterSpectrum( G );
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
gap> STOP_TEST( "spectra.tst" );
