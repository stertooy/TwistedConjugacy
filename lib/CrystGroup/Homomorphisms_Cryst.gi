##
## autos inducing the identity of G/T and on T
##
DerivationAutosCG := function( C )
    local G, n, z, rels, der, i, k, a, cf, pows, h;
    # get info
    G := C!.group;
    n := Length( C.factor );
    # compute 1-cocycles
    cf := OneCohomologyCR( C ).factor;
    z := cf.prei;
    rels := cf.rels;
    if Length(z) = 0 then
        return [ IdentityMapping( G ) ];
    fi;
    # translate to autos
    der := [];
    h := C!.full;
    for i in [1..Length(z)] do
        k := List( CutVector(z[i], n), x -> MappedVector( x, C.normal ) );
        k := List( [1..n], j -> C.factor[j]*k[j] );
        k := Concatenation( k, C.normal!.gens );
        a := GroupHomomorphismByImagesNC( G, G, h, k );
        SetIsBijective( a, true );
        Add(der, a);
    od;
    pows := Cartesian( List( cf.rels, i -> [0..i-1] ) );
    return List( pows, x -> Product( List( [ 1..Size( der ) ], i -> der[i]^x[i] ) ) );
end;

##
## pairs that act compatible on G/T and on T
##
MakeCompatiblePairsCG := function( iso, N )
    local mgi, gens, imgs, F, n, s, a, w, b;
    mgi := MappingGeneratorsImages( iso );
    gens := mgi[2];
    imgs := mgi[1];
    F := Range( iso );
    n := SmallGeneratingSet( N );
    if Size( n ) = 0 then n := [ One( N ) ]; fi;
    s := [];
    for a in n do
        w := List( imgs, x -> ImagesRepresentative( iso, x^a ) );
        b := GroupHomomorphismByImagesNC( F, F, gens, w );
        SetIsBijective( b, true );
        Add( s, Tuple( [ a, b ] ) );
    od;
    return s;
end;


##
## technical details ..
##
TailOfRelator := function( C, T, g, i, j )
    local e, a, b;
    e := RelativeOrdersOfPcp( C.factor )[i]; #factor2
    if i = j then
        a := g[i]^e;
    elif j < i then
        a := g[i]^g[j];
    else
        a := g[i]^( g[j-i]^-1 );
    fi;
    if Length( C.relators[i][j] ) > 0 then
        b := Product( C.relators[i][j], x -> g[x[1]]^x[2] );
    else
        b := g[1]^0;
    fi;
    return ExponentsByPcp( T, b^-1 * a );
end;


##
## technical details ...
##
TailImage := function( C, c, tup )
    local n, F, f, H, h, a, k, t;

    # get info
    n := Length( C.factor );
    F := Source( tup[2] );
    f := Igs( F );

    # construct extension
    H := ExtensionCR( C, c );
    h := Pcp( H );

    # map with tup[2]^-1
    a := Inverse(tup[2]);
    k := List( [1..n], x -> MappedVector( Exponents( Image( a, f[x] ) ), h{[1..n]} ) );

    # push through relators
    t := List( C.enumrels, x -> TailOfRelator( C, Pcp( FittingSubgroup( H ) ), k, x[1], x[2] ) );
    t := List( t, x -> x * tup[1] );
    return Concatenation( t );
end;

##
## determine the action of a compatible pair on the two-cohomology
##
MatrixOperOfTupleCG := function( C, cf, tup )
    local ig, c, l;
    ig := [];
    for c in cf.prei do
        l := TailImage( C, c, tup );
        l := SolutionIntMat( cf.full, l ){[ 1..Length( cf.prei ) ]};
        l := List( [ 1..Length( l ) ], x -> l[x] mod cf.rels[x] );
        Add( ig, l );
    od;
    return ig;
end;




##
## technical detail ...
##
RelatorMatrix := function( C )
    local n, d, l, m, f, E, k, e, i, j, h, A, B, r, w, s, t;

    #if IsBound( C!.relma ) then return C!.relma; fi;

    n := Length( C.factor );
    d := Length( C.normal );
    l := Length( C.enumrels );
    m := C.mats;
    f := RelativeOrdersOfPcp( C.factor );
    E := [];

    for k in [1..l] do
        A := List( [1..n], x -> NullMat( d,d ) );
        e := C.enumrels[k];
        i := e[1]; j := e[2];
        if j < i then
            A[j] := IdentityMat( d ) - m[i]^m[j];
            A[i] := m[j];
        elif j > i then
            A[j-i] := m[i]*m[j-i]^-1 - m[j-i]^-1;
            A[i] := m[j-i]^-1;
        else
            for h in [0..f[i]-1] do
                A[i] := A[i] + m[i]^h;
            od;
        fi;

        B := List( [1..n], x -> NullMat( d, d ) );
        r := C.relators[i][j];
        w := IdentityMat( d );
        for s in Reversed( [ 1..Length( r ) ] ) do
            for t in [1..r[s][2]] do
                B[r[s][1]] := B[r[s][1]] + w;
                w := m[r[s][1]] * w;
            od;
        od;

        E[k] := A-B;
    od;
    #C!.relma := E;
    return E;
