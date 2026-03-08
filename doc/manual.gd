#! @Chapter Group homomorphisms

#! @Section Representatives of homomorphisms between groups

#! Please note that the functions below are only implemented for finite groups.

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
G := SymmetricGroup( 6 );;
Auts := RepresentativesAutomorphismClasses( G );;
Size( Auts );
#! 2
ForAll( Auts, IsGroupHomomorphism and IsEndoMapping and IsBijective );
#! true
Ends := RepresentativesEndomorphismClasses( G );;
Size( Ends );
#! 6
ForAll( Ends, IsGroupHomomorphism and IsEndoMapping );
#! true
H := SymmetricGroup( 5 );;
Homs := RepresentativesHomomorphismClasses( H, G );;
Size( Homs );
#! 6
ForAll( Homs, IsGroupHomomorphism );
#! true
#! @EndExample

#! @Section Coincidence and fixed point groups

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
phi := GroupHomomorphismByImages( G, G, [ (1,2,5,6,4), (1,2)(3,6)(4,5) ],
 [ (2,3,4,5,6), (1,2) ] );;
Set( FixedPointGroup( phi ) );
#! [ (), (1,2,3,6,5), (1,3,5,2,6), (1,5,6,3,2), (1,6,2,5,3) ]
psi := GroupHomomorphismByImages( H, G, [ (1,2,3,4,5), (1,2) ],
 [ (), (1,2) ] );;
khi := GroupHomomorphismByImages( H, G, [ (1,2,3,4,5), (1,2) ],
 [ (), (1,2)(3,4) ] );;
CoincidenceGroup( psi, khi ) = AlternatingGroup( 5 );
#! true
#! @EndExample

#! @Section Induced and restricted group homomorphisms

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
G := PcGroupCode( 1018013, 28 );;
phi := GroupHomomorphismByImages( G, G, [ G.1, G.3 ],
 [ G.1*G.2*G.3^2, G.3^4 ] );;
N := DerivedSubgroup( G );;
p := NaturalHomomorphismByNormalSubgroup( G, N );
#! [ f1, f2, f3 ] -> [ f1, f2, <identity> of ... ]
ind := InducedHomomorphism( p, p, phi );
#! [ f1 ] -> [ f1*f2 ]
Source( ind ) = Range( p ) and Range( ind ) = Range( p );
#! true
res := RestrictedHomomorphism( phi, N, N );
#! [ f3 ] -> [ f3^4 ]
Source( res ) = N and Range( res ) = N;
#! true
#! @EndExample

#! @Chapter Group derivations

#! Let $G$ and $H$ be groups and let $H$ act on $G$ via automorphisms, i.e.
#! there is a group homomorphism
#! $$\alpha \colon H \to \operatorname{Aut}(G) \colon h \mapsto \alpha_h$$
#! such that $g^h = \alpha_h(g)$ for all $g \in G$ and $h \in H$.
#! A **group derivation** $\delta \colon H \to G$ is a map such that
#! $$\delta(h_1h_2) = \delta(h_1)^{h_2}\delta(h_2).$$
#! Note that we do not require $G$ to be abelian.

#! <P/>

#! Algorithms designed for computing with twisted conjugacy classes can be
#! leveraged to do computations involving group derivations, see
#! <Cite Key='tert25-a' Where='Sec. 10'/> for a description on this.

#! <P/>

#! Please note that the functions in this chapter require $G$ and $H$ to either
#! both be finite, or both be PcpGroups.

#! @Section Creating group derivations

