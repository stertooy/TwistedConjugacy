#####
#
# CHAPTER 1
#
#####

#! @Chapter Preface
#! @ChapterLabel preface
#! @ChapterTitle Preface

#! Let $G, H$ be groups and $\varphi,\psi\colon H \to G$ group homomorphisms. Then the pair $(\varphi,\psi)$ induces a (right) group action on $G$ given by
#! $$G \times H \to G\colon (g,h) \mapsto g \cdot h = \psi(h)^{-1} g\varphi(h).$$
#! This group action is called **$(\varphi,\psi)$-twisted conjugation**, and induces an equivalence relation $\sim_{\varphi,\psi}$ on $G$:
#! $$g_1 \sim_{\varphi,\psi} g_2 \iff \exists h \in H: g_1 \cdot h = g2.$$
#! The equivalence classes (i.e. the orbits of the action) are called **Reidemeister classes** and the number of Reidemeister classes is called the **Reidemeister number** $R(\varphi,\psi)$ of the pair $(\varphi,\psi)$.
#! The stabiliser of the identity $1_G$ for this action is the **coincidence group** $\operatorname{Coin}(\varphi, \psi )$, i.e. the subgroup of $H$ given by
#! $$\operatorname{Coin}(\varphi,\psi) := \{\, h \in H \mid \varphi(h) = \psi(h) \,\}.$$

#! <P/>

#! The <B>TwistedConjugacy</B> package provides methods to calculate Reidemeister classes, Reidemeister numbers and coincidence groups of pairs of group homomorphisms.
#! These methods are implemented for finite groups and polycyclically presented groups. If $H$ and $G$ are both infinite polycyclically presented groups, then
#! some methods in this package are only guaranteed to produce a result if either $G = H$ or $G$ is nilpotent-by-finite.
#! Otherwise, these methods may potentially throw an error: "<C>Error, no method found!</C>"

#! <P/>

#! In the past, bugs in GAP or the Polycyclic package have caused functions from this package to produce errors and even wrong results. 
#! One can toggle TwistedConjugacy's Safe Mode, which will cause certain functions to verify the correctness of their output.
#! This should make results more (but not completely!) reliable, at the cost of some performance.
#!

#! @BeginExample
ToggleSafeMode@TwistedConjugacy();
#! TwistedConjugacy's Safe Mode is now on.
ToggleSafeMode@TwistedConjugacy();
#! TwistedConjugacy's Safe Mode is now off.
#! @EndExample

#####
#
# CHAPTER 2
#
#####

#! @Chapter Twisted Conjugacy
#! @ChapterLabel twicon
#! @ChapterTitle Twisted Conjugacy


###
# SECTION 1
###

#! @Section Twisted Conjugation Action
#! Let $G, H$ be groups and $\varphi,\psi\colon H \to G$ group homomorphisms. Then the pair $(\varphi,\psi)$ induces a (right) group action on $G$ given by
#! $$G \times H \to G\colon (g,h) \mapsto g \cdot h := \psi(h)^{-1} g\varphi(h).$$
#! This group action is called **$(\varphi,\psi)$-twisted conjugation**, and induces an equivalence relation on the group $G$. We say that $g_1, g_2 \in G$ are $(\varphi,\psi)$-twisted conjugate, denoted by $g_1 \sim_{\varphi,\psi} g_2$, if and only if there exists some element $h \in H$ such that $g_1 \cdot h = g_2$, or equivalently $g_1 = \psi(h) g_2 \varphi(h)^{-1}$.
#! <P/>If $\varphi\colon G \to G$ is an endomorphism of a group $G$, then by **$\varphi$-twisted conjugacy** we mean $(\varphi,\operatorname{id}_G)$-twisted conjugacy. Most functions in this package will allow you to input a single endomorphism instead of a pair of homomorphisms. The "missing" endomorphism will automatically be assumed to be the identity mapping. Similarly, if a single group element is given instead of two, the second will be assumed to be the identity.

