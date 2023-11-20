###############################################################################
##
## ReidemeisterSpectrum( G )
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
## ReidemeisterSpectrumOp( G )
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
        if ord <> 2^pow then TryNextMethod(); fi;
        inv := Collected( AbelianInvariants( G ) );
        inv := ListX( inv, x -> x[2] = 1, y -> y[1] );
        m := 0;
        while not IsEmpty( inv ) do
            fac := Remove( inv, 1 );
            if not IsEmpty( inv ) and fac*2 = inv[1] then
                Remove( inv, 1 );
            fi;
            m := m+1;
        od;
        return List( [m..pow], x -> 2^x );
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
        local Aut, gens, conjG, kG, aut, img, todo, i, g, j, S, s, SpecR,
              sizes, filt, cur, c, pool, id,look,p;
        Aut := AutomorphismGroup( G );
        gens := [];
        SpecR := [];
        # Split up conjugacy classes in sizes
        conjG := ConjugacyClasses( G );
        kG := Length( conjG );
        sizes := [];
        
        pool := NewDictionary( [1,2], true );
        for i in [2..kG] do
            c := conjG[i];
            id := [ Size( c ), Order( Representative( c ) ) ];
            look := LookupDictionary( pool, id );
            if look = fail then
                AddDictionary( pool, id, [i] );
            else
                Add( look, i );
            fi;
        od;
        #Print(pool);
        #for p in pool do
        #    Print(p," ",LookupDictionary(pool,p),"\n");
        #od;
        #return pool;
        
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
                #Print(List(s,x->Order(Representative(x))),"\n");
                # If small enough, this is more efficient time-wise
                if Size(conjG[p[1]]) < 1000 then
                    Perform( p, i-> AsSSortedList(conjG[i]) );
                fi;
                todo := [1..Length(p)];
                for i in [1..Length(p)-1] do
                    g := ImagesRepresentative( aut, Representative( conjG[p[i]] ) );
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
                cur := cur + Length(p);
            od;
            AddSet( gens, PermList( img ) );
        od;
        # Group of permutations on non-identity conjugacy classes
        S := Group( gens, () );
        for s in ConjugacyClasses( S ) do
            AddSet( SpecR, kG - NrMovedPoints( Representative( s ) ) );
        od;
        return SpecR;
    end
);


###############################################################################
##
## ExtendedReidemeisterSpectrum( G )
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
## ExtendedReidemeisterSpectrumOp( G )
##
InstallMethod(
    ExtendedReidemeisterSpectrumOp,
    "for finite abelian groups",
    [ IsGroup and IsFinite and IsAbelian ],
    function( G )
        return DivisorsInt( Size( G ) );
    end
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
## CoincidenceReidemeisterSpectrum( H, ... )
##
InstallGlobalFunction(
    CoincidenceReidemeisterSpectrum,
    function( H, arg... )
        local G;
        IsFinite( H );
        IsAbelian( H );
        if Length( arg ) = 0 then
            if IsAbelian( H ) then
                return ExtendedReidemeisterSpectrumOp( H );
            else
                return CoincidenceReidemeisterSpectrumOp( H );
            fi;
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
## CoincidenceReidemeisterSpectrum( H, G )
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
        local Hom_reps;
        Hom_reps := RepresentativesHomomorphismClasses( H, G );
        return SetX( Hom_reps, Hom_reps, ReidemeisterNumberOp );
    end
);

InstallOtherMethod(
    CoincidenceReidemeisterSpectrumOp,
    "for finite group to itself",
    [ IsGroup and IsFinite ],
    function( G )
        local Hom_reps, SpecR, hom1, hom2, R;
        Hom_reps := RepresentativesEndomorphismClasses( G );
        return SetX( Hom_reps, Hom_reps, ReidemeisterNumberOp );
    end
);
