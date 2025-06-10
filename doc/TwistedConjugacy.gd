#####
#
# TITLEPAGE
#
#####

#! @Abstract
#! The &TwistedConjugacy; package provides methods for solving the twisted
#! conjugacy problem (including the "search" and "multiple" variants) and for
#! computing Reidemeister classes, numbers, spectra, and zeta functions. It
#! also includes utility functions for working with (double) cosets, group
#! homomorphisms, and group derivations.
#! <P/>
#! These methods are primarily designed for use with finite groups and with
#! polycyclically presented groups (finite or infinite).

#! @Copyright
#! &copyright; 2020&ndash;&RELEASEYEAR; Sam Tertooy
#! <P/>
#! The &TwistedConjugacy; package is free software, it may be redistributed
#! and/or modified under the terms and conditions of the
#! <URL Text="GNU Public License Version 2">
#! https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html</URL> or
#! (at your option) any later version.

#! @Acknowledgements
#! This documentation was created using the &GAPDoc; and &AutoDoc; packages.



#####
#
# CHAPTER 1
#
#####


#! @Chapter thepkg
#! @ChapterTitle The &TwistedConjugacy; Package

#! @Section Introduction
#! This is the manual for the &GAP; 4 package &TwistedConjugacy; version
#! &VERSION;.


# Note to self: check https://docs.gap-system.org/pkg/agt/doc/chap1_mj.html
#  and https://docs.gap-system.org/pkg/anupq/doc/chap3_mj.html
# Chapter 1: Introduction
# Chapter 2: Mathematical Background

# TODOS:
# - Try use variables in this documentation (dependencies, version, ...)
# - Also distribute .zip?
# - Installation instructions
# ----- For Linux/WSL + For Cygwin + Via PackageManager
# - Update README
# - Use manual cross-references

#! @Section Installation
#! You can download &TwistedConjugacy; as a .tar.gz-archive
#! <URL Text='here'>&ARCHIVEURL;.tar.gz</URL>. After extracting, you should
#! place it in a suitable <F>pkg</F> folder. For example, on a Debian-based
#! Linux distribution (e.g. Ubuntu, Mint), you can place it in
#! <F>&dollar;HOME/.gap/pkg</F> (recommended) to make it available for just
#! yourself, or in the &GAP; installation directory (<F>gap-X.Y.Z/pkg</F>) to
#! make it available for all users.
#! You can use the following command to do this efficiently:
#! <Listing Type="Command">
#! wget -qO- https://[...].tar.gz | tar xzf - --one-top-level=&dollar;HOME/.gap/pkg
#!</Listing>
#! If &PackageManager; is installed and loaded, you can install
#! &TwistedConjugacy; from within a GAP session:
#! @BeginLog
InstallPackage( "https://[...].tar.gz" );
#! true
#! @EndLog
#! See also
#! <Ref Sect="Installing a GAP Package" BookName="ref" Text="the relevant section"/>
#! in the &GAP; manual.
# <Ref Func="ReadPackage" BookName="ref"/>.
# <Ref Func="TwistedConjugation" Style="Number"/>.

#! @Section Loading
#! Load stuff
#! @BeginLog
LoadPackage( "TwistedConjugacy" );
#! ... package banner(s) ...
#! true
#! @EndLog
#! See also
#! <Ref Sect="Loading a GAP Package" BookName="ref" Text="the relevant section"/>
#! in the &GAP; manual.

#! @Section Citing
#! Cite plsthx (Add BibTeX and BibLaTeX?)

#! @Section Support
#! To the rescue! (Issue tracker?)
#! If you encounter any problems, please submit to them to the
#! <URL Text='issue tracker'>&ISSUEURL;</URL>.
#! If you have any questions on the usage or functionality, you may contact
#! me via email.

#! @Chapter Mathematical Background


