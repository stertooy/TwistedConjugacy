#! @Abstract
#! The &TwistedConjugacy; package provides methods for solving the twisted
#! conjugacy problem (including the "search" and "multiple" variants) and for
#! computing Reidemeister classes, numbers, spectra, and zeta functions. It
#! also includes utility functions for working with (double) cosets, group
#! homomorphisms, and group derivations.
#! <P/>
#! These methods are primarily designed for use with finite groups and with
#! PcpGroups (finite or infinite) provided by the &Polycyclic; package.

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

#! @Chapter The TwistedConjugacy package

#! This is the manual for the &GAP; 4 package &TwistedConjugacy; version
#! &VERSION;, developed by Sam Tertooy.

#! @Section Installation
#! You can download &TwistedConjugacy; as a .tar.gz archive
#! <URL Text='here'>&ARCHIVEURL;.tar.gz</URL>. After extracting, you should
#! place it in a suitable <F>pkg</F> folder. For example, on a Debian-based
#! Linux distribution (e.g. Ubuntu, Mint), you can place it in
#! <F>&dollar;HOME/.gap/pkg</F> (recommended) which makes it available for just
#! yourself, or in the &GAP; installation directory (<F>gap-X.Y.Z/pkg</F>)
#! which makes it available for all users.
#!
#! You can use the following command to efficiently install the package for yourself:
#! <Listing Type="Command">wget -qO- https://[...].tar.gz | tar xzf - --one-top-level=&dollar;HOME/.gap/pkg</Listing>
#! If the &PackageManager; package is installed and loaded, you can install
#! &TwistedConjugacy; from within a &GAP; session
#! using <Ref Func="InstallPackage" BookName="PackageManager" Style="Number"/>.
#! @BeginLog
InstallPackage( "https://[...].tar.gz" );
#! ...
#! true
#! @EndLog
# <Ref Func="ReadPackage" BookName="ref"/>.
# <Ref Func="TwistedConjugation" Style="Number"/>.

#! @Section Loading
#! Once installed, loading &TwistedConjugacy; can be done by using
#! <Ref Func="LoadPackage" BookName="ref" Style="Number"/>.
#! @BeginLog
LoadPackage( "TwistedConjugacy" );
#! ...
#! true
#! @EndLog

#! @Section Citing
#! If you use the &TwistedConjugacy; package in your research, we would love to
#! hear about your work via an email to the address
#! <Email>&SUPPORTEMAIL;</Email>.
#! If you have used the &TwistedConjugacy; package in the preparation of a
#! paper and wish to refer to it, please cite it as described below.

#! <P/>

#! In &BibTeX;:
#!<Listing Type="BibTeX">
#!&AT;misc{TC&VERSION;,
#!    author =       {Tertooy, Sam},
#!    title =        {{TwistedConjugacy,
#!                    &SUBTITLE;,
#!                    Version &VERSION;}},
#!    note =         {GAP package},
#!    year =         {&RELEASEYEAR;},
#!    howpublished = {\url{https://stertooy.github.io/TwistedConjugacy}}
#!}</Listing><P/>
#! In &BibLaTeX;:
#!<Listing Type="BibLaTeX">
#!&AT;software{TC&VERSION;,
#!    author =   {Tertooy, Sam},
#!    title =    {TwistedConjugacy},
#!    subtitle = {&SUBTITLE;},
#!    version =  {&VERSION;},
#!    note =     {GAP package},
#!    year =     {&RELEASEYEAR;},
#!    url =      {&HOMEURL;}
#!}</Listing>

#! @Section Support
#! If you encounter any problems, please submit them to the
#! <URL Text='issue tracker'>&ISSUEURL;</URL>.
#! If you have any questions on the usage or functionality of
#! &TwistedConjugacy;, you may contact me via email at
#! <Email>&SUPPORTEMAIL;</Email>.

#! <P/>

#! Bugs in &GAP;, in this package, or in any other package used directly or
#! indirectly, may cause functions provided by &TwistedConjugacy; to produce
#! errors or incorrect results.
#! To help detect such issues, you can enable internal checks by setting the
#! variable <C>ASSERT&#64;TwistedConjugacy</C> to <K>true</K>. Note that this
#! will come at the cost of reduced performance.

#! <P/>

