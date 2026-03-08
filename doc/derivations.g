#! @Chapter derivations

#! @Section gd_creating

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

#! @Section gd_operations

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

#! @Section gd_images

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