#! @BeginGroup TwistedConjugationGroup
#! @Description
#! Implements the twisted conjugation (right) group action induced by the pair of homomorphisms ( <A>hom1</A>, <A>hom2</A> ) as a function.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "TwistedConjugation" );
#! @EndGroup

#! @BeginGroup IsTwistedConjugateGroup
#! @Description
#! Tests whether the elements <A>g1</A> and <A>g2</A> are twisted conjugate under the twisted conjugacy action of the pair of homomorphisms ( <A>hom1</A>, <A>hom2</A> ).
#! <P />
#! This function relies on the output of <C>RepresentativeTwistedConjugation</C>.
#! @Arguments hom1[, hom2], g1[, g2]

DeclareGlobalFunction( "IsTwistedConjugate" );
#! @EndGroup

#! @BeginGroup RepresentativeTwistedConjugationGroup
#! @Description
#! Computes an element that maps <A>g1</A> to <A>g2</A> under the twisted conjugacy action of the pair of homomorphisms ( <A>hom1</A>, <A>hom2</A> ) or returns <K>fail</K> if no such element exists.
#! <P />
#! If $G$ is abelian, this function relies on (a generalisation of) <Cite Key='dt21-a' Where='Alg. 4'/>.
#! If $H$ is finite, it relies on a stabiliser-orbit algorithm.
#! Otherwise, it relies on a mixture of the algorithms described in <Cite Key='roma16-a' Where='Thm. 3'/>, <Cite Key='bkl20-a' Where='Sec. 5.4'/>, <Cite Key='roma21-a' Where='Sec. 7'/> and <Cite Key='dt21-a' Where='Alg. 6'/>.
#! @Arguments hom1[, hom2], g1[, g2]
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );
#! @EndGroup

#! @BeginExample
G := AlternatingGroup( 6 );;
H := SymmetricGroup( 5 );;
phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
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


###
# SECTION 2
###

#! @Section Reidemeister Classes
#! The equivalence classes of the equivalence relation $\sim_{\varphi,\psi}$ are called the **Reidemeister classes of $(\varphi,\psi)$** or the **$(\varphi,\psi)$-twisted conjugacy classes**. We denote the Reidemeister class of $g \in G$ by $[g]_{\varphi,\psi}$. The number of Reidemeister classes is called the Reidemeister number $R(\varphi,\psi)$ and is always a positive integer or infinity.

#! @BeginGroup ReidemeisterClassGroup
#! @Description
#! If <A>hom1</A> and <A>hom2</A> are group homomorphisms from  a group H to a group G, this method creates the Reidemeister class of the pair (<A>hom1</A>, <A>hom2</A>) with representative <A>g</A>. The following attributes and operations are available:
#! * <C>Representative</C>, which returns <A>g</A>,
#! * <C>GroupHomomorphismsOfReidemeisterClass</C>, which returns the list [ <A>hom1</A>, <A>hom2</A> ],
#! * <C>ActingDomain</C>, which returns the group H,
#! * <C>FunctionAction</C>, which returns the twisted conjugacy action on G,
#! * <C>Random</C>, which returns a random element belonging to the Reidemeister class,
#! * <C>\in</C>, which can be used to test if an element belongs to the Reidemeister class,
#! * <C>List</C>, which lists all elements in the Reidemeister class if there are finitely many, otherwise returns <K>fail</K>,
#! * <C>Size</C>, which gives the number of elements in the Reidemeister class,
#! * <C>StabiliserOfExternalSet</C>, which gives the stabiliser of the Reidemeister class under the twisted conjugacy action.
#!
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "ReidemeisterClass" );
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "TwistedConjugacyClass" );
#! @EndGroup

#! @BeginGroup ReidemeisterClassesGroup
#! @Description
#! Returns a list containing the Reidemeister classes of ( <A>hom1</A>, <A>hom2</A> ) if the Reidemeister number $R( <A>hom1</A>, <A>hom2</A> )$ is finite, or returns <K>fail</K> otherwise. It is guaranteed that the Reidemeister class of the identity is in the first position.
#! <P />
#! If $G$ is abelian, this function relies on (a generalisation of) <Cite Key='dt21-a' Where='Alg. 5'/>.
#! If $G$ and $H$ are finite and $G$ is not abelian, it relies on an orbit-stabiliser algorithm.
#! Otherwise, it relies on (variants of) <Cite Key='dt21-a' Where='Alg. 7'/>.
#! <P/>
#! This function is only guaranteed to produce a result if either $G = H$ or $G$ is nilpotent-by-finite.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "ReidemeisterClasses" );
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "TwistedConjugacyClasses" );
#! @EndGroup