#! For additional safety, you can enable &GAP;'s built-in assertion features by
#! calling <C>SetAssertionLevel( <A>lev</A> )</C> (we recommend setting
#! <A>lev</A> to <C>2</C>) and, when working with PcpGroups, setting the
#! variables <C>CHECK_CENT&#64;Polycyclic</C>, <C>CHECK_IGS&#64;Polycyclic</C>
#! and <C>CHECK_INTSTAB&#64;Polycyclic</C> to <K>true</K>.

#! @Chapter Mathematical Background

#! Let $G$ and $H$ be groups and let $\varphi$ and $\psi$ be group
#! homomorphisms from $H$ to $G$. The pair $(\varphi,\psi)$ induces a
#! (right) group action of $H$ on $G$ given by the map $$G \times H \to G
#! \colon (g,h) \mapsto \varphi(h)^{-1} g\,\psi(h).$$
#! This group action is called **$(\varphi,\psi)$-twisted conjugation**. The
#! orbits are called **Reidemeister classes** or **twisted conjugacy classes**,
#! and the number of Reidemeister classes is called the **Reidemeister number**
#! $R(\varphi,\psi)$ of the pair $(\varphi,\psi)$. The stabiliser of the
#! identity $1_G$ under the $(\varphi,\psi)$-twisted conjugacy action of $H$ is
#! exactly the **coincidence group**
#! $$\operatorname{Coin}(\varphi,\psi) =
#! \left\{\, h \in H \mid \varphi(h) = \psi(h) \, \right\}.$$
#! Generalising this, the stabiliser of any $g \in G$ is the coincidence group
#! $\operatorname{Coin}(\iota_g\varphi,\psi)$, with $\iota_g$ the inner
#! automorphism of $G$ that conjugates by $g$.

#! <P/>

#! Twisted conjugacy originates in Reidemeister-Nielsen fixed point and coincidence theory,
#! where it serves as a tool for studying fixed and coincidence points of continuous maps
#! between topological spaces. Below, we briefly illustrate how and where this algebraic notion
#! arises when studying coincidence points.

#! Let $X$ and $Y$ be topological spaces with universal covers
#! $p \colon \tilde{X} \to X$ and $q \colon \tilde{Y} \to Y$ and let
#! $\mathcal{D}(X), \mathcal{D}(Y)$ be their covering transformations groups.

#! Let $f,g \colon X \to Y$ be continuous maps with lifts
#! $\tilde{f}, \tilde{g} \colon \tilde{X} \to \tilde{Y}$. By $f_*\colon 
#! \mathcal{D}(X) \to \mathcal{D}(Y)$, denote the group homomorphism defined by
#! $\tilde{f} \circ \gamma = f_*(\gamma) \circ \tilde{f}$ for all  $\gamma \in 
#! \mathcal{D}(X)$, and let $g_*$ be defined similarly. The
#! set of coincidence points $\operatorname{Coin}(f,g)$ equals the union
#! $$\operatorname{Coin}(f,g) = \bigcup_{\alpha \in \mathcal{D}(Y)}
#! p(\operatorname{Coin}(\tilde{f}, \alpha \tilde{g})).$$
#! For any two elements $\alpha, \beta \in \mathcal{D}(Y)$, the sets
#! $p(\operatorname{Coin}(\tilde{f}, \alpha \tilde{g}))$ and
#! $p(\operatorname{Coin}(\tilde{f}, \beta \tilde{g}))$ are either disjoint or
#! equal. Moreover, they are equal if and only if there exists some $\gamma
#! \in \mathcal{D}(X)$ such that $\alpha = f_*(\gamma)^{-1} \circ \beta \circ
#! g_*(\gamma)$, which is exactly the same as saying that $\alpha$ and $\beta$
#! are $(f_*,g_*)$-twisted conjugate. Thus,
#! $$\operatorname{Coin}(f,g) = \bigsqcup_{[\alpha]}
#! p(\operatorname{Coin}(\tilde{f}, \alpha \tilde{g})),$$
#! where $[\alpha]$ runs over the $(f_*,g_*)$-twisted conjugacy classes. For
#! sufficiently well-behaved spaces $X$ and $Y$ (e.g. nilmanifolds of equal dimension)
#! we have that if $R(f_*,g_*) &lt; \infty$, then 
#! $$R(f_*,g_*) \leq \left|\operatorname{Coin}(f,g)\right|,$$
#! whereas if $R(f_*,g_*) = \infty$ there exist continuous maps $f'$ and $g'$ homotopic to $f$ and $g$ respectively such that
#! $\operatorname{Coin}(f',g') = \varnothing$.