#! Let $G$ and $H$ be groups and let $\varphi$ and $\psi$ be group
#! homomorphisms from $H$ to $G$. The pair $(\varphi,\psi)$ induces a
#! (right) group action of $H$ on $G$ given by the map $$G \times H \to G
#! \colon (g,h) \mapsto \varphi(h)^{-1} g\,\psi(h).$$
#! This group action is called **$(\varphi,\psi)$-twisted conjugation**. The
#! orbits are called **Reidemeister classes** or **twisted conjugacy classes**,
#! and the number of Reidemeister classes is called the **Reidemeister number**
#! $R(\varphi,\psi)$ of the pair $(\varphi,\psi)$.

#! <P/>

#! Bugs in &GAP;, in the &TwistedConjugacy; package, or in any other package
#! used directly or indirectly, may cause functions provided by
#! &TwistedConjugacy; to produce errors &ndash; or worse, incorrect results.
#! To help detect such issues, you can enable internal checks by setting the
#! variable <C>ASSERT&#64;TwistedConjugacy</C> to <K>true</K>. Note that this
#! will come at the cost of reduced performance.
#! <P/>
#! For additional safety, you can enable &GAP;'s built-in assertion features
#! by calling <C>SetAssertionLevel( <A>lev</A> )</C> (we recommend setting
#! <A>lev</A> to <C>2</C>) and, when working with PcpGroups, settings the
#! variables <C>CHECK_CENT&#64;Polycyclic</C>, <C>CHECK_IGS&#64;Polycyclic</C>
#! and <C>CHECK_INTSTAB&#64;Polycyclic</C> to <K>true</K>.



#####
#
# CHAPTER 2
#
#####

#! @Chapter Twisted Conjugacy

###
# SECTION 1
###

#! @Section Twisted Conjugation Action
#! Let $G, H$ be groups and $\varphi,\psi\colon H \to G$ group homomorphisms. Then the pair $(\varphi,\psi)$ induces a (right) group action on $G$ given by
#! $$G \times H \to G\colon (g,h) \mapsto \varphi(h)^{-1} g\,\psi(h).$$
#! This group action is called **$(\varphi,\psi)$-twisted conjugation**, and induces an equivalence relation on the group $G$. We say that $g_1, g_2 \in G$ are $(\varphi,\psi)$-twisted conjugate, denoted by $g_1 \sim_{\varphi,\psi} g_2$, if and only if there exists some element $h \in H$ such that $\varphi(h)^{-1}g_1\psi(h) = g_2$.
#! <P/>If $\varphi\colon G \to G$ is an endomorphism of a group $G$, then by **$\varphi$-twisted conjugacy** we mean $(\varphi,\operatorname{id}_G)$-twisted conjugacy. Most functions in this package will allow you to input a single endomorphism instead of a pair of homomorphisms. The "missing" endomorphism will automatically be assumed to be the identity mapping. Similarly, if a single group element is given instead of two, the second will be assumed to be the identity.

#! @Arguments hom1[, hom2]
#! @Returns a function that maps the pair <C>(g,h)</C> to <A>hom1</A><C>(h)⁻¹</C> <C>g</C> <A>hom2</A><C>(h)</C>.
DeclareGlobalFunction( "TwistedConjugation" );


#! @Section The Twisted Conjugacy (Search) Problem

#! @Arguments hom1[, hom2], g1[, g2]
#! @Returns <K>true</K> if <A>g1</A> and <A>g2</A> are <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugate, otherwise <K>false</K>.
#! @Description
#! This function relies on the output of <C>RepresentativeTwistedConjugation</C>.
DeclareGlobalFunction( "IsTwistedConjugate" );

#! @Arguments hom1[, hom2], g1[, g2]
#! @Returns an element that maps <A>g1</A> to <A>g2</A> under the twisted conjugacy action of the pair <C>(<A>hom1</A>,<A>hom2</A>)</C>, or <K>fail</K> if no such element exists.
#! @Description
#! If <C>H</C> is finite, it relies on a stabiliser-orbit algorithm.
#! Otherwise, it relies on a mixture of the algorithms described in <Cite Key='roma16-a' Where='Thm. 3'/>, <Cite Key='bkl20-a' Where='Sec. 5.4'/>, <Cite Key='roma21-a' Where='Sec. 7'/> and <Cite Key='dt21-a'/>.
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );

#! @BeginExample
G := AlternatingGroup( 6 );;
H := SymmetricGroup( 5 );;
phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
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
# SECTION 1
###

