#! @Chapter twistedconjugation

#! @Section tcp

#! @BeginExample
G := AlternatingGroup( 6 );;
H := SymmetricGroup( 5 );;
phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
tc := TwistedConjugation( phi, psi );;
g1 := (4,6,5);;
g2 := (1,6,4,2)(3,5);;
IsTwistedConjugate( psi, phi, g1, g2 );
#! false
h := RepresentativeTwistedConjugation( phi, psi, g1, g2 );
#! (1,2)
tc( g1, h ) = g2;
#! true
#! @EndExample

#! @Section mtcp

#! @BeginExample
H := SymmetricGroup( 5 );;
G := AlternatingGroup( 6 );;
phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
tau := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,6), () ] );;
khi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,3)(4,6), () ] );;
IsTwistedConjugate( [ phi, psi ], [ khi, tau ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! true
RepresentativeTwistedConjugation( [ phi, psi ], [ khi, tau ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! (1,2)
#! @EndExample
