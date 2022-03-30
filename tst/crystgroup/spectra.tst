gap> START_TEST( "Testing TwistedConjugacy for crystallographic PcpGroups: Reidemeister spectra" );

#
gap> G := AbelianPcpGroup( 1 );;
gap> ReidemeisterSpectrum( G );
[ 2, infinity ]
gap> G := DihedralPcpGroup( 0 );;
gap> ReidemeisterSpectrum( G );
[ infinity ]

#
gap> STOP_TEST( "spectra.tst" );