#! @Section The Multiple Twisted Conjugacy (Search) Problem
#! Let $H$ and $G_1, \ldots, G_n$ be groups. For each $i \in \{1,\ldots,n\}$, let $g_i,g_i' \in G_i$ and let $\varphi_i,\psi_i\colon H \to G_i$ be group homomorphisms.
#! The multiple twisted conjugacy problem is the problem of finding some $h \in H$ such that $\varphi_i(h)^{-1}g_i\psi_i(h) = g_i'$ for all $i \in \{1,\ldots,n\}$.

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
phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
tau := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,6), () ] );;
khi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,3)(4,6), () ] );;
IsTwistedConjugateMultiple( [ phi, psi ], [ khi, tau ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! true
RepresentativeTwistedConjugationMultiple( [ phi, psi ], [ khi, tau ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! (1,2)
#! @EndExample



#! @Chapter Reidemeister Classes
#! @ChapterLabel reidclass
#! @ChapterTitle Reidemeister Classes

#! The equivalence classes of the equivalence relation $\sim_{\varphi,\psi}$ are called the **Reidemeister classes of $(\varphi,\psi)$** or the **$(\varphi,\psi)$-twisted conjugacy classes**. We denote the Reidemeister class of $g \in G$ by $[g]_{\varphi,\psi}$. The number of Reidemeister classes is called the Reidemeister number $R(\varphi,\psi)$ and is always a positive integer or infinity.

#! @Section Creating Reidemeister Classes

#! @BeginGroup TwistedConjugacyClassGroup
#! @Arguments hom1[, hom2], g
#! @Returns the <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy class of <A>g</A>.
DeclareGlobalFunction( "ReidemeisterClass" );
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "TwistedConjugacyClass" );
#! @EndGroup

#! @Section Operations on Reidemeister Classes


#! @Group RepresentativeTCC
#! @GroupTitle Representative
#! @Label for twisted conjugacy classes
DeclareAttribute( "Representative", IsReidemeisterClassGroupRep );

#! @Group ActingDomainTCC
#! @GroupTitle ActingDomain
#! @Label for twisted conjugacy classes
DeclareAttribute( "ActingDomain", IsReidemeisterClassGroupRep );

#! @Group FunctionActionTCC
#! @GroupTitle FunctionAction
#! @Label for twisted conjugacy classes
DeclareAttribute( "FunctionAction", IsReidemeisterClassGroupRep );

#! @Group InTCC
#! @GroupTitle in
#! @Label for twisted conjugacy classes
DeclareOperation( "\in", [ IsObject, IsReidemeisterClassGroupRep ] );

#! @Group SizeTCC
#! @GroupTitle Size
#! @Label for twisted conjugacy classes
DeclareAttribute( "Size", IsReidemeisterClassGroupRep );

#! @Group StabiliserOfExternalSetTCC
#! @GroupTitle StabiliserOfExternalSet
#! @Label for twisted conjugacy classes
DeclareAttribute( "StabiliserOfExternalSet", IsReidemeisterClassGroupRep );

#! TODO: mention that things like List, Size, Random should also work.


#! @Section Calculating Reidemeister Classes

#! @BeginGroup ReidemeisterClassesGroup
#! @Description
#! Returns a list containing the Reidemeister classes of ( <A>hom1</A>, <A>hom2</A> ) if the Reidemeister number $R( <A>hom1</A>, <A>hom2</A> )$ is finite, or returns <K>fail</K> otherwise. It is guaranteed that the Reidemeister class of the identity is in the first position.
#! <P />
#! If $G$ and $H$ are finite, it relies on an orbit-stabiliser algorithm.
#! Otherwise, it relies on the algorithms in <Cite Key='dt21-a'/> and <Cite Key='tert25-a'/>.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "ReidemeisterClasses" );
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "TwistedConjugacyClasses" );
#! @EndGroup

#! @BeginGroup RepresentativesReidemeisterClassesGroup
#! @Description
#! Returns a list containing representatives of the Reidemeister classes of ( <A>hom1</A>, <A>hom2</A> ) if the Reidemeister number $R( <A>hom1</A>, <A>hom2</A> )$ is finite, or returns <K>fail</K> otherwise. It is guaranteed that the identity is in the first position.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "RepresentativesReidemeisterClasses" );
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "RepresentativesTwistedConjugacyClasses" );
#! @EndGroup



#! @BeginExample
tcc := ReidemeisterClass( phi, psi, g1 );
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
ReidemeisterClasses( phi, psi ){[1..7]};
#! [ ()^G, (4,5,6)^G, (4,6,5)^G, (3,4)(5,6)^G, (3,4,5)^G, (3,4,6)^G, (3,5,4)^G ]
RepresentativesReidemeisterClasses( phi, psi ){[1..7]};
#! [ (), (4,5,6), (4,6,5), (3,4)(5,6), (3,4,5), (3,4,6), (3,5,4) ]
NrTwistedConjugacyClasses( phi, psi );
#! 184
#! @EndExample


#! @Chapter Reidemeister Numbers and Spectra
#! @ChapterLabel reidnrspec
#! @ChapterTitle Reidemeister Numbers and Spectra

#! @Section Reidemeister Numbers

#! @BeginGroup ReidemeisterNumberGroup
#! @Description
#! Returns the Reidemeister number of ( <A>hom1</A>, <A>hom2</A> ), i.e. the number of Reidemeister classes.
#! <P />
#! If $G$ is abelian, this function relies on (a generalisation of) <Cite Key='jian83-a' Where='Thm. 2.5'/>.
#! If $G = H$, $G$ is finite non-abelian and $\psi = \operatorname{id}_G$, it relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! Otherwise, it uses the output of <C>RepresentativesReidemeisterClasses</C>.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "ReidemeisterNumber" );
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "NrTwistedConjugacyClasses" );
#! @EndGroup

