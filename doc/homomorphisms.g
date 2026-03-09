#! @Chapter homomorphisms

#! @Section homreps

#! @Returns a list of the automorphisms of <A>G</A> up to composition with
#! inner automorphisms.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesAutomorphismClasses" );

#! @Returns a list of the endomorphisms of <A>G</A> up to composition with
#! inner automorphisms.
#! @Description
#! This does the same as calling
#! <C>AllHomomorphismClasses(<A>G</A>,<A>G</A>)</C>, but should be faster for
#! abelian and non-2-generated groups.
#! For 2-generated groups, this function behaves nearly identical to
#! <Ref Func="AllHomomorphismClasses" BookName="Ref" Style="Number"/>.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesEndomorphismClasses" );

#! @Returns a list of the homomorphisms from <A>H</A> to <A>G</A>, up to
#! composition with inner automorphisms of <A>G</A>.
#! @Description
#! This does the same as calling
#! <C>AllHomomorphismClasses(<A>H</A>,<A>G</A>)</C>, but should be faster for
#! abelian and non-2-generated groups. For 2-generated groups, this function
#! behaves nearly identical to
#! <Ref Func="AllHomomorphismClasses" BookName="Ref" Style="Number"/>.
#! @Arguments H, G
DeclareGlobalFunction( "RepresentativesHomomorphismClasses" );

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

#! @Returns the homomorphism induced by <A>hom</A> between the images of
#! <A>epi1</A> and <A>epi2</A>.
#! @Description
#! Let <A>hom</A> be a group homomorphism from a group <C>H</C> to a group
#! <C>G</C>, let <A>epi1</A> be an epimorphism from <C>H</C> to a group
#! <C>Q</C> and let <A>epi2</A> be an epimorphism from <C>G</C> to a group
#! <C>P</C> such that the kernel of <A>epi1</A> is mapped into the kernel of
#! <A>epi2</A> by <A>hom</A>.
#! This command returns the homomorphism from <C>Q</C> to <C>P</C> that maps
#! <C>h^<A>epi1</A></C> to <C>(h^<A>hom</A>)^<A>epi2</A></C>, for any element
#! <C>h</C> of <C>H</C>.
#! This function generalises
#! <Ref Func="InducedAutomorphism" BookName="ref" Style="Number"/> to
#! homomorphisms.
#! @Arguments epi1, epi2, hom
DeclareGlobalFunction( "InducedHomomorphism" );

#! @Returns the homomorphism <A>hom</A>, but restricted as a map from <A>N</A>
#! to <A>M</A>.
#! @Description
#! Let <A>hom</A> be a group homomorphism from a group <C>H</C> to a group
#! <C>G</C>, and let <A>N</A> be subgroup of <C>H</C> such that its image under
#! <A>hom</A> is a subgroup of <A>M</A>.
#! This command returns the homomorphism from <A>N</A> to <A>M</A> that maps
#! <C>n</C> to <C>n^<A>hom</A></C> for any element <C>n</C> of <A>N</A>. 
#! No checks are made to verify that <A>hom</A> maps <A>N</A> into <A>M</A>.
#! This function is similar to
#! <Ref Func="RestrictedMapping" BookName="ref" Style="Number"/>, but its range
#! is explicitly set to <A>M</A>.
#! @Arguments hom, N, M
DeclareGlobalFunction( "RestrictedHomomorphism" );

#! @BeginExample
N := DerivedSubgroup( G );;
p := NaturalHomomorphismByNormalSubgroup( G, N );
#! [ f1, f2, f3 ] -> [ f1, f2, <identity> of ... ]
ind := InducedHomomorphism( p, p, phi );
#! [ f1 ] -> [ f1*f2 ]
res := RestrictedHomomorphism( phi, N, N );
#! [ f3 ] -> [ f3^3 ]
#! @EndExample
