###############################################################################
##
## ReidemeisterSpectrum( G )
##
##  INPUT:
##      G:          group G
##
##  OUTPUT:
##      Spec:       Reidemeister spectrum of G
##
InstallGlobalFunction(
    ReidemeisterSpectrum,
    function( G )
        IsFinite( G );
        IsAbelian( G );
        return ShallowCopy( ReidemeisterSpectrumOp( G ) );
    end
);

###############################################################################
##
## ExtendedReidemeisterSpectrum( G )
##
##  INPUT:
##      G:          group G
##
##  OUTPUT:
##      Spec:       extended Reidemeister spectrum of G
##
InstallGlobalFunction(
    ExtendedReidemeisterSpectrum,
    function( G )
        IsFinite( G );
        IsAbelian( G );
        IsQuasisimpleGroup( G );
        return ShallowCopy( ExtendedReidemeisterSpectrumOp( G ) );
    end
);

###############################################################################
##
## CoincidenceReidemeisterSpectrum( H, G )
##
##  INPUT:
##      H:          group H
##      G:          group G (optional)
##
##  OUTPUT:
##      Spec:       coincidence Reidemeister spectrum of the pair (H,G)
##
##  REMARKS:
##      If G is omitted, it is assumed to be equal to H.
##
InstallGlobalFunction(
    CoincidenceReidemeisterSpectrum,
    function( H, arg... )
        local G;
        IsFinite( H );
        IsAbelian( H );
        if Length( arg ) = 0 or IsIdenticalObj( H, arg[ 1 ] ) then
            IsQuasisimpleGroup( H );
            return ShallowCopy( CoincidenceReidemeisterSpectrumOp( H ) );
        else
            G := arg[ 1 ];
            IsTrivial( G );
            IsFinite( G );
            IsAbelian( G );
            return ShallowCopy( CoincidenceReidemeisterSpectrumOp( H, G ) );
        fi;
    end
);

###############################################################################
##
## TotalReidemeisterSpectrum( G )
##
##  INPUT:
##      G:          group G
##
##  OUTPUT:
##      Spec:       total Reidemeister spectrum of G
##
InstallGlobalFunction(
    TotalReidemeisterSpectrum,
    function( G )
        IsFinite( G );
        IsAbelian( G );
        return ShallowCopy( TotalReidemeisterSpectrumOp( G ) );
    end
);

###############################################################################
##
## ReidemeisterSpectrumOp( G )
##
##  INPUT:
##      G:          group G
##
##  OUTPUT:
##      Spec:       Reidemeister spectrum of G
##
InstallMethod(
    ReidemeisterSpectrumOp,
    "for finite abelian groups of odd order",
    [ IsGroup and IsFinite and IsAbelian ],
    3,
    function( G )
        local ord;
        ord := Size( G );
        if IsEvenInt( ord ) then TryNextMethod(); fi;
        return DivisorsInt( ord );
    end
);

InstallMethod(
    ReidemeisterSpectrumOp,
    "for finite abelian 2-groups",
    [ IsGroup and IsFinite and IsAbelian ],
    2,
    function( G )
        local ord, pow, inv, m, fac;
        ord := Size( G );
        pow := Log2Int( ord );
        if ord <> 2 ^ pow then TryNextMethod(); fi;
        inv := Collected( AbelianInvariants( G ) );
        inv := ListX( inv, x -> x[ 2 ] = 1, y -> y[ 1 ] );
        m := 0;
        while not IsEmpty( inv ) do
            fac := Remove( inv, 1 );
            if not IsEmpty( inv ) and fac * 2 = inv[ 1 ] then
                Remove( inv, 1 );
            fi;
            m := m + 1;
        od;
        return List( [ m .. pow ], x -> 2 ^ x );
    end
);

InstallMethod(
    ReidemeisterSpectrumOp,
    "for finite abelian groups",
    [ IsGroup and IsFinite and IsAbelian ],
    1,
    function( G )
        local inv, invE, invO, GE, GO, specE, specO;
        inv := AbelianInvariants( G );
        invE := Filtered( inv, IsEvenInt );
        invO := Filtered( inv, IsOddInt );
        GE := AbelianGroupCons( IsPcGroup, invE );
        GO := AbelianGroupCons( IsPcGroup, invO );
        specE := ReidemeisterSpectrumOp( GE );
        specO := ReidemeisterSpectrumOp( GO );
        return SetX( specE, specO, \* );
    end
);

