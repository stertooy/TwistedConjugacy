gap> START_TEST( "Testing Twisted Conjugacy for finite pc groups" );

#
# Extra Groups
#
gap> ProductCyclicGroups := function ( L ) return DirectProduct( List( L, i -> CyclicGroup( i ) ) ); end;;

#
gap> L1 := [ 2, 3, 5, 6, 24, 30 ];;
gap> G1 := ProductCyclicGroups( L1 );;
gap> ReidemeisterSpectrum( G1 ) = 2*DivisorsInt( Size( G1 ) / 2 );
true
gap> ExtendedReidemeisterSpectrum( G1 ) = DivisorsInt( Product( L1 ) );
true

#
gap> L2 := [ 2, 3, 5, 17, 24 ];;
gap> G2 := ProductCyclicGroups( L2 );;
gap> ReidemeisterSpectrum( G2 ) = 4*DivisorsInt( Size( G2 ) / 4 );
true
gap> ExtendedReidemeisterSpectrum( G2 ) = DivisorsInt( Product( L2 ) );
true

#
gap> L3 := [ 512, 512 ];;
gap> G3 := ProductCyclicGroups( L3 );;
gap> ReidemeisterSpectrum( G3 ) = DivisorsInt( 2^18 );
true
gap> ExtendedReidemeisterSpectrum( G3 ) = DivisorsInt( 2^18 );
true

#
gap> STOP_TEST( "finite_pc_single.tst" );