end;

##
## lift inducible pair to an automorphism
##
LiftAutoCG := function( C, R, tup )
    local G, n, d, l, h, k, f, i, a, b, v, F, j, c, s, L, m;

    # get info
    G := C!.group;
    n := Length( C.factor );
    d := Length( C.normal );
    l := Length( C.enumrels );
    h := C!.full;
    k := [];
    f := Pcp( Source( tup[2] ) );
    # set up
    for i in [1..n] do
        k[i] := MappedVector( Exponents( Image( tup[2], f[i] ) ), C.factor );
    od;
    for i in [1..d] do
        k[n+i] := MappedVector( tup[1][i], C.normal );
    od;

    # the trivial case
    if n = 0 then
        a := GroupHomomorphismByImagesNC( G, G, h, k );
        SetIsBijective( a, true );
        return a;
    fi;

    # tail
    a := List( C.enumrels, x -> TailOfRelator( C, C.normal, k, x[1], x[2] ) );
    b := List( C.enumrels, x -> TailOfRelator( C, C.normal, h, x[1], x[2] )*tup[1] );
    v := Concatenation( b-a );

    # relator mat
    F := NullMat( n*d, l*d );
    for s in [1..l] do
        for i in [1..n] do
            L := R[s][i]^tup[1];
            for j in [1..d] do
                for m in [1..d] do
                    F[d*(i-1)+j][d*(s-1)+m] := L[j][m];
                od;
            od;
        od;
    od;

    # solve
    c := SolutionIntMat( F, v );
    c := CutVector( c, n );

    # add correction
    for i in [1..n] do
        k[i] := k[i]*MappedVector( c[i], C.normal );
    od;

    # construct homomorphism
    a := GroupHomomorphismByImagesNC( G, G, h, k );
    SetIsBijective( a, true );
    return a;
end;


##
## compute inducible pairs from compatible pairs as a stabilizer with
## finite index
##
InduciblePairsCG := function( C )
    local M, F, iso, N, s, t, c, tup, cf, act, stab, D, sub, l, R;

    M := Group( C.mats, C.one );
    if DimensionOfMatrixGroup( M ) = 1 then
        N := Group( [ [ [ -1 ] ] ] );
    else
        N := NormalizerInGLnZ( M );
    fi;

    if Size( N ) = infinity then
        return fail;
    elif Size( N ) = Size( M ) then
        return [ IdentityMapping( C!.group ) ];
    fi;

    # natural isomorphism from M to F := G/T
    F := PcpGroupByPcp( C.factor );
    iso := GroupHomomorphismByImagesNC( M, F, C.mats, Igs( F ) );
    SetIsBijective( iso, true );

    s := MakeCompatiblePairsCG( iso, N );
    t := MakeCompatiblePairsCG( iso, M );

    # turn com into group
    D := Group( s );
    sub := Group( t );

    cf := TwoCohomologyCR( C ).factor;
    cf.full := Concatenation( cf.prei, cf.denom );

    # find expression of c with respect to basis of cc
    if Length( cf.full ) = 0 then
        c := [];
    else
        c := List( C.enumrels, x -> TailOfRelator( C, C.normal, C.factor, x[1], x[2] ) );
        l := SolutionIntMat( cf.full, Concatenation( c ) ){[ 1..Length( cf.prei ) ]};
        c := List( [ 1..Length(l) ], x -> l[x] mod cf.rels[x] );
    fi;

    if c = 0*c then
        stab := D;
    else
        # get tuples
        tup := List( s, x -> MatrixOperOfTupleCG( C, cf, x ) );

        if ForAll( tup, x -> x = x^0 ) then
            stab := D;
        else
            # determine stabilizer
            act := function( vec, mat )
                local new, i;
                new := ShallowCopy( vec * mat );
                for i in [ 1..Length( new ) ] do
                    new[i] := new[i] mod cf.rels[i];
                od;
                return new;
            end;
            stab := Stabilizer( D, c, s, tup, act );
        fi;
    fi;

    R := RelatorMatrix( C );
    return List( RightTransversal( stab, sub ), i -> LiftAutoCG( C, R, i ) );
end;


###############################################################################
##
## IsCrystallographic( G )
##
InstallMethod(
    IsCrystallographic,
    "for Pcp Groups",
    [ IsPcpGroup ],
    function ( G )
        local T, N;
        T := FittingSubgroup( G );
        return IsInt( IndexNC( G, T ) ) and IsFreeAbelian( T );
    end
);


###############################################################################
##
## RepresentativesAutomorphismClassesOp( G )
##
InstallMethod(
    RepresentativesAutomorphismClassesOp,
    [ IsPcpGroup ],
    1,
    function( G )
        local C, der, ind;
        if not IsCrystallographic( G ) then TryNextMethod(); fi;
        C := CRRecordBySubgroup( G, FittingSubgroup( G ) );
        C.full := Concatenation( C.factor!.gens, C.normal!.gens );

        ind := InduciblePairsCG( C );
        if IsBool( ind ) then return fail; fi;

        der := DerivationAutosCG( C );

        return ListX( der, ind, \* );
    end
);