InstallMethod(
    ReidemeisterSpectrumOp,
    "for finite groups",
    [ IsGroup and IsFinite ],
    0,
    function( G )
        local Aut, gens, conjG, kG, pool, i, id, look, aut, img, cur, p, todo,
              g, j, S, SpecR, s;
        gens := [];
        conjG := ConjugacyClasses( G );
        kG := Length( conjG );
        # Split up conjugacy classes
        pool := DictionaryBySort( true );
        for i in [ 2 .. kG ] do
            id := [
                Size( conjG[ i ] ),
                Order( Representative( conjG[ i ] ) )
            ];
            look := LookupDictionary( pool, id );
            if look = fail then
                AddDictionary( pool, id, [ i ] );
            else
                Add( look, i );
            fi;
        od;
        pool := Filtered( pool, p -> Length( p ) > 1 );
        if IsEmpty( pool ) then
            return [ kG ];
        fi;
        # Calculate induced permutation
        Aut := AutomorphismGroup( G );
        for aut in GeneratorsOfGroup( Aut ) do
            # Skip if automorphism is known to be inner
            if (
                HasIsInnerAutomorphism( aut ) and
                IsInnerAutomorphism( aut )
            ) then
                continue;
            fi;
            img := [];
            cur := 0;
            for p in pool do
                # If small enough, this is more efficient time-wise
                if Size( conjG[ p[ 1 ] ] ) < 1000 then
                    Perform( p, i -> AsSSortedList( conjG[ i ] ) );
                fi;
                todo := [ 1 .. Length( p ) ];
                for i in [ 1 .. Length( p ) - 1 ] do
                    g := ImagesRepresentative(
                        aut,
                        Representative( conjG[ p[ i ] ] )
                    );
                    for j in todo do
                        if g in conjG[ p[ j ] ] then
                            Add( img, j + cur );
                            RemoveSet( todo, j );
                            break;
                        fi;
                    od;
                od;
                # Final class is now uniquely determined
                Add( img, todo[ 1 ] + cur );
                cur := cur + Length( p );
            od;
            AddSet( gens, PermList( img ) );
        od;
        # Group of permutations on conjugacy classes
        S := Group( gens, () );
        SpecR := [];
        for s in ConjugacyClasses( S ) do
            AddSet( SpecR, kG - NrMovedPoints( Representative( s ) ) );
        od;
        return SpecR;
    end
);

###############################################################################
##
## ExtendedReidemeisterSpectrumOp( G )
##
##  INPUT:
##      G:          group G
##
##  OUTPUT:
##      Spec:       extended Reidemeister spectrum of G
##
InstallMethod(
    ExtendedReidemeisterSpectrumOp,
    "for finite quasisimple groups",
    [ IsQuasisimpleGroup and IsFinite ],
    G -> UnionSet( ReidemeisterSpectrumOp( G ), [ 1 ] )
);

InstallMethod(
    ExtendedReidemeisterSpectrumOp,
    "for finite abelian groups",
    [ IsGroup and IsFinite and IsAbelian ],
    G -> DivisorsInt( Size( G ) )
);

InstallMethod(
    ExtendedReidemeisterSpectrumOp,
    "for non-2-generated finite soluble groups",
    [ IsGroup and IsFinite and IsSolubleGroup ],
    function( G )
        local Spec, Aut, norms, orbs, orb, N, comps;
        if Length( SmallGeneratingSet( G ) ) <= 2 then TryNextMethod(); fi;
        Spec := ShallowCopy( ReidemeisterSpectrumOp( G ) );
        AddSet( Spec, 1 );
        Aut := AutomorphismGroup( G );
        norms := Filtered(
            NormalSubgroups( G ),
            N -> not IsTrivial( N ) and N <> G
        );
        orbs := OrbitsDomain( Aut, norms, { N, aut } -> ImagesSet( aut, N ) );
        for orb in orbs do
            N := orb[ 1 ];
            comps := COComplementsMain( G, N, false, false );
            if not IsEmpty( comps ) then
                UniteSet(
                    Spec,
                    ReidemeisterSpectrum( comps[ 1 ].complement )
                );
            fi;
        od;
        return Spec;
    end
);

InstallMethod(
    ExtendedReidemeisterSpectrumOp,
    "for finite groups",
    [ IsGroup and IsFinite ],
    function( G )
        local Spec;
        Spec := ShallowCopy( ReidemeisterSpectrumOp( G ) );
        UniteSet( Spec, List(
            RepresentativesEndomorphismClasses( G, false ),
            ReidemeisterNumberOp
        ) );
        return Spec;
    end
);

