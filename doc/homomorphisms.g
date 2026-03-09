#! @Chapter homomorphisms

#! @Section homreps

#! @BeginExample
G := PcGroupCode( 1018013, 28 );;
Auts := RepresentativesAutomorphismClasses( G );;
Size( Auts );
#! 6
Ends := RepresentativesEndomorphismClasses( G );;
Size( Ends );
#! 10
H := PcGroupCode( 36293, 28 );;
Homs := RepresentativesHomomorphismClasses( H, G );;
Size( Homs );
#! 4
#! @EndExample

#! @Section coincidence

#! @Returns the subgroup of <C>Source(<A>endo</A>)</C> consisting of the
#! elements fixed under the endomorphism <A>endo</A>.
#! @Arguments endo
DeclareGlobalFunction( "FixedPointGroup" );

#! @Returns the subgroup of <C>Source(<A>hom1</A>)</C> consisting of the
#! elements <C>h</C> for which <C>h^<A>hom1</A></C> = <C>h^<A>hom2</A></C> =
#! ...
#! @Description
#! For infinite non-abelian groups, this function relies on a mixture of the
#! algorithms described in <Cite Key='roma16-a' Where='Thm. 2'/>,
#! <Cite Key='bkl20-a' Where='Sec. 5.4'/> and
#! <Cite Key='roma21-a' Where='Sec. 7'/>.
#! @Arguments hom1, hom2[, ...]
DeclareGlobalFunction( "CoincidenceGroup" );

#! @BeginExample
phi := GroupHomomorphismByImages( G, G, [ G.1, G.3 ], [ G.1*G.2, G.3^3 ] );;
Set( FixedPointGroup( phi ) );
#! [ <identity> of ..., f2 ]
psi := GroupHomomorphismByImages( H, G, [ H.1, H.2, H.3 ],
 [ One( G ), G.2, One( G ) ] );;
khi := GroupHomomorphismByImages( H, G, [ H.1, H.2, H.3 ],
 [ G.2, G.2, One( G ) ] );;
CoincidenceGroup( psi, khi );
#! Group([ f2, f3 ])
#! @EndExample

#! @Section inducerestrict

#! @BeginExample
N := DerivedSubgroup( G );;
p := NaturalHomomorphismByNormalSubgroup( G, N );
#! [ f1, f2, f3 ] -> [ f1, f2, <identity> of ... ]
ind := InducedHomomorphism( p, p, phi );
#! [ f1 ] -> [ f1*f2 ]
res := RestrictedHomomorphism( phi, N, N );
#! [ f3 ] -> [ f3^3 ]
#! @EndExample