#! @BeginGroup RepresentativesReidemeisterClassesGroup
#! @Description
#! Returns a list containing representatives of the Reidemeister classes of ( <A>hom1</A>, <A>hom2</A> ) if the Reidemeister number $R( <A>hom1</A>, <A>hom2</A> )$ is finite, or returns <K>fail</K> otherwise. It is guaranteed that the identity is in the first position.
#! <P />
#! The same remarks as for <C>ReidemeisterClasses</C> are valid here.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "RepresentativesReidemeisterClasses" );
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "RepresentativesTwistedConjugacyClasses" );
#! @EndGroup

#! @BeginGroup ReidemeisterNumberGroup
#! @Description
#! Returns the Reidemeister number of ( <A>hom1</A>, <A>hom2</A> ), i.e. the number of Reidemeister classes.
#! <P />
#! If $G$ is abelian, this function relies on (a generalisation of) <Cite Key='jian83-a' Where='Thm. 2.5'/>.
#! If $G = H$, $G$ is finite non-abelian and $\psi = \operatorname{id}_G$, it relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! Otherwise, it uses the output of <C>ReidemeisterClasses</C>.
#! <P />
#! This function is only guaranteed to produce a result if either $G = H$ or $G$ is nilpotent-by-finite.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "ReidemeisterNumber" );
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "NrTwistedConjugacyClasses" );
#! @EndGroup

#! @BeginExample
tcc := ReidemeisterClass( phi, psi, g1 );
#! (4,6,5)^G
Representative( tcc );
#! (4,6,5)
GroupHomomorphismsOfReidemeisterClass( tcc );
#! [ [ (1,2)(3,5,4), (2,3)(4,5) ] -> [ (1,2)(3,4), () ],
#! [ (1,2)(3,5,4), (2,3)(4,5) ] -> [ (1,4)(3,6), () ] ]
ActingDomain( tcc ) = H;
#! true
FunctionAction( tcc )( g1, h );
#! (1,6,4,2)(3,5)
Random( tcc ) in tcc;
#! true
List( tcc );
#! [ (4,6,5), (1,6,4,2)(3,5) ]
Size( tcc );
#! 2
StabiliserOfExternalSet( tcc );
#! Group([ (1,2,3,4,5), (1,3,4,5,2) ])
ReidemeisterClasses( phi, psi ){[1..7]};
#! [ ()^G, (4,5,6)^G, (4,6,5)^G, (3,4)(5,6)^G, (3,4,5)^G, (3,4,6)^G, (3,5,4)^G ]
RepresentativesReidemeisterClasses( phi, psi ){[1..7]};
#! [ (), (4,5,6), (4,6,5), (3,4)(5,6), (3,4,5), (3,4,6), (3,5,4) ]
NrTwistedConjugacyClasses( phi, psi );
#! 184
#! @EndExample


###
# SECTION 3
###