###############################################################################
##
## CoincidenceReidemeisterSpectrumOp( H, G )
##
##  INPUT:
##      H:          group H
##      G:          group G (optional)
##
##  OUTPUT:
##      Spec:       coincidence Reidemeister spectrum of the pair (H,G)
##
##  REMARKS:
##      If G is omitted, it is assumed to be equal to H.
##
InstallMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for trivial range",
    [ IsGroup, IsGroup and IsTrivial ],
    { _H, _G } -> [ 1 ]
);

InstallMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for finite abelian range",
    [ IsGroup and IsFinite, IsGroup and IsFinite and IsAbelian ],
    function( H, G )
        local abInvH, abInvG, p, partsH, partsG, M, i;
        abInvH := Reversed( SortedList( AbelianInvariants( H ) ) );
        if IsEmpty( abInvH ) then
            return [ Size( G ) ];
        fi;
        abInvG := Reversed( SortedList( AbelianInvariants( G ) ) );
        M := 1;
        for p in Set( abInvG, SmallestRootInt ) do
            partsH := Filtered( abInvH, n -> n mod p = 0 );
            partsG := Filtered( abInvG, n -> n mod p = 0 );
            for i in [ 1 .. Minimum( Length( partsH ), Length( partsG ) ) ] do
                M := M * Minimum( partsH[ i ], partsG[ i ] );
            od;
        od;
        return List( DivisorsInt( M ), d -> Size( G ) / M * d );
    end
);

InstallMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for distinct finite groups",
    [ IsGroup and IsFinite, IsGroup and IsFinite ],
    function( H, G )
        local homs, ccG, ccH, sizesG, sizesH, repsH, Spec, R;
        homs := RepresentativesHomomorphismClasses( H, G );
        ccG := List( ConjugacyClasses( G ), AsSSortedList );
        ccH := List( ConjugacyClasses( H ) );
        sizesG := List( ccG, Length );
        sizesH := List( ccH, Size );
        repsH := List( ccH, Representative );
        Spec := TWC.CoinSpec( homs, ccG, repsH, sizesG, sizesH );
        return Set( Spec, R -> Size( G ) / Size( H ) * R );
    end
);

InstallOtherMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for a finite quasisimple group to itself",
    [ IsQuasisimpleGroup and IsFinite ],
    G -> UnionSet( ExtendedReidemeisterSpectrumOp( G ), [ Size( G ) ] )
);

InstallOtherMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for a finite abelian group to itself",
    [ IsGroup and IsFinite and IsAbelian ],
    ExtendedReidemeisterSpectrumOp
);

InstallOtherMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for a finite group to itself",
    [ IsGroup and IsFinite ],
    function( G )
        local homs, ccG, sizesG, repsG;
        homs := RepresentativesEndomorphismClasses( G );
        ccG := List( ConjugacyClasses( G ), AsSSortedList );
        repsG := List( ccG, First );
        sizesG := List( ccG, Length );
        return TWC.CoinSpec( homs, ccG, repsG, sizesG, sizesG );
    end
);

###############################################################################
##
## TotalReidemeisterSpectrumOp( G )
##
##  INPUT:
##      G:          group G
##
##  OUTPUT:
##      Spec:       total Reidemeister spectrum of G
##
InstallMethod(
    TotalReidemeisterSpectrumOp,
    "for finite abelian groups",
    [ IsGroup and IsFinite and IsAbelian ],
    G -> DivisorsInt( Size( G ) )
);

InstallMethod(
    TotalReidemeisterSpectrumOp,
    "for finite groups",
    [ IsGroup and IsFinite ],
    function( G )
        local GxG, l, r, act, D, Spec, points, c;
        GxG := DirectProduct( G, G );
        l := Projection( GxG, 1 );
        r := Projection( GxG, 2 );
        act := { g, p } -> ImagesRepresentative( l, p ) ^ -1 * g *
            ImagesRepresentative( r, p );
        D := Range( ActionHomomorphism( GxG, AsSet( G ), act, "surjective" ) );
        Spec := [];
        points := [ 1 .. Size( G ) ];
        for c in ConjugacyClassesSubgroups( D ) do
            AddSet( Spec, Length( OrbitsDomain( Representative( c ), points ) ) );
        od;
        return Spec;
    end
);
