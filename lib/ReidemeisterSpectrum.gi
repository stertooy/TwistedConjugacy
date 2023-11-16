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
        local Aut, gens, conjG, kG, aut, img, i, g, j, S, conjS, c, s, SpecR;
        Aut := AutomorphismGroup( G );
        gens := [];
        conjG := ConjugacyClasses( G );
        kG := Length( conjG );
        SpecR := [];
        for aut in GeneratorsOfGroup( Aut ) do
            if (
                HasIsInnerAutomorphism( aut ) and 
                IsInnerAutomorphism( aut ) 
            ) then
                continue;
            fi;
            img := [];
            for i in [1..kG] do
                g := Representative( conjG[i] );
                for j in [1..kG] do
                    if ImagesRepresentative( aut, g ) in conjG[j] then
                        Add( img, j );
                        break;
                    fi;
                od;
            od;
            AddSet( gens, PermList( img ) );
        od;
        S := Group( gens, () );
        conjS := ConjugacyClasses( S );
        for c in conjS do
            s := Representative( c );
            AddSet( SpecR, kG - NrMovedPoints( s ) );
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
