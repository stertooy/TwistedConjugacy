#! @Chapter twistedconjugation

#! @Section twistedconjugationaction

#! @Returns a function that maps the pair <C>(g,h)</C> to
#! <A>hom1</A><C>(h)⁻¹</C> <C>g</C> <A>hom2</A><C>(h)</C>.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "TwistedConjugation" );

#! @Section tcp

#! @Returns <K>true</K> if <A>g1</A> and <A>g2</A> are
#! <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugate, otherwise <K>false</K>.
#! @Arguments hom1[, hom2], g1[, g2]
DeclareGlobalFunction( "IsTwistedConjugate" );

#! @Returns an element that maps <A>g1</A> to <A>g2</A> under the
#! <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy action, or <K>fail</K> if
#! no such element exists.
#! @Description
#! If the source group is finite, this function relies on orbit-stabiliser
#! algorithms provided by &GAP;. Otherwise, it relies on a mixture of the
#! algorithms described in <Cite Key='roma16-a' Where='Thm. 3'/>,
#! <Cite Key='bkl20-a' Where='Sec. 5.4'/>,
#! <Cite Key='roma21-a' Where='Sec. 7'/> and <Cite Key='dt21-a'/>.
#! @Arguments hom1[, hom2], g1[, g2]
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );

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