#! @Chapter Twisted conjugacy

#! @Section The twisted conjugation action

#! Let $G$ and $H$ be groups and let $\varphi$ and $\psi$ be group
#! homomorphisms from $H$ to $G$. The pair $(\varphi,\psi)$ induces a
#! (right) group action of $H$ on $G$ given by the map $$G \times H \to G
#! \colon (g,h) \mapsto \varphi(h)^{-1} g\,\psi(h).$$
#! This group action is called **$(\varphi,\psi)$-twisted conjugation**.

#! <P/>

#! If $G = H$, $\varphi$ is an endomorphism of $G$ and $\psi = \operatorname{id}_G$,
#! then the action is usually called **$\varphi$-twisted conjugation**.
#!
#! In general, for the &TwistedConjugacy; package, many functions will take
#! two homomorphisms <A>hom1</A> and <A>hom2</A> as arguments. However, if <A>hom1</A>
#! is an endomorphism, <A>hom2</A> can be omitted, in which case it is automatically
#! taken to be the identity map.
#!
#! Similarly, some functions will take two elements <A>g1</A> and <A>g2</A> as arguments.
#! If <A>g2</A> is omitted, it is automatically taken to be the identity element.

#! @Returns a function that maps the pair <C>(g,h)</C> to <A>hom1</A><C>(h)⁻¹</C> <C>g</C> <A>hom2</A><C>(h)</C>.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "TwistedConjugation" );

#! @Section The twisted conjugacy (search) problem

#! Given groups $G$ and $H$, group homomorphisms $\varphi$ and $\psi$ from $H$
#! to $G$ and elements $g_1, g_2 \in G$, the **twisted conjugacy problem** is
#! the decision problem that asks whether $g_1$ and $g_2$ are $(\varphi,\psi)$-twisted
#! conjugate.
#! The **twisted conjugacy search problem** is the problem of determining
#! an explicit $h$ such that $\varphi(h)^{-1}g_1\psi(h) = g_2$ (under the assumption that such
#! $h$ exists).

#! @Returns <K>true</K> if <A>g1</A> and <A>g2</A> are <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugate, otherwise <K>false</K>.
#! @Arguments hom1[, hom2], g1[, g2]
DeclareGlobalFunction( "IsTwistedConjugate" );

#! @Returns an element that maps <A>g1</A> to <A>g2</A> under the <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy action, or <K>fail</K> if no such element exists.
#! @Description
#! If the source group is finite, this function relies on orbit-stabiliser algorithms provided by &GAP;. 
#! Otherwise, it relies on a mixture of the algorithms described in <Cite Key='roma16-a' Where='Thm. 3'/>, <Cite Key='bkl20-a' Where='Sec. 5.4'/>, <Cite Key='roma21-a' Where='Sec. 7'/> and <Cite Key='dt21-a'/>.
#! @Arguments hom1[, hom2], g1[, g2]
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

#! @Section The multiple twisted conjugacy (search) problem

#! Let $H$ and $G_1, \ldots, G_n$ be groups. For each $i \in \{1,\ldots,n\}$, let $g_i,g_i' \in G_i$ and let $\varphi_i,\psi_i\colon H \to G_i$ be group homomorphisms.
#! The **multiple twisted conjugacy problem** is
#! the decision problem that asks whether there exists some $h \in H$ such that
#! $\varphi_i(h)^{-1}g_i\psi_i(h) = g_i'$ for all $i \in \{1,\ldots,n\}$.

#! The **multiple twisted conjugacy search problem** is the problem of determining
#! an explicit $h$ such that $\varphi_i(h)^{-1}g_i\psi_i(h) = g_i'$ for all $i \in \{1,\ldots,n\}$ (under the assumption that such
#! $h$ exists).

#! <P/>

