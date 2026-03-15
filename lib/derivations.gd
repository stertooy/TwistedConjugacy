DeclareCategory( "IsGroupDerivation", IsSPGeneralMapping );

InstallTrueMethod( IsMapping, IsGroupDerivation );
InstallTrueMethod( RespectsOne, IsGroupDerivation );

DeclareAttribute( "GroupDerivationInfo", IsGroupDerivation );
DeclareAttribute( "KernelOfGroupDerivation", IsGroupDerivation );

#! @BeginGroup
#! @ChapterInfo derivations, gd_creating
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

#! @ChapterInfo derivations, gd_creating
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

#! @ChapterInfo derivations, gd_creating
#! @Returns the derivation that makes up the translational part of the affine
#! action.
#! @Arguments H, G, act
DeclareGlobalFunction( "GroupDerivationByAffineAction" );

DeclareProperty( "IsGroupDerivationImage", IsOrbitAffineAction );

#! @BeginGroup
#! @ChapterInfo derivations, gd_operations
#! @GroupTitle IsInjective
#! @Returns <K>true</K> if the group derivation <A>der</A> is injective,
#! otherwise <K>false</K>.
#! @Label for a group derivation
#! @ItemType Prop
#! @Arguments der
DeclareGlobalName( "IsInjective" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_operations
#! @GroupTitle IsSurjective
#! @Returns <K>true</K> if the group derivation <A>der</A> is surjective,
#! otherwise <K>false</K>.
#! @Label for a group derivation
#! @ItemType Prop
#! @Arguments der
DeclareGlobalName( "IsSurjective" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_operations
#! @GroupTitle IsBijective
#! @Returns <K>true</K> if the group derivation <A>der</A> is bijjective,
#! otherwise <K>false</K>.
#! @Label for a group derivation
#! @ItemType Prop
#! @Arguments der
DeclareGlobalName( "IsBijective" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_operations
#! @GroupTitle Kernel
#! @Returns the set of elements that are mapped to the identity by <A>der</A>.
#! @Description
#! This will always be a subgroup of <C>Source</C>(<A>der</A>).
#! @Label of a group derivation
#! @ItemType Oper
#! @Arguments der
DeclareGlobalName( "Kernel" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_operations
#! @GroupTitle Image
#! @Returns the image of the group derivation <A>der</A>.
#! @Description
#! One can optionally give an element <A>elm</A> or a subgroup <A>sub</A> as a
#! second argument, in which case <C>Image</C> will calculate the image of this
#! argument under <A>der</A>.
#! @Label of a group derivation
#! @ItemType Func
#! @Arguments der
DeclareGlobalName( "Image" );
#! @Label of an element under a group derivation
#! @ItemType Func
#! @Arguments der, elm
DeclareGlobalName( "Image" );
#! @Label of a subgroup under a group derivation
#! @ItemType Func
#! @Arguments der, sub
DeclareGlobalName( "Image" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_operations
#! @GroupTitle PreImagesRepresentative
#! @Returns a preimage of the element <A>elm</A> under the group derivation
#! <A>der</A>, or <K>fail</K> if no preimage exists.
#! @Label of an element under a group derivation
#! @ItemType Oper
#! @Arguments der, elm
DeclareGlobalName( "PreImagesRepresentative" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_operations
#! @GroupTitle PreImages
#! @Returns the set of all preimages of the element <A>elm</A> under the group
#! derivation <A>der</A>.
#! @Description
#! This will always be a (right) coset of <C>Kernel</C>( <A>der</A> ), or the
#! empty list.
#! @Label of an element under a group derivation
#! @ItemType Func
#! @Arguments der, elm
DeclareGlobalName( "PreImages" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_images
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>elm</A> is an element of <A>img</A>, otherwise
#! <K>false</K>.
#! @Label for an element and a group derivation image
#! @ItemType Oper
#! @Arguments elm, img
DeclareGlobalName( "\in" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_images
#! @GroupTitle Size
#! @Returns the number of elements in <A>img</A>.
#! @Label of a group derivation image
#! @ItemType Attr
#! @Arguments img
DeclareGlobalName( "Size" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo derivations, gd_images
#! @GroupTitle List
#! @Returns a list containing the elements of <A>img</A>.
#! @Description
#! If <A>img</A> is infinite, this will run forever or cause an error. It is
#! recommended to first test the finiteness of <A>img</A> using
#! <Ref Attr="Size" Label="of a group derivation image" Style="Number"/>.
#! @Label of a group derivation image
#! @ItemType Func
#! @Arguments img
DeclareGlobalName( "List" );
#! @Label for a group derivation image
#! @ItemType Attr
#! @Arguments img
DeclareGlobalName( "AsList" );
#! @EndGroup
