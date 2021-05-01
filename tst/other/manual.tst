gap> START_TEST( "Testing TwistedConjugacy: examples from the manual" );

#
gap> G := AlternatingGroup( 6 );;
gap> H := SymmetricGroup( 5 );;
gap> phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
>  [ (1,2)(3,4), () ] );;
gap> psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
>  [ (1,4)(3,6), () ] );; 
gap> tc := TwistedConjugation( phi, psi );;
gap> g1 := (4,6,5);;
gap> g2 := (1,6,4,2)(3,5);;
gap> IsTwistedConjugate( psi, phi, g1, g2 );
false
gap> h := RepresentativeTwistedConjugation( phi, psi, g1, g2 );
(1,2)
gap> tc( g1, h ) = g2;
true

#
gap> tcc := ReidemeisterClass( phi, psi, g1 );
(4,6,5)^G
gap> Representative( tcc );
(4,6,5)
gap> GroupHomomorphismsOfReidemeisterClass( tcc );
[ [ (1,2)(3,5,4), (2,3)(4,5) ] -> [ (1,2)(3,4), () ],
  [ (1,2)(3,5,4), (2,3)(4,5) ] -> [ (1,4)(3,6), () ] ]
gap> ActingDomain( tcc ) = H;
true
gap> FunctionAction( tcc )( g1, h );
(1,6,4,2)(3,5)
gap> Random( tcc ) in tcc;
true
gap> List( tcc );
[ (4,6,5), (1,6,4,2)(3,5) ]
gap> Size( tcc );
2
gap> StabiliserOfExternalSet( tcc );
Group([ (1,2,3,4,5), (1,3,4,5,2) ])
gap> ReidemeisterClasses( phi, psi ){[1..3]};
[ ()^G, (4,5,6)^G, (4,6,5)^G ]
gap> NrTwistedConjugacyClasses( phi, psi );
184

#
gap> ReidemeisterSpectrum( G );
[ 3, 5, 7 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 3, 5, 7 ]
gap> CoincidenceReidemeisterSpectrum( G );
[ 1, 3, 5, 7, 360 ]
gap> CoincidenceReidemeisterSpectrum( H );
[ 1, 2, 7, 60, 64, 66, 120 ]
gap> CoincidenceReidemeisterSpectrum( H, G );
[ 180, 184, 360 ]
gap> CoincidenceReidemeisterSpectrum( G, H );
[ 120 ]

#
gap> khi := GroupHomomorphismByImages( G, G, [ (1,2,3,4,5), (4,5,6) ],
>  [ (1,2,6,3,5), (1,4,5) ] );;
gap> ReidemeisterZetaCoefficients( khi );
[ [ 7 ], [ ] ]
gap> IsRationalReidemeisterZeta( khi );
true
gap> ReidemeisterZeta( khi );
function( s ) ... end
gap> s := Indeterminate( Rationals, "s" );;
gap> ReidemeisterZeta( khi )(s);
(1)/(-s^7+7*s^6-21*s^5+35*s^4-35*s^3+21*s^2-7*s+1)
gap> PrintReidemeisterZeta( khi );
"(1-s)^(-7)"

#
gap> STOP_TEST( "manual.tst" );