#! @Section Reidemeister Spectra
#! The set of all Reidemeister numbers of automorphisms is called the **Reidemeister spectrum** and is denoted by $\operatorname{Spec}_R(G)$, i.e.
#! $$\operatorname{Spec}_R(G) := \{\, R(\varphi) \mid \varphi \in \operatorname{Aut}(G) \,\}.$$
#! The set of all Reidemeister numbers of endomorphisms is called the **extended Reidemeister spectrum** and is denoted by $\operatorname{ESpec}_R(G)$, i.e.
#! $$\operatorname{ESpec}_R(G) := \{\, R(\varphi) \mid \varphi \in \operatorname{End}(G) \,\}.$$
#! The set of all Reidemeister numbers of pairs of homomorphisms from a group $H$ to a group $G$ is called the **coincidence Reidemeister spectrum** of $H$ and $G$ and is denoted by $\operatorname{CSpec}_R(H,G)$, i.e.
#! $$\operatorname{CSpec}_R(H,G) := \{\, R(\varphi, \psi) \mid \varphi,\psi \in \operatorname{Hom}(H,G) \,\}.$$
#! If <A>H</A> = <A>G</A> this is also denoted by $\operatorname{CSpec}_R(G)$.
#! The set of all Reidemeister numbers of pairs of homomorphisms from every group $H$ to a group $G$ is called the **total Reidemeister spectrum** and is denoted by $\operatorname{TSpec}_R(G)$, i.e.
#! $$\operatorname{TSpec}_R(G) := \bigcup_{H} \operatorname{CSpec}_R(H,G).$$

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
#! Returns the total Reidemeister spectrum of <A>G</A>.
#! @Arguments G
DeclareGlobalFunction( "TotalReidemeisterSpectrum" );

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
TotalReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 4, 5, 6, 8 ]
#! @EndExample


#! @Chapter Reidemeister Zeta Functions
#! @ChapterLabel reidzeta
#! @ChapterTitle Reidemeister Zeta Functions

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
# CHAPTER 4
#
#####

#! @Chapter Cosets
#! @ChapterLabel csts
#! @ChapterTitle Cosets in PcpGroups

#! Please note that the functions below are implemented only for PcpGroups.


###
# SECTION 1
###

#! @Section Right cosets

