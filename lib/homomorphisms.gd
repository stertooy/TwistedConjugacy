#! @ChapterInfo homomorphisms, homreps
#! @Returns a list of the automorphisms of <A>G</A> up to composition with
#! inner automorphisms.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesAutomorphismClasses" );

DeclareOperation(
    "RepresentativesAutomorphismClassesOp",
    [ IsGroup ]
);

#! @ChapterInfo homomorphisms, homreps
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

DeclareOperation(
    "RepresentativesEndomorphismClassesOp",
    [ IsGroup ]
);

#! @ChapterInfo homomorphisms, homreps
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

DeclareOperation(
    "RepresentativesHomomorphismClassesOp",
    [ IsGroup, IsGroup ]
);

#! @ChapterInfo homomorphisms, inducerestrict
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

#! @ChapterInfo homomorphisms, inducerestrict
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