#! @Section Reidemeister Spectra
#! The set of all Reidemeister numbers of automorphisms is called the **Reidemeister spectrum** and is denoted by $\operatorname{Spec}_R(G)$, i.e.
#! $$\operatorname{Spec}_R(G) := \{\, R(\varphi) \mid \varphi \in \operatorname{Aut}(G) \,\}.$$
#! The set of all Reidemeister numbers of endomorphisms is called the **extended Reidemeister spectrum** and is denoted by $\operatorname{ESpec}_R(G)$, i.e.
#! $$\operatorname{ESpec}_R(G) := \{\, R(\varphi) \mid \varphi \in \operatorname{End}(G) \,\}.$$
#! The set of all Reidemeister numbers of pairs of homomorphisms from a group $H$ to a group $G$ is called the **coincidence Reidemeister spectrum** of $H$ and $G$ and is denoted by $\operatorname{CSpec}_R(H,G)$, i.e.
#! $$\operatorname{CSpec}_R(H,G) := \{\, R(\varphi, \psi) \mid \varphi,\psi \in \operatorname{Hom}(H,G) \,\}.$$
#! If <A>H</A> = <A>G</A> this is also denoted by $\operatorname{CSpec}_R(G)$.
#! The set of all Reidemeister numbers of pairs of homomorphisms from every group $H$ to a group $G$ is called the **full Reidemeister spectrum** and is denoted by $\operatorname{FSpec}_R(G)$, i.e.
#! $$\operatorname{FSpec}_R(G) := \bigcup_{H} \operatorname{CSpec}_R(H,G).$$

#! <P/>

#! Please note that the functions below are only implemented for finite groups.

#! @Description
#! Returns the Reidemeister spectrum of <A>G</A>.
#! <P />

#! If $G$ is abelian, this function relies on the results from <Cite Key='send23-a'/>.

#! @Arguments G
DeclareGlobalFunction( "ReidemeisterSpectrum" );

#! @Description
#! Returns the extended Reidemeister spectrum of <A>G</A>.
#! @Arguments G
DeclareGlobalFunction( "ExtendedReidemeisterSpectrum" );

#! @Description
#! Returns the coincidence Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @Arguments [H, ]G
DeclareGlobalFunction( "CoincidenceReidemeisterSpectrum" );

#! @Description
#! Returns the full Reidemeister spectrum of <A>G</A>.
#! @Arguments G
DeclareGlobalFunction( "FullReidemeisterSpectrum" );

#! @BeginExample
Q := QuaternionGroup( 8 );;
D := DihedralGroup( 8 );;
ReidemeisterSpectrum( Q );
#! [ 2, 3, 5 ]
ExtendedReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 5 ]
CoincidenceReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 4, 5, 8 ]
CoincidenceReidemeisterSpectrum( D, Q );
#! [ 4, 8 ]
CoincidenceReidemeisterSpectrum( Q, D );
#! [ 2, 3, 4, 6, 8 ]
FullReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 4, 5, 6, 8 ]
#! @EndExample


###
# SECTION 4
###

#! @Section Reidemeister Zeta Functions
#! Let $\varphi,\psi\colon G \to G$ be endomorphisms such that $R(\varphi^n,\psi^n) &lt; \infty$ for all $n \in \mathbb{N}$. Then the **Reidemeister zeta function** $Z_{\varphi,\psi}(s)$ of the pair $(\varphi,\psi)$ is defined as
#! $$Z_{\varphi,\psi}(s) := \exp \sum_{n=1}^\infty \frac{R(\varphi^n,\psi^n)}{n} s^n.$$
#! <P/>
#! Please note that the functions below are only implemented for endomorphisms of finite groups.

#! @BeginGroup ReidemeisterZetaCoefficientsGroup
#! @Description
#! For a finite group, the sequence of Reidemeister numbers of the iterates of <A>endo1</A> and <A>endo2</A>, i.e. the sequence $R(<A>endo1</A>,<A>endo2</A>)$, $R(<A>endo1</A>^2,<A>endo2</A>^2)$, ..., is eventually periodic, i.e. there exist a periodic sequence $(P_n)_{n \in \mathbb{N}}$ and an eventually zero sequence $(Q_n)_{n \in \mathbb{N}}$ such that
#! $$\forall n \in \mathbb{N}: R(\varphi^n,\psi^n) = P_n + Q_n.$$
#! This function returns a list containing two sublists: the first sublist contains one period of the sequence $(P_n)_{n \in \mathbb{N}}$, the second sublist contains $(Q_n)_{n \in \mathbb{N}}$ up to the part where it becomes the constant zero sequence.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterZetaCoefficients" );
#! @EndGroup