#! @BeginGroup IntersectionCosets
#! @Description
#! Calculates the intersection of the (right) cosets <A>C1</A>, <A>C2</A>, ... Alternatively, <A>list</A> may be a list of (right) cosets. This intersection is either a new coset, or an empty list.
#! @Arguments C1, C2, ...
#! @Label of right cosets
DeclareGlobalFunction( "Intersection" );
#! @Arguments list
#! @Label of a list of right cosets
DeclareGlobalFunction( "Intersection" );
#! @EndGroup

#! @BeginExample
G := ExamplesOfSomePcpGroups( 5 );;
H := Subgroup( G, [ G.1*G.2^-1*G.3^-1*G.4^-1, G.2^-1*G.3*G.4^-2 ] );;
K := Subgroup( G, [ G.1*G.3^-2*G.4^2, G.1*G.4^4 ] );;
x := G.1*G.3^-1;;
y := G.1*G.2^-1*G.3^-2*G.4^-1;;
z := G.1*G.2*G.3*G.4^2;;
Hx := RightCoset( H, x );;
Ky := RightCoset( K, y );;
Intersection( Hx, Ky );
#! RightCoset(<group with 2 generators>,<object>)
Kz := RightCoset( K, z );;
Intersection( Hx, Kz );
#! [  ]
#! @EndExample


###
# SECTION 2
###

#! @Section Double cosets

#! @Description
#! Given an element <A>g</A> of a PcpGroup and a double coset <A>D</A> of that same group, this function tests whether <A>g</A> is an element of <A>D</A>.
#! @Arguments g, D
#! @Label for an element and a double coset
DeclareOperation( "\in", [ IsPcpElement, IsDoubleCoset ] );

#! @Description
#! Given double cosets <A>C</A> and <A>D</A> of a PcpGroup, this function tests whether <A>C</A> and <A>D</A> are equal.
#! @Arguments C, D
#! @Label for double cosets
DeclareOperation( "=", [ IsDoubleCoset, IsDoubleCoset ] );

#! @Description
#! Given a PcpGroup <A>G</A> and two subgroups <A>H</A>, <A>K</A>, this function computes a duplicate-free list of all double cosets <A>H</A>$g$<A>K</A> for $g \in G$ if there are finitely many, or it returns <K>fail</K> otherwise.
#! @Arguments G, H, K
DeclareGlobalFunction( "DoubleCosets" );

#! @BeginExample
HxK := DoubleCoset( H, x, K );;
HyK := DoubleCoset( H, y, K );;
HzK := DoubleCoset( H, z, K );;
y in HxK;
#! true
z in HxK;
#! false
HxK = HyK;
#! true
HxK = HzK;
#! false
DCS := DoubleCosets( G, H, K );
#! [ DoubleCoset(<group with 2 generators>,<object>,<group with 2 generators>),
#!   DoubleCoset(<group with 2 generators>,<object>,<group with 2 generators>) ]
#! @EndExample



#####
#
# CHAPTER 5
#
#####

#! @Chapter Homomorphisms
#! @ChapterLabel homs
#! @ChapterTitle Group Homomorphisms


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



#####
#
# CHAPTER 6
#
#####

#! @Chapter Derivations
#! @ChapterLabel ders
#! @ChapterTitle Group Derivations


###
# SECTION 1
###

#! @Section Creating group derivations

#! The functions below only work for derivations between finite groups or between PcpGroups. 

#! @Description
#! <C>GroupDerivationByImages</C> works in the same vein as <C>GroupHomomorphismByImages</C>. The group <A>H</A> acts on the group <A>G</A> via <A>act</A>,
#! which must be a homomorphism from <A>H</A> into a group of automorphisms of <A>G</A>. This command then returns the group derivation defined by mapping the list
#! <A>gens</A> of generators of <A>H</A> to the list <A>imgs</A> of images in <A>G</A>.
#!
#! If omitted, the arguments <A>gens</A> and <A>imgs</A> default to the <C>GeneratorsOfGroup</C> value of <A>H</A> and <A>G</A> respectively.
#!
#! If <A>gens</A> does not generate <A>H</A> or the mapping of the generators does not extend to a group derivation then <K>fail</K> is returned.
#! This test can be expensive, so if one is certain that the given arguments produce a group derivation, the checks can be avoided by calling
#! <C>GroupDerivationByImagesNC</C> instead.
#! @Arguments H, G[[, gens], imgs], act
DeclareGlobalFunction( "GroupDerivationByImages" );

