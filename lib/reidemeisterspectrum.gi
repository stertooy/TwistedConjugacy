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
        return ReidemeisterSpectrumOp( G );
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
        return ExtendedReidemeisterSpectrumOp( G );
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
        if Length( arg ) = 0 then
            return CoincidenceReidemeisterSpectrumOp( H );
        else
            G := arg[1];
            IsFinite( G );
            IsAbelian( G );
            return CoincidenceReidemeisterSpectrumOp( H, G );
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
        return TotalReidemeisterSpectrumOp( G );
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
        inv := ListX( inv, x -> x[2] = 1, y -> y[1] );
        m := 0;
        while not IsEmpty( inv ) do
            fac := Remove( inv, 1 );
            if not IsEmpty( inv ) and fac * 2 = inv[1] then
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
        Aut := AutomorphismGroup( G );
        gens := [];
        conjG := ConjugacyClasses( G );
        kG := Length( conjG );
        # Split up conjugacy classes
        pool := DictionaryBySort( true );
        for i in [ 2 .. kG ] do
            id := [ Size( conjG[i] ), Order( Representative( conjG[i] ) ) ];
            look := LookupDictionary( pool, id );
            if look = fail then
                AddDictionary( pool, id, [i] );
            else
                Add( look, i );
            fi;
        od;
        # Calculate induced permutation
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
                if Size( conjG[p[1]] ) < 1000 then
                    Perform( p, i -> AsSSortedList( conjG[i] ) );
                fi;
                todo := [ 1 .. Length( p ) ];
                for i in [ 1 .. Length( p ) - 1 ] do
                    g := ImagesRepresentative(
                        aut,
                        Representative( conjG[p[i]] )
                    );
                    for j in todo do
                        if g in conjG[p[j]] then
                            Add( img, j + cur );
                            RemoveSet( todo, j );
                            break;
                        fi;
                    od;
                od;
                # Final class is now uniquely determined
                Add( img, todo[1] + cur );
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
    "for finite abelian groups",
    [ IsGroup and IsFinite and IsAbelian ],
    G -> DivisorsInt( Size( G ) )
);

InstallMethod(
    ExtendedReidemeisterSpectrumOp,
    "for finite groups",
    [ IsGroup and IsFinite ],
    function( G )
        return Set(
            RepresentativesEndomorphismClasses( G ),
            ReidemeisterNumberOp
        );
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
InstallMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for finite abelian range",
    [ IsGroup and IsFinite, IsGroup and IsFinite and IsAbelian ],
    function( H, G )
        local Hom_reps, hom1;
        Hom_reps := RepresentativesHomomorphismClasses( H, G );
        hom1 := Hom_reps[1];
        return Set( Hom_reps, hom2 -> ReidemeisterNumberOp( hom1, hom2 ) );
    end
);

InstallMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for distinct finite groups",
    [ IsGroup and IsFinite, IsGroup and IsFinite ],
    function( H, G )
        local Hom_reps, SpecR, n, i, j;
        Hom_reps := RepresentativesHomomorphismClasses( H, G );
        SpecR := [];
        n := Length( Hom_reps );
        for i in [ 1 .. n ] do
            for j in [ i .. n ] do
                AddSet(
                    SpecR,
                    ReidemeisterNumberOp( Hom_reps[i], Hom_reps[j] )
                );
            od;
        od;
        return SpecR;
    end
);

InstallOtherMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for finite abelian group to itself",
    [ IsGroup and IsFinite and IsAbelian ],
    ExtendedReidemeisterSpectrumOp
);

InstallOtherMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for finite group to itself",
    [ IsGroup and IsFinite ],
    function( G )
        local Hom_reps, SpecR, n, i, j;
        Hom_reps := RepresentativesEndomorphismClasses( G );
        SpecR := [];
        n := Length( Hom_reps );
        for i in [ 1 .. n ] do
            for j in [ i .. n ] do
                AddSet(
                    SpecR,
                    ReidemeisterNumberOp( Hom_reps[i], Hom_reps[j] )
                );
            od;
        od;
        return SpecR;
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
        local GxG, l, r, Spec, H, hom1, hom2;
        GxG := DirectProduct( G, G );
        l := Projection( GxG, 1 );
        r := Projection( GxG, 2 );
        Spec := [];
        for H in List( ConjugacyClassesSubgroups( GxG ), Representative ) do
            hom1 := RestrictedHomomorphism( l, H, G );
            hom2 := RestrictedHomomorphism( r, H, G );
            AddSet( Spec, ReidemeisterNumber( hom1, hom2 ) );
        od;
        return Spec;
    end
);