#! @BeginGroup IsRationalReidemeisterZetaGroup
#! @Description
#! Returns <K>true</K> if the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A> is rational, and <K>false</K> otherwise.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IsRationalReidemeisterZeta" );
#! @EndGroup

#! @BeginGroup ReidemeisterZetaGroup
#! @Description
#! Returns the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A> if it is rational, and <K>fail</K> otherwise.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterZeta" );
#! @EndGroup

#! @BeginGroup PrintReidemeisterZetaGroup
#! @Description
#! Returns a string describing the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A>. This is often more readable than evaluating <C>ReidemeisterZeta</C> in an indeterminate, and does not require rationality.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "PrintReidemeisterZeta" );
#! @EndGroup

#! @BeginExample
khi := GroupHomomorphismByImages( G, G, [ (1,2,3,4,5), (4,5,6) ],
 [ (1,2,6,3,5), (1,4,5) ] );;
ReidemeisterZetaCoefficients( khi );
#! [ [ 7 ], [  ] ]
IsRationalReidemeisterZeta( khi );
#! true
ReidemeisterZeta( khi );
#! function( s ) ... end
s := Indeterminate( Rationals, "s" );;
ReidemeisterZeta( khi )(s);
#! (1)/(-s^7+7*s^6-21*s^5+35*s^4-35*s^3+21*s^2-7*s+1)
PrintReidemeisterZeta( khi );
#! "(1-s)^(-7)"
#! @EndExample



#####
#
# CHAPTER 3
#
#####

#! @Chapter Multiple Twisted Conjugacy Problem
#! @ChapterLabel mult
#! @ChapterTitle Multiple Twisted Conjugacy Problem


###
# SECTION 1
###

#! @Section The Multiple Twisted Conjugacy Problem
#! Let $H$ and $G_1, \ldots, G_n$ be groups. For each $i \in \{1,\ldots,n\}$, let $g_i,g_i' \in G_i$ and let $\varphi_i,\psi_i\colon H \to G_i$ be group homomorphisms.
#! The multiple twisted conjugacy problem is the problem of finding some $h \in H$ such that $g_i = \psi_i(h)g_i'\varphi_i(h)^{-1}$ for all $i \in \{1,\ldots,n\}$.

#! @Description
#! Verifies whether the multiple twisted conjugacy problem for the given homomorphisms and elements has a solution.
#! @Arguments hom1List[, hom2List], g1List[, g2List]
DeclareGlobalFunction( "IsTwistedConjugateMultiple" );

#! @Description
#! Computes a solution to the multiple twisted conjugacy problem for the given homomorphisms and elements, or returns <K>fail</K> if no solution exists.
#! @Arguments hom1List[, hom2List], g1List[, g2List]
DeclareGlobalFunction( "RepresentativeTwistedConjugationMultiple" );