#! @Description
#! <C>GroupDerivationByImagesNC</C> does the same as <C>GroupDerivationByImages</C>, but does not check if the given map is indeed a group derivation.
#! @Arguments H, G[[, gens], imgs], act
DeclareGlobalFunction( "GroupDerivationByImagesNC" );

#! @Description
#! <C>GroupDerivationByFunction</C> works in the same vein as <C>GroupHomomorphismByFunction</C>. The group <A>H</A> acts on the group <A>G</A> via <A>act</A>,
#! which must be a homomorphism from <A>H</A> into a group of automorphisms of <A>G</A>. This command then returns the group derivation defined by mapping the
#! element <C>h</C> of <A>H</A> to the element <A>fun</A>( <C>h</C> ) of <A>G</A>, where <A>fun</A> is a <B>GAP</B> function.
#!
#! No test are performed to check whether the arguments really produce a group derivation.
#! @Arguments H, G, fun, act
DeclareGlobalFunction( "GroupDerivationByFunction" );

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


###
# SECTION 2
###

#! @Section Operations for Group Derivations

#! @Description
#! Returns <K>true</K> if the group derivation <A>der</A> is injective, and <K>false</K> otherwise.
#! @Arguments der
#! @Label for group derivations
DeclareProperty( "IsInjective", IsGroupDerivation );

#! @Description
#! Returns <K>true</K> if the group derivation <A>der</A> is surjective, and <K>false</K> otherwise.
#! @Arguments der
#! @Label for group derivations
DeclareProperty( "IsSurjective", IsGroupDerivation );

#! @Description
#! Calculates the set of elements that are mapped to the identity by <A>der</A>.
#! This will always be a subgroup of <C>Source</C>( <A>der</A> ).
#! @Arguments der
#! @Label of a group derivation
DeclareOperation( "Kernel", [ IsGroupDerivation ] );

#! @BeginGroup ImageGroup
#! @Description
#! Calculates the image of the group derivation <A>der</A>.
#! One can optionally give an element <A>elm</A> or a subgroup <A>sub</A> as a second argument,
#! in which case <C>Image</C> will calculate the image of this argument under <A>der</A>.
#! @Arguments der
DeclareGlobalFunction( "Image" );
#! @Arguments der, elm
#! @Label of an element under a group derivation
DeclareGlobalFunction( "Image" );
#! @Arguments der, coll
#! @Label of a subgroup under a group derivation
DeclareGlobalFunction( "Image" );
#! @EndGroup

#! @Description
#! Calculates a preimage of the element <A>elm</A> under the group derivation <A>der</A>.
#! @Arguments der, elm
#! @Label of an element under a group derivation
DeclareOperation( "PreImagesRepresentative", [ IsGeneralMapping, IsObject ] );

#! @Description
#! Calculates the preimages of the element <A>elm</A> under the group derivation <A>der</A>.
#! This will always be a (right) coset of <C>Kernel</C>( <A>der</A> ).
#! @Arguments der, elm
#! @Label of an element under a group derivation
DeclareGlobalFunction( "PreImages" );

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

###
# SECTION 3
###

#! @Section Images of Group Derivations

#! @Description
#! Given an element <A>g</A> of a PcpGroup and a double coset <A>D</A> of that same group, this function tests whether <A>g</A> is an element of <A>D</A>.
#! @Arguments img
#! @Label for a group derivation image
DeclareAttribute( "Size", IsGroupDerivationImageRep );

#! @Description
#! Given double cosets <A>C</A> and <A>D</A> of a PcpGroup, this function tests whether <A>C</A> and <A>D</A> are equal.
#! @Arguments g, img
#! @Label for an element and a group derivation
DeclareOperation( "\in", [ IsObject, IsGroupDerivationImageRep ] );

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