#! @BeginGroup
#! @Returns the specified group derivation, or <K>fail</K> if the given
#! arguments do not define a derivation.
#! @Description
#! This works in the same vein as
#! <Ref Func="GroupHomomorphismByImages" BookName="Ref" Style="Number"/>. The
#! group <A>H</A> acts on the group <A>G</A> via <A>act</A>, which must be a
#! homomorphism from <A>H</A> into a group of automorphisms of <A>G</A>. This
#! command then returns the group derivation defined by mapping the list
#! <A>gens</A> of generators of <A>H</A> to the list <A>imgs</A> of images in
#! <A>G</A>.
#!
#! If omitted, the arguments <A>gens</A> and <A>imgs</A> default to the
#! <C>GeneratorsOfGroup</C> value of <A>H</A> and <A>G</A> respectively.
#!
#! This function checks whether <A>gens</A> generate <A>H</A> and whether the
#! mapping of the generators extends to a group derivation. This test can be
#! expensive, so if one is certain that the given arguments produce a group
#! derivation, these checks can be avoided by using the <C>NC</C> version.
#! @Arguments H, G[[, gens], imgs], act
DeclareGlobalFunction( "GroupDerivationByImages" );
#! @Arguments H, G[[, gens], imgs], act
DeclareGlobalFunction( "GroupDerivationByImagesNC" );
#! @EndGroup

#! @Returns the specified group derivation.
#! @Description
#! <C>GroupDerivationByFunction</C> works in the same vein as
#! <Ref Func="GroupHomomorphismByFunction" BookName="Ref" Style="Number"/>. The
#! group <A>H</A> acts on the group <A>G</A> via <A>act</A>, which must be a
#! homomorphism from <A>H</A> into a group of automorphisms of <A>G</A>. This
#! command then returns the group derivation defined by mapping the element
#! <C>h</C> of <A>H</A> to the element <A>fun</A>( <C>h</C> ) of <A>G</A>,
#! where <A>fun</A> is a &GAP; function.
#!
#! No tests are performed to check whether the arguments really produce a group
#! derivation.
#! @Arguments H, G, fun, act
DeclareGlobalFunction( "GroupDerivationByFunction" );


#! @Returns the derivation that makes up the translational part of the affine
#! action.
#! @Arguments H, G, act
DeclareGlobalFunction( "GroupDerivationByAffineAction" );

#! @BeginExample
H := PcGroupCode( 149167619499417164, 72 );;
G := PcGroupCode( 5551210572, 72 );;
inn := InnerAutomorphism( G, G.2 );;
hom := GroupHomomorphismByImages(
     G, G,
     [ G.1*G.2, G.5 ], [ G.1*G.2^2*G.3^2*G.4, G.5 ]
   );;
act := GroupHomomorphismByImages(
     H, AutomorphismGroup( G ),
     [ H.2, H.1*H.4 ], [ inn, hom ]
   );;
gens := [ H.2, H.1*H.4 ];;
imgs := [ G.5, G.2 ];;
der := GroupDerivationByImages( H, G, gens, imgs, act );
#! Group derivation [ f2, f1*f4 ] -> [ f5, f2 ]
#! @EndExample

#! @Section Operations for group derivations

#! Many of the functions, operations, attributes... available to group
#! homomorphisms are available for group derivations as well.
#! We list some of the more useful ones.