#! <Ref Func="IsTwistedConjugate"/> and <Ref Func="RepresentativeTwistedConjugation"/>
#! can take lists instead of their usual arguments to solve these problems.

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
IsTwistedConjugate( [ phi, psi ], [ khi, tau ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! true
RepresentativeTwistedConjugation( [ phi, psi ], [ khi, tau ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! (1,2)
#! @EndExample

#! @Chapter Twisted conjugacy classes

#! The orbits of the $(\varphi,\psi)$-twisted conjugacy action are called the
#! **$(\varphi,\psi)$-twisted conjugacy classes** or the
#! **Reidemeister classes of $(\varphi,\psi)$**.
#! We denote the twisted conjugacy class of $g \in G$ by $[g]_{\varphi,\psi}$.

#! @Section Creating a twisted conjugacy class

#! @BeginGroup
#! @Returns the <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy class of <A>g</A>.
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "TwistedConjugacyClass" );
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "ReidemeisterClass" );
#! @EndGroup

#! @Section Operations on twisted conjugacy classes

#! @BeginGroup
#! @GroupTitle Representative
#! @Returns the group element that was used to construct <A>tcc</A>.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "Representative", IsReidemeisterClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle ActingDomain
#! @Returns the group whose twisted conjugacy action <A>tcc</A> is an orbit of.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "ActingDomain", IsReidemeisterClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle FunctionAction
#! @Returns the twisted conjugacy action that <A>tcc</A> is an orbit of.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "FunctionAction", IsReidemeisterClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>g</A> is an element of <A>tcc</A>, otherwise <K>false</K>.
#! @Label for an element and a twisted conjugacy class
#! @Arguments g, tcc
DeclareOperation( "\in", [ IsObject, IsReidemeisterClassGroupRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Size
#! @Returns the number of elements in <A>tcc</A>.
#! @Description
#! This is calculated using the orbit-stabiliser theorem.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "Size", IsReidemeisterClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle StabiliserOfExternalSet
#! @Returns the stabiliser of <C>Representative(<A>tcc</A>)</C> under the action
#! <C>FunctionAction(<A>tcc</A>)</C>.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareAttribute( "StabiliserOfExternalSet", IsReidemeisterClassGroupRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle List
#! @Returns a list containing the elements of <A>tcc</A>.
#! @Description If <A>tcc</A> is infinite, this will run forever. It is recommended
#! to first test the finiteness of <A>tcc</A> using <Ref Attr="Size" Label="of a twisted conjugacy class"/>.
#! @Label of a twisted conjugacy class
#! @Arguments tcc
DeclareGlobalFunction( "List" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Random
#! @Returns a random element in <A>tcc</A>.
#! @Label in a twisted conjugacy class
#! @Arguments tcc
DeclareOperation( "Random", [ IsReidemeisterClassGroupRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \=
#! @Returns <K>true</K> if <A>tcc1</A> is equal to <A>tcc2</A>, otherwise <K>false</K>.
#! @Label for twisted conjugacy classes
#! @Arguments tcc1, tcc2
DeclareOperation( "\=", [ IsReidemeisterClassGroupRep, IsReidemeisterClassGroupRep ] );
#! @EndGroup

#! @Section Calculating all twisted conjugacy classes

#! @BeginGroup
#! @Returns a list containing the (<A>hom1</A>, <A>hom2</A>)-twisted conjugacy classes if there are finitely many, or <K>fail</K> otherwise.
#! @Description
#! If the argument <A>N</A> is provided, it must be a normal subgroup of <C>Range(<A>hom1</A>)</C>; the function will then only return the
#! Reidemeister classes that intersect <A>N</A> non-trivially.
#! It is guaranteed that the Reidemeister class of the identity is in the first position, and that the representatives of the classes belong to <A>N</A> if this argument is provided.
#! <P />
#! If $G$ and $H$ are finite, this function relies on an orbit-stabiliser algorithm.
#! Otherwise, it relies on the algorithms in <Cite Key='dt21-a'/> and <Cite Key='tert25-a' />.
#! @Arguments hom1[, hom2][, N]
DeclareGlobalFunction( "TwistedConjugacyClasses" );
#! @Arguments hom1[, hom2][, N]
DeclareGlobalFunction( "ReidemeisterClasses" );
#! @EndGroup

#! @BeginGroup
#! @Returns a list containing representatives of the (<A>hom1</A>, <A>hom2</A>)-twisted conjugacy classes if there are finitely many, or <K>fail</K> otherwise.
#! @Description
#! If the argument <A>N</A> is provided, it must be a normal subgroup of <C>Range(<A>hom1</A>)</C>; the function will then only return the representatives of 
#! the twisted conjugacy classes that intersect <A>N</A> non-trivially.
#! It is guaranteed that the identity is in the first position, and that all elements belong to <A>N</A> if this argument is provided.
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

#! @Chapter Reidemeister numbers and spectra

#! @Section Reidemeister numbers
#! The number of twisted conjugacy classes is called the Reidemeister number and is always a positive integer or infinity.
#! @BeginGroup ReidemeisterNumberGroup
#! @Returns the Reidemeister number of ( <A>hom1</A>, <A>hom2</A> ).
#! @Description
#! If $G$ is abelian, this function relies on (a generalisation of) <Cite Key='jian83-a' Where='Thm. 2.5'/>.
#! If $G = H$, $G$ is finite non-abelian and $\psi = \operatorname{id}_G$, it relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! Otherwise, it simply calculates the twisted conjugacy classes and then counts them.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "ReidemeisterNumber" );
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "NrTwistedConjugacyClasses" );
#! @EndGroup

#! @Section Reidemeister spectra
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

#! @Returns the Reidemeister spectrum of <A>G</A>.
#! @Description
#! If $G$ is abelian, this function relies on the results from <Cite Key='send23-a'/>.
#! Otherwise, it relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! @Arguments G
DeclareGlobalFunction( "ReidemeisterSpectrum" );

#! @Returns the extended Reidemeister spectrum of <A>G</A>.
#! @Description
#! If $G$ is abelian, this is just the set of all divisors of the order of <A>G</A>.
#! Otherwise, this function relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! @Arguments G
DeclareGlobalFunction( "ExtendedReidemeisterSpectrum" );

#! @Returns the coincidence Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @Arguments [H, ]G
DeclareGlobalFunction( "CoincidenceReidemeisterSpectrum" );

#! @Returns the total Reidemeister spectrum of <A>H</A> and <A>G</A>.
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

#! @Chapter Reidemeister zeta functions

#! @Section Reidemeister zeta functions

#! Let $\varphi,\psi\colon G \to G$ be endomorphisms such that $R(\varphi^n,\psi^n) &lt; \infty$ for all $n \in \mathbb{N}$. Then the **Reidemeister zeta function** $Z_{\varphi,\psi}(s)$ of the pair $(\varphi,\psi)$ is defined as
#! $$Z_{\varphi,\psi}(s) := \exp \sum_{n=1}^\infty \frac{R(\varphi^n,\psi^n)}{n} s^n.$$
#! <P/>
#! Please note that the functions below are only implemented for endomorphisms of finite groups.


#! @Returns two lists of integers.
#! @Description
#! For a finite group, the sequence of Reidemeister numbers of the iterates of <A>endo1</A> and <A>endo2</A>, i.e. the sequence $R(<A>endo1</A>,<A>endo2</A>)$, $R(<A>endo1</A>^2,<A>endo2</A>^2)$, ..., is eventually periodic.
#! Thus there exist a periodic sequence $(P_n)_{n \in \mathbb{N}}$ and an eventually zero sequence $(Q_n)_{n \in \mathbb{N}}$ such that
#! $$\forall n \in \mathbb{N}: R(\varphi^n,\psi^n) = P_n + Q_n.$$
#! This function returns two lists: the first list contains one period of the sequence $(P_n)_{n \in \mathbb{N}}$, the second list contains $(Q_n)_{n \in \mathbb{N}}$ up to the part where it becomes the constant zero sequence.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterZetaCoefficients" );

#! @Returns <K>true</K> if the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A> is rational, otherwise <K>false</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IsRationalReidemeisterZeta" );

#! @Returns the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A> if it is rational, otherwise <K>fail</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterZeta" );

#! @Returns a string describing the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A>.
#! @Description
#! This is often more readable than evaluating <C>ReidemeisterZeta</C> in an indeterminate, and does not require rationality.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "PrintReidemeisterZeta" );

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

#! @Chapter Cosets of PcpGroups

#! &GAP; is well-equipped to deal with **finite** cosets. However, if a coset
#! is infinite, methods may not be available, may be faulty, or may run
#! forever. The &TwistedConjugacy; package provides additional methods for
#! existing functions that can deal with infinite cosets of PcpGroups.
#!
#! The only completely new functions are
#! <Ref Func="DoubleCosetIndex" /> and its <C>NC</C> version.

#! @Section Right cosets

#! Calculating the intersection of two right cosets $Hx$ and $Ky$ can be
#! reduced to calculating the intersection $H \cap K$ and verifying whether
#! $xy^{-1} \in HK$ (see <Ref Oper="\in"
#! Label="for an element and a double coset of a PcpGroup"/>).

#! @BeginGroup
#! @Returns the intersection of the right cosets <A>C1</A>, <A>C2</A>, ...
#! @Description
#! Alternatively, this function also accepts a single list of right
#! cosets <A>L</A> as argument.
#!
#! This intersection is always a right coset, or the empty list.
#! @Label of right cosets of a PcpGroup
#! @Arguments C1, C2, ...
DeclareGlobalFunction( "Intersection" );
#! @Label of a list of right cosets of a PcpGroup
#! @Arguments L
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

#! @Section Double cosets

#! Algorithms designed for computing with twisted conjugacy classes can be
#! leveraged to do computations involving double cosets, see
#! <Cite Key='tert25-a' Where="Sec. 9"/> for a description on this.
#! When the &TwistedConjugacy; package is loaded, it does this automatically,
#! and the functions below should then work for PcpGroups, even if they are
#! infinite.

#! @BeginGroup
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>g</A> is an element of <A>D</A>, otherwise <K>false</K>.
#! @Label for an element and a double coset of a PcpGroup
#! @Arguments g, D
DeclareOperation( "\in", [ IsMultiplicativeElementWithInverse, IsDoubleCoset ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Size
#! @Returns the number of elements in <A>D</A>.
#! @Label of a double coset of a PcpGroup
#! @Arguments D
DeclareOperation( "Size", [ IsDoubleCoset ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle List
#! @Returns a list containing the elements of <A>D</A>.
#! @Description If <A>D</A> is infinite, this will run forever. It is recommended
#! to first test the finiteness of <A>D</A> using <Ref Attr="Size" Label="of a double coset of a PcpGroup"/>.
#! @Label of a double coset of a PcpGroup
#! @Arguments D
DeclareGlobalFunction( "List" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \=
#! @Returns <K>true</K> if <A>C</A> and <A>D</A> are the same double coset, otherwise <K>false</K>.
#! @Label for double cosets of a PcpGroup
#! @Arguments C, D
DeclareOperation( "\=", [ IsDoubleCoset, IsDoubleCoset ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle DoubleCosets
#! @Returns a duplicate-free list of all <C>(<A>H</A>,<A>K</A>)</C>-double cosets in <A>G</A> if there are finitely many, otherwise <K>fail</K>.
#! @Description
#! The groups <A>H</A> and <A>K</A> must be subgroups of the group <A>G</A>.
#! The <C>NC</C> version does not check whether this is the case.
#! @Label for PcpGroups
#! @Arguments G, H, K
DeclareGlobalFunction( "DoubleCosets" );
# <Label Name="DoubleCosetsNC"/>
#! @Label for PcpGroups
#! @Arguments G, H, K
DeclareOperation( "DoubleCosetsNC", [ IsPcpGroup, IsPcPGroup, IsPcPGroup ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle DoubleCosetRepsAndSizes
#! @Returns a list containing pairs of the form <C>[ r, n ]</C>, where <C>r</C>
#! is a representative and <C>n</C> is the size of a double coset.
#! @Description
#! While for finite groups this function is supposed to be faster than
#! <Ref Oper="DoubleCosetsNC" Label="for PcpGroups"/>, for PcpGroups it is usually **slower**.
#! @Label for PcpGroups
#! @Arguments G, H, K
DeclareOperation( "DoubleCosetRepsAndSizes", [ IsPcpGroup, IsPcPGroup, IsPcPGroup ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle DoubleCosetIndex
#! @Returns the double coset index of the pair (<A>H</A>,<A>K</A>).
#! @Description
#! The groups <A>H</A> and <A>K</A> must be subgroups of the group <A>G</A>.
#! The <C>NC</C> version does not check whether this is the case.
# @Label of a double coset of a PcpGroup
#! @Arguments G, H, K
DeclareGlobalFunction( "DoubleCosetIndex" );
# @Label of a double coset of a PcpGroup
#! @Label
#! @Arguments G, H, K
DeclareOperation( "DoubleCosetIndexNC", [ IsGroup, IsGroup, IsGroup ] );
#! @EndGroup

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
DoubleCosets( G, H, K );
#! [ DoubleCoset(<group with 2 generators>,<object>,<group with 2 generators>),
#!   DoubleCoset(<group with 2 generators>,<object>,<group with 2 generators>) ]
DoubleCosetIndex( G, H, K );
#! 2
#! @EndExample



#! @Chapter Group homomorphisms

#! @Section Representatives of homomorphisms between groups

#! Please note that the functions below are only implemented for finite groups.

#! @Returns a list of the automorphisms of <A>G</A> up to composition with inner automorphisms.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesAutomorphismClasses" );

#! @Returns a list of the endomorphisms of <A>G</A> up to composition with inner automorphisms.
#! @Description
#! This does the same as calling <C>AllHomomorphismClasses(<A>G</A>,<A>G</A>)</C>, but should be faster for abelian and non-2-generated groups.
#! For 2-generated groups, this function takes its source code from <C>AllHomomorphismClasses</C>.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesEndomorphismClasses" );

#! @Returns a list of the homomorphisms from <A>H</A> to <A>G</A>, up to composition with inner automorphisms of <A>G</A>.
#! @Description
#! This does the same as calling <C>AllHomomorphismClasses(<A>H</A>,<A>G</A>)</C>, but should be faster for abelian and non-2-generated groups.
#! For 2-generated groups, this function behaves nearly identical to <Ref Func="AllHomomorphismClasses" BookName="Ref" />.
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

#! @Returns the subgroup of <C>Source(<A>endo</A>)</C> consisting of the elements fixed under the endomorphism <A>endo</A>.
#! @Arguments endo
DeclareGlobalFunction( "FixedPointGroup" );

#! @Returns the subgroup of <C>Source(<A>hom1</A>)</C> consisting of the elements <C>h</C> for which <C>h^<A>hom1</A></C> = <C>h^<A>hom2</A></C> = ...
#! @Description
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

#! @Section Induced and restricted group homomorphisms

#! @Returns the homomorphism induced by <A>hom</A> between the images of <A>epi1</A> and <A>epi2</A>.
#! @Description
#! Let <A>hom</A> be a group homomorphism from a group <C>H</C> to a group <C>G</C>,
#! let <A>epi1</A> be an epimorphism from <C>H</C> to a group <C>Q</C> and
#! let <A>epi2</A> be an epimorphism from <C>G</C> to a group <C>P</C> such that
#! the kernel of <A>epi1</A> is mapped into the kernel of <A>epi2</A> by <A>hom</A>.
#! This command returns the homomorphism from <C>Q</C> to <C>P</C> that maps
#! <C>h^<A>epi1</A></C> to <C>(h^<A>hom</A>)^<A>epi2</A></C>,
#! for any element <C>h</C> of <C>H</C>.
#! This function generalises <Ref Func="InducedAutomorphism" BookName="ref" /> to homomorphisms.
#! @Arguments epi1, epi2, hom
DeclareGlobalFunction( "InducedHomomorphism" );

#! @Returns the homomorphism <A>hom</A>, but restricted as a map from <A>N</A> to <A>M</A>.
#! @Description
#! Let <A>hom</A> be a group homomorphism from a group <C>H</C> to a group <C>G</C>,
#! and let <A>N</A> be subgroup of <C>H</C> such that its image under <A>hom</A> is a subgroup of <A>M</A>.
#! This command returns the homomorphism from <A>N</A> to <A>M</A> that maps
#! <C>n</C> to <C>n^<A>hom</A></C> for any element <C>n</C> of <A>N</A>. 
#! No checks are made to verify that <A>hom</A> maps <A>N</A> into <A>M</A>.
#! This function is similar to <C>RestrictedMapping</C>, but its range is explicitly set to <A>M</A>.
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

#! Let $G$ and $H$ be groups and let $H$ act on $G$ via automorphisms, i.e. there is a group homomorphism
#! $$\alpha \colon H \to \operatorname{Aut}(G)$$ such that $g^h = \alpha(h)(g)$ for all $g \in G$ and $h \in H$.
#! A **group derivation** $\delta \colon H \to G$ is a map such that
#! $$\delta(h_1h_2) = \delta(h_1)^{h_2}\delta(h_2).$$
#! Note that we do not require $G$ to be abelian.

#! <P/>

#! Algorithms designed for computing with twisted conjugacy classes can be
#! leveraged to do computations involving group derivations, see
#! <Cite Key='tert25-a'  Where="Sec. 10"/> for a description on this.

#! <P/>

#! Please note that the functions in this section require $G$ and $H$ to either both be finite, or both be PcpGroups.

#! @Section Creating group derivations

#! The functions below only work for derivations between finite groups or between PcpGroups. 

#! @BeginGroup
#! @Returns the specified group derivation, or <K>fail</K> if the given arguments do not define a derivation.
#! @Description
#! This works in the same vein as <Ref Func="GroupHomomorphismByImages" BookName="Ref" Style="Number"/>. The group <A>H</A> acts on the group <A>G</A> via <A>act</A>,
#! which must be a homomorphism from <A>H</A> into a group of automorphisms of <A>G</A>. This command then returns the group derivation defined by mapping the list
#! <A>gens</A> of generators of <A>H</A> to the list <A>imgs</A> of images in <A>G</A>.
#!
#! If omitted, the arguments <A>gens</A> and <A>imgs</A> default to the <C>GeneratorsOfGroup</C> value of <A>H</A> and <A>G</A> respectively.
#!
#! This function checks whether <A>gens</A> generate <A>H</A> and whether the mapping of the generators extends to a group derivation.
#! This test can be expensive, so if one is certain that the given arguments produce a group derivation, these checks can be avoided by using the <C>NC</C> version.
#! @Arguments H, G[[, gens], imgs], act
DeclareGlobalFunction( "GroupDerivationByImages" );
#! @Arguments H, G[[, gens], imgs], act
DeclareGlobalFunction( "GroupDerivationByImagesNC" );
#! @EndGroup

#! @Returns the specified group derivation.
#! @Description
#! <C>GroupDerivationByFunction</C> works in the same vein as <Ref Func="GroupHomomorphismByFunction" BookName="Ref" Style="Number"/>. The group <A>H</A> acts on the group <A>G</A> via <A>act</A>,
#! which must be a homomorphism from <A>H</A> into a group of automorphisms of <A>G</A>. This command then returns the group derivation defined by mapping the
#! element <C>h</C> of <A>H</A> to the element <A>fun</A>( <C>h</C> ) of <A>G</A>, where <A>fun</A> is a &GAP; function.
#!
#! No tests are performed to check whether the arguments really produce a group derivation.
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

#! @Section Operations for group derivations

#! Many of the functions, operations, attributes... available to group
#! homomorphisms are available for group derivations as well.
#! We list some of the more useful ones.

#! @BeginGroup
#! @GroupTitle IsInjective
#! @Returns <K>true</K> if the group derivation <A>der</A> is injective, otherwise <K>false</K>.
#! @Label for a group derivation
#! @Arguments der
DeclareProperty( "IsInjective", IsGroupDerivation );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle IsSurjective
#! @Returns <K>true</K> if the group derivation <A>der</A> is surjective, otherwise <K>false</K>.
#! @Label for a group derivation
#! @Arguments der
DeclareProperty( "IsSurjective", IsGroupDerivation );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle IsBijective
#! @Returns <K>true</K> if the group derivation <A>der</A> is bijjective, otherwise <K>false</K>.
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
#! One can optionally give an element <A>elm</A> or a subgroup <A>sub</A> as a second argument,
#! in which case <C>Image</C> will calculate the image of this argument under <A>der</A>.
#! @Label of a group derivation
#! @Arguments der
DeclareGlobalFunction( "Image" );
#! @Label of an element under a group derivation
#! @Arguments der, elm
DeclareGlobalFunction( "Image" );
#! @Label of a subgroup under a group derivation
#! @Arguments der, coll
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
#! @GroupTitle PreImagges
#! @Returns the set of all preimages of the element <A>elm</A> under the group derivation <A>der</A>.
#! @Description
#! This will always be a (right) coset of <C>Kernel</C>( <A>der</A> ), or the empty list.
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

#! In general, the image of a group derivation is not a subgroup. However, it is
#! still possible to do a membership test, to calculate the number of elements,
#! and to enumerate the elements if there are only finitely many.

#! @BeginGroup
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>elm</A> is an element of <A>img</A>, otherwise <K>false</K>.
#! @Label for an element and a group derivation
#! @Arguments elm, img
DeclareOperation( "\in", [ IsObject, IsGroupDerivationImageRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Size
#! @Returns the number of elements in <A>img</A>.
#! @Label of a group derivation image
#! @Arguments img
DeclareAttribute( "Size", IsGroupDerivationImageRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle List
#! @Returns a list containing the elements of <A>img</A>.
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
