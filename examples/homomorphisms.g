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

#! @BeginExample
phi := GroupHomomorphismByImages( G, G, [ G.1, G.3 ],
 [ G.1 * G.2, G.3 ^ 3 ] );;
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