#! @BeginExample
H := SymmetricGroup( 5 );;
G := AlternatingGroup( 6 );;
tau := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,3)(4,6), () ] );;
phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,6), () ] );;
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
khi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
IsTwistedConjugateMultiple( [ tau, phi ], [ psi, khi ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! true
RepresentativeTwistedConjugationMultiple( [ tau, phi ], [ psi, khi ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! (1,2)
#! @EndExample



#####
#
# CHAPTER 4
#
#####

#! @Chapter Homomorphisms
#! @ChapterLabel homs
#! @ChapterTitle Homomorphisms


###
# SECTION 1
###

#! @Section Representatives of homomorphisms between groups

#! Please note that the functions below are only implemented for finite groups.

#! @Description
#! Let <A>G</A> be a group. This command returns a list of the automorphisms of <A>G</A> up to composition with inner automorphisms.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesAutomorphismClasses" );

#! @Description
#! Let <A>G</A> be a group. This command returns a list of the endomorphisms of <A>G</A> up to composition with inner automorphisms.
#! This does the same as calling <C>AllHomomorphismClasses(<A>G</A>,<A>G</A>)</C>, but should be faster for abelian and non-2-generated groups.
#! For 2-generated groups, this function takes its source code from <C>AllHomomorphismClasses</C>.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesEndomorphismClasses" );

#! @Description
#! Let <A>G</A> and <A>H</A> be groups. This command returns a list of the homomorphisms from <A>H</A> to <A>G</A>, up to composition with inner automorphisms of <A>G</A>.
#! This does the same as calling <C>AllHomomorphismClasses(<A>H</A>,<A>G</A>)</C>, but should be faster for abelian and non-2-generated groups.
#! For 2-generated groups, this function takes its source code from <C>AllHomomorphismClasses</C>.
#! @Arguments H, G
DeclareGlobalFunction( "RepresentativesHomomorphismClasses" );

#! @BeginExample
G := AlternatingGroup( 6 );;
Auts := RepresentativesAutomorphismClasses( G );;
Size( Auts );
#! 4
ForAll( Auts, IsGroupHomomorphism and IsEndoMapping and IsBijective );
#! true
Ends := RepresentativesEndomorphismClasses( G );;
Size( Ends );
#! 5
ForAll( Ends, IsGroupHomomorphism and IsEndoMapping );
#! true
H := SymmetricGroup( 5 );;
Homs := RepresentativesHomomorphismClasses( H, G );;
Size( Homs );
#! 2
ForAll( Homs, IsGroupHomomorphism );
#! true
#! @EndExample


###
# SECTION 2
###

#! @Section Coincidence and Fixed Point Groups

#! @Description
#! Let <A>endo</A> be an endomorphism of a group G. This command returns the subgroup of G consisting of the elements fixed under the endomorphism <A>endo</A>.
#! <P />
#! This function does the same as <C>CoincidenceGroup</C>(<A>endo</A>,$\operatorname{id}_G$).
#! @Arguments endo
DeclareGlobalFunction( "FixedPointGroup" );

#! @Description
#! Let <A>hom1</A>, <A>hom2</A>, ... be group homomorphisms from a group H to a group G. This command returns the subgroup of H consisting of the elements h for which h^<A>hom1</A> = h^<A>hom2</A> = ...
#! <P />
#! For infinite non-abelian groups, this function relies on a mixture of the algorithms described in <Cite Key='roma16-a' Where='Thm. 2'/>, <Cite Key='bkl20-a' Where='Sec. 5.4'/> and <Cite Key='roma21-a' Where='Sec. 7'/>.
#! @Arguments hom1, hom2[, ...]
DeclareGlobalFunction( "CoincidenceGroup" );

#! @BeginExample
phi := GroupHomomorphismByImages( G, G, [ (1,2,3,4,5), (4,5,6) ],
 [ (1,2,6,3,5), (1,4,5) ] );;
FixedPointGroup( phi );
#! Group([ (1,2,6,4,3) ])
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
khi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
CoincidenceGroup( psi, khi );
#! Group([ (1,2,3,4,5), (1,3,4,5,2) ])
#! @EndExample


###
# SECTION 3
###

#! @Section Induced and restricted group homomorphisms

#! @Description
#! Let <A>hom</A> be a group homomorphism from a group H to a group G, let <A>epi1</A> be an epimorphism from H to a group Q and let <A>epi2</A> be an epimorphism from G to a group P such that the kernel of <A>epi1</A> is mapped into the kernel of <A>epi2</A> by <A>hom</A>. This command returns the homomorphism from Q to P induced by <A>hom</A> via <A>epi1</A> and <A>epi2</A>, that is, the homomorphism from Q to P which maps h<C>^<A>epi1</A></C> to <C>(</C>h<C>^<A>hom</A>)^<A>epi2</A></C>, for any element h of H. This generalises <C>InducedAutomorphism</C> to homomorphisms.
#! @Arguments epi1, epi2, hom
DeclareGlobalFunction( "InducedHomomorphism" );

#! @Description
#! Let <A>hom</A> be a group homomorphism from a group H to a group G, and let <A>N</A> be subgroup of H such that its image under <A>hom</A> is a subgroup of <A>M</A>. This command returns the homomorphism from N to M induced by <A>hom</A>. This is similar to <C>RestrictedMapping</C>, but the range is explicitly set to <A>M</A>.
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