#! @BeginGroup
#! @GroupTitle IsInjective
#! @Returns <K>true</K> if the group derivation <A>der</A> is injective,
#! otherwise <K>false</K>.
#! @Label for a group derivation
#! @Arguments der
DeclareProperty( "IsInjective", IsGroupDerivation );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle IsSurjective
#! @Returns <K>true</K> if the group derivation <A>der</A> is surjective,
#! otherwise <K>false</K>.
#! @Label for a group derivation
#! @Arguments der
DeclareProperty( "IsSurjective", IsGroupDerivation );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle IsBijective
#! @Returns <K>true</K> if the group derivation <A>der</A> is bijjective,
#! otherwise <K>false</K>.
#! @Label for a group derivation
#! @Arguments der
DeclareProperty( "IsBijective", IsGroupDerivation );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Kernel
#! @Returns the set of elements that are mapped to the identity by <A>der</A>.
#! @Description
#! This will always be a subgroup of <C>Source</C>(<A>der</A>).
#! @Label of a group derivation
#! @Arguments der
DeclareOperation( "Kernel", [ IsGroupDerivation ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Image
#! @Returns the image of the group derivation <A>der</A>.
#! @Description
#! One can optionally give an element <A>elm</A> or a subgroup <A>sub</A> as a
#! second argument, in which case <C>Image</C> will calculate the image of this
#! argument under <A>der</A>.
#! @Label of a group derivation
#! @Arguments der
DeclareGlobalFunction( "Image" );
#! @Label of an element under a group derivation
#! @Arguments der, elm
DeclareGlobalFunction( "Image" );
#! @Label of a subgroup under a group derivation
#! @Arguments der, sub
DeclareGlobalFunction( "Image" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle PreImagesRepresentative
#! @Returns a preimage of the element <A>elm</A> under the group derivation
#! <A>der</A>, or <K>fail</K> if no preimage exists.
#! @Label of an element under a group derivation
#! @Arguments der, elm
DeclareOperation( "PreImagesRepresentative", [ IsGeneralMapping, IsObject ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle PreImages
#! @Returns the set of all preimages of the element <A>elm</A> under the group
#! derivation <A>der</A>.
#! @Description
#! This will always be a (right) coset of <C>Kernel</C>( <A>der</A> ), or the
#! empty list.
#! @Label of an element under a group derivation
#! @Arguments der, elm
DeclareGlobalFunction( "PreImages" );
#! @EndGroup

#! @BeginExample
IsInjective( der ) or IsSurjective( der );
#! false
K := Kernel( der );;
Size( K );
#! 9
ImH := Image( der );
#! Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
h1 := H.1*H.3;;
g := Image( der, h1 );
#! f2*f4
ImK := Image( der, K );
#! Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
h2 := PreImagesRepresentative( der, g );;
Image( der, h2 ) = g;
#! true
PreIm := PreImages( der, g );
#! RightCoset(<group of size 9 with 2 generators>,<object>)
PreIm = RightCoset( K, h2 );
#! true
#! @EndExample

#! @Section Images of group derivations

#! In general, the image of a group derivation is not a subgroup. However, it
#! is still possible to do a membership test, to calculate the number of
#! elements, and to enumerate the elements if there are only finitely many.

#! @BeginGroup
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>elm</A> is an element of <A>img</A>, otherwise
#! <K>false</K>.
#! @Label for an element and a group derivation
#! @Arguments elm, img
DeclareOperation( "\in", [ IsObject, IsGroupDerivationImage ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Size
#! @Returns the number of elements in <A>img</A>.
#! @Label of a group derivation image
#! @Arguments img
DeclareAttribute( "Size", IsGroupDerivationImage );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle List
#! @Returns a list containing the elements of <A>img</A>.
#! @Description
#! If <A>img</A> is infinite, this will run forever. It is recommended to first
#! test the finiteness of <A>img</A> using
#! <Ref Attr="Size" Label="of a group derivation image" Style="Number"/>.
#! @Label of a group derivation image
#! @Arguments img
DeclareGlobalFunction( "List" );
#! @EndGroup

#! @BeginExample
Size( ImH );
#! 8
Size( ImK );
#! 1
g in ImH;
#! true
g in ImK;
#! false
List( ImK );
#! [ <identity> of ... ]
#! @EndExample

#! @Chapter Affine actions

#! Let $G$ and $H$ be groups, let $H$ act on $G$ (via automorphisms) by
#! $$\alpha \colon H \to \operatorname{Aut}(G) \colon h \mapsto \alpha_h$$
#! and let $\delta \colon H \to G$ be a group derivation with respect to this
#! action. Then we can construct a new action, called the **affine action**
#! associated to $\delta$, by
#! $$G \times H \to G \colon g^h = \alpha_h(g) \delta(h).$$
#! If $K$ is a subgroup of $H$, then the restriction of the affine action of
#! $H$ on $G$ to $K$ coincides with the affine action of $K$ on $G$ associated
#! to the restriction of $\delta$ to $K$.

#! <P/>

#! Algorithms designed for computing with twisted conjugacy classes can be
#! leveraged to do computations involving affine actions, see
#! <Cite Key='tert25-a' Where='Sec. 10'/> for a description on this.

#! <P/>

#! Please note that the functions in this chapter require $G$ and $H$ to either
#! both be finite, or both be PcpGroups.

#! @Section Creating an affine action

#! @BeginGroup
#! @Returns the affine action of <A>K</A> associated to the derivation <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, der
DeclareGlobalFunction( "AffineActionByGroupDerivation" );
#! @EndGroup

#! @BeginExample
aff := AffineActionByGroupDerivation( H, der );
#! function( g, k ) ... end
#! @EndExample

#! @Section Operations for affine actions

#! These functions are analogues of existing &GAP; functions for group actions.

#! @BeginGroup
#! @GroupTitle OrbitAffineAction
#! @Returns the orbit of <A>g</A> under the affine action of <A>K</A> associated
#! to <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g, der
DeclareGlobalFunction( "OrbitAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle OrbitsAffineAction
#! @Returns a list containing the orbits under the affine action of <A>K</A>
#! associated to  <A>der</A> if there are finitely many, or <K>fail</K> if there
#! are infinitely many.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, der
DeclareGlobalFunction( "OrbitsAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle NrOrbitsAffineAction
#! @Returns the number of orbits under the affine action of <A>K</A> associated
#! to <A>der</A>.
#! @Arguments K, der
DeclareGlobalFunction( "NrOrbitsAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle StabiliserAffineAction
#! @Returns the stabiliser of <A>g</A> under the affine action of <A>K</A> associated
#! to <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g, der
DeclareGlobalFunction( "StabiliserAffineAction" );
#! @Arguments K, g, der
DeclareGlobalFunction( "StabilizerAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle RepresentativeAffineAction
#! @Returns an element of <A>K</A> that maps <A>g1</A> to <A>g2</A> under the
#! affine action of <A>K</A> associated to <A>der</A>, or <K>fail</K> if no such
#! element exists.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g1, g2, der
DeclareGlobalFunction( "RepresentativeAffineAction" );
#! @EndGroup

#! @BeginExample
g1 := G.1;;
orb := OrbitAffineAction( H, g1, der );
#! f1^G
NrOrbitsAffineAction( H, der );
#! 10
stab := StabiliserAffineAction( H, g1, der );;
Set( stab );
#! [ <identity> of ..., f3, f3^2, f2^2*f5, f2*f4*f5,
#!   f2^2*f3*f5, f2*f3*f4*f5, f2^2*f3^2*f5, f2*f3^2*f4*f5 ]
g2 := G.1*G.4*G.5;;
h := RepresentativeAffineAction( H, g1, g2, der );;
aff( g1, h ) = g2;
#! true
#! @EndExample

#! @Section Operations on orbits of affine actions

#! @BeginGroup
#! @GroupTitle Representative
#! @Returns the group element that was used to construct <A>orb</A>.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "Representative", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle ActingDomain
#! @Returns the group whose affine action <A>orb</A> is an orbit of.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "ActingDomain", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle FunctionAction
#! @Returns the affine action that <A>orb</A> is an orbit of.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "FunctionAction", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>elm</A> is an element of <A>orb</A>, otherwise
#! <K>false</K>.
#! @Label for an element and an orbit of an affine action
#! @Arguments elm, orb
DeclareOperation( "\in", [ IsObject, IsOrbitAffineActionRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Size
#! @Returns the number of elements in <A>orb</A>.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "Size", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle StabiliserOfExternalSet
#! @Returns the stabiliser of <C>Representative(<A>orb</A>)</C> under the
#! action <C>FunctionAction(<A>orb</A>)</C>.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "StabiliserOfExternalSet", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle List
#! @Returns a list containing the elements of <A>orb</A>.
#! @Description
#! If <A>orb</A> is infinite, this will run forever. It is recommended to first
#! test the finiteness of <A>orb</A> using
#! <Ref Attr="Size" Label="of an orbit of an affine action" Style="Number"/>.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareGlobalFunction( "List" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Random
#! @Returns a random element in <A>orb</A>.
#! @Label in an orbit of an affine action
#! @Arguments orb
DeclareOperation( "Random", [ IsOrbitAffineActionRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \=
#! @Returns <K>true</K> if <A>orb1</A> is equal to <A>orb2</A>, otherwise
#! <K>false</K>.
#! @Label for orbits of an affine action
#! @Arguments orb1, orb2
DeclareOperation( "\=", [ IsOrbitAffineActionRep, IsOrbitAffineActionRep ] );
#! @EndGroup

#! @BeginExample
g2 in orb;
#! true
G.2 in orb;
#! false
Size( orb );
#! 8
#! @EndExample
