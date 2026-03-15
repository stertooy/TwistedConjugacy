#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_creation
#! @Returns the <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy class of
#! <A>g</A>.
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "TwistedConjugacyClass" );
#! @Arguments hom1[, hom2], g
DeclareSynonym( "ReidemeisterClass", TwistedConjugacyClass );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle Representative
#! @Returns the group element that was used to construct <A>tcc</A>.
#! @Label of a twisted conjugacy class
#! @ItemType Attr
#! @Arguments tcc
DeclareGlobalName( "Representative" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle ActingDomain
#! @Returns the group whose twisted conjugacy action <A>tcc</A> is an orbit of.
#! @Label of a twisted conjugacy class
#! @ItemType Attr
#! @Arguments tcc
DeclareGlobalName( "ActingDomain" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle FunctionAction
#! @Returns the twisted conjugacy action that <A>tcc</A> is an orbit of.
#! @Label of a twisted conjugacy class
#! @ItemType Attr
#! @Arguments tcc
DeclareGlobalName( "FunctionAction" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>g</A> is an element of <A>tcc</A>, otherwise
#! <K>false</K>.
#! @Label for an element and a twisted conjugacy class
#! @ItemType Oper
#! @Arguments g, tcc
DeclareGlobalName( "\in" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle Size
#! @Returns the number of elements in <A>tcc</A>.
#! @Description
#! This is calculated using the orbit-stabiliser theorem.
#! @Label of a twisted conjugacy class
#! @ItemType Attr
#! @Arguments tcc
DeclareGlobalName( "Size" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle StabiliserOfExternalSet
#! @Returns the stabiliser of <C>Representative(<A>tcc</A>)</C> under the
#! action <C>FunctionAction(<A>tcc</A>)</C>.
#! @Label of a twisted conjugacy class
#! @ItemType Attr
#! @Arguments tcc
DeclareGlobalName( "StabiliserOfExternalSet" );
#! @Label of a twisted conjugacy class
#! @ItemType Attr
#! @Arguments tcc
DeclareGlobalName( "StabilizerOfExternalSet" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle List
#! @Returns a list containing the elements of <A>tcc</A>.
#! @Description
#! If <A>tcc</A> is infinite, this will run forever. It is recommended to first
#! test the finiteness of <A>tcc</A> using
#! <Ref Attr="Size" Label="of a twisted conjugacy class" Style="Number"/>.
#! @Label of a twisted conjugacy class
#! @ItemType Func
#! @Arguments tcc
DeclareGlobalName( "List" );
#! @Label for a twisted conjugacy class
#! @ItemType Attr
#! @Arguments tcc
DeclareGlobalName( "AsList" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle Random
#! @Returns a random element in <A>tcc</A>.
#! @Label in a twisted conjugacy class
#! @ItemType Oper
#! @Arguments tcc
DeclareGlobalName( "Random" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_opers
#! @GroupTitle \=
#! @Returns <K>true</K> if <A>tcc1</A> is equal to <A>tcc2</A>, otherwise
#! <K>false</K>.
#! @Label for twisted conjugacy classes
#! @ItemType Oper
#! @Arguments tcc1, tcc2
DeclareGlobalName( "\=" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_calc
#! @Returns a list containing the (<A>hom1</A>, <A>hom2</A>)-twisted conjugacy
#! classes if there are finitely many, or <K>fail</K> otherwise.
#! @Description
#! If the argument <A>N</A> is provided, it must be a normal subgroup of
#! <C>Range(<A>hom1</A>)</C>; the function will then only return the
#! Reidemeister classes that intersect <A>N</A> non-trivially.
#! It is guaranteed that the Reidemeister class of the identity is in the first
#! position, and that the representatives of the classes belong to <A>N</A> if
#! this argument is provided.
#! <P />
#! If $G$ and $H$ are finite, this function relies on an orbit-stabiliser
#! algorithm.
#! Otherwise, it relies on the algorithms in <Cite Key='dt21-a'/> and
#! <Cite Key='tert25-a' />.
#! @Arguments hom1[, hom2][, N]
DeclareGlobalFunction( "TwistedConjugacyClasses" );
#! @Arguments hom1[, hom2][, N]
DeclareSynonym( "ReidemeisterClasses", TwistedConjugacyClasses );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo twistedconjugacyclasses, tcc_calc
#! @Returns a list containing representatives of the
#! (<A>hom1</A>, <A>hom2</A>)-twisted conjugacy classes if there are finitely
#! many, or <K>fail</K> otherwise.
#! @Description
#! If the argument <A>N</A> is provided, it must be a normal subgroup of
#! <C>Range(<A>hom1</A>)</C>; the function will then only return the
#! representatives of the twisted conjugacy classes that intersect <A>N</A>
#! non-trivially.
#! It is guaranteed that the identity is in the first position, and that all
#! elements belong to <A>N</A> if this argument is provided.
#! @Arguments hom1[, hom2][, N]
DeclareGlobalFunction( "RepresentativesTwistedConjugacyClasses" );
#! @Arguments hom1[, hom2][, N]
DeclareSynonym(
    "RepresentativesReidemeisterClasses",
    RepresentativesTwistedConjugacyClasses
);
#! @EndGroup

DeclareOperation(
    "RepresentativesTwistedConjugacyClassesOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ]
);
