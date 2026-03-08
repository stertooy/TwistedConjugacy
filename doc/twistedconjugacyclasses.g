#! @Chapter twistedconjugacyclasses

#! @Section tcc_creation

#! @BeginGroup
#! @Returns the <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy class of
#! <A>g</A>.
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "TwistedConjugacyClass" );
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "ReidemeisterClass" );
#! @EndGroup

# START TEST
#! @Arguments hom1[, hom2], g
#! @Group AAAAgroup
DeclareGlobalFunction( "BBBBB" );

#! @BeginGroup AAAAgroup
#! @ChapterInfo reidemeisternumbers, reidemeisternumbers
#! @Returns the <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy class of
#! <A>g</A>.
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "AAAAA" );
#! @EndGroup
# END TEST

#! @Section tcc_opers

#! @BeginGroup
#! @GroupTitle Representative
#! @Returns the group element that was used to construct <A>tcc</A>.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "Representative", IsTwistedConjugacyClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle ActingDomain
#! @Returns the group whose twisted conjugacy action <A>tcc</A> is an orbit of.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "ActingDomain", IsTwistedConjugacyClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle FunctionAction
#! @Returns the twisted conjugacy action that <A>tcc</A> is an orbit of.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "FunctionAction", IsTwistedConjugacyClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>g</A> is an element of <A>tcc</A>, otherwise
#! <K>false</K>.
#! @Label for an element and a twisted conjugacy class
#! @Arguments g, tcc
DeclareOperation( "\in", [ IsObject, IsTwistedConjugacyClassGroupRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Size
#! @Returns the number of elements in <A>tcc</A>.
#! @Description
#! This is calculated using the orbit-stabiliser theorem.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "Size", IsTwistedConjugacyClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle StabiliserOfExternalSet
#! @Returns the stabiliser of <C>Representative(<A>tcc</A>)</C> under the
#! action <C>FunctionAction(<A>tcc</A>)</C>.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "StabiliserOfExternalSet", IsTwistedConjugacyClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle List
#! @Returns a list containing the elements of <A>tcc</A>.
#! @Description
#! If <A>tcc</A> is infinite, this will run forever. It is recommended to first
#! test the finiteness of <A>tcc</A> using
#! <Ref Attr="Size" Label="of a twisted conjugacy class" Style="Number"/>.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareGlobalFunction( "List" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Random
#! @Returns a random element in <A>tcc</A>.
#! @Label in a twisted conjugacy class
#! @Arguments tcc
DeclareOperation( "Random", [ IsTwistedConjugacyClassGroupRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \=
#! @Returns <K>true</K> if <A>tcc1</A> is equal to <A>tcc2</A>, otherwise
#! <K>false</K>.
#! @Label for twisted conjugacy classes
#! @Arguments tcc1, tcc2
DeclareOperation( "\=", [ IsTwistedConjugacyClassGroupRep, IsTwistedConjugacyClassGroupRep ] );
#! @EndGroup

#! @Section tcc_calc

#! @BeginGroup
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
DeclareGlobalFunction( "ReidemeisterClasses" );
#! @EndGroup

#! @BeginGroup
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
DeclareGlobalFunction( "RepresentativesReidemeisterClasses" );
#! @EndGroup

#! @BeginExample
tcc := TwistedConjugacyClass( phi, psi, g1 );
#! (4,6,5)^G
Representative( tcc );
#! (4,6,5)
ActingDomain( tcc ) = H;
#! true
FunctionAction( tcc )( g1, h );
#! (1,6,4,2)(3,5)
List( tcc );
#! [ (4,6,5), (1,6,4,2)(3,5) ]
Size( tcc );
#! 2
StabiliserOfExternalSet( tcc );
#! Group([ (1,2,3,4,5), (1,3,4,5,2) ])
TwistedConjugacyClasses( phi, psi ){[1..7]};
#! [ ()^G, (4,5,6)^G, (4,6,5)^G, (3,4)(5,6)^G, (3,4,5)^G, (3,4,6)^G, (3,5,4)^G ]
RepresentativesTwistedConjugacyClasses( phi, psi ){[1..7]};
#! [ (), (4,5,6), (4,6,5), (3,4)(5,6), (3,4,5), (3,4,6), (3,5,4) ]
NrTwistedConjugacyClasses( phi, psi );
#! 184
#! @EndExample
