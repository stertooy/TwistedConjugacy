###############################################################################
##
## ReidemeisterNumber( hom1, arg... )
##
InstallGlobalFunction(
    ReidemeisterNumber,
    function( arg... )
        return CallFuncList( ReidemeisterNumberOp, arg );
    end
);


###############################################################################
##
## ReidemeisterNumberOp( hom1, hom2 )
##
InstallMethod(
    ReidemeisterNumberOp,
    "for polycyclic-by-finite source and nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    2,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPolycyclicByFinite( H ) and
            IsPolycyclicByFinite( G ) and 
            IsNilpotentByFinite( G ) and
            HirschLength( H ) < HirschLength( G )
        ) then TryNextMethod(); fi;
        return infinity;
    end
);

InstallMethod(
    ReidemeisterNumberOp,
    "for abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    1,
    function( hom1, hom2 )
        local G, H, diff, N;
        H := Source( hom1 );
        G := Range( hom1 );
        if not IsAbelian( G ) then TryNextMethod(); fi;
        diff := DifferenceGroupHomomorphisms@( hom1, hom2, H, G );
        N := Image( diff );
        return IndexNC( G, N );
    end
);

InstallMethod(
    ReidemeisterNumberOp,
    "by counting Reidemeister classes",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    0,
    function( hom1, hom2 )
        local Rcl;
        Rcl := RepresentativesReidemeisterClasses( hom1, hom2 );
        if Rcl <> fail then
            return Size( Rcl );
        fi;
        return infinity;
    end
);

InstallOtherMethod(
    ReidemeisterNumberOp,
    "for finite non-abelian groups",
    [ IsGroupHomomorphism ],
    1,
    function( endo )
        local G;
        G := Source( endo );
        if not (
            IsFinite( G ) and
            not IsAbelian( G )
        ) then TryNextMethod(); fi;
        # Todo: make help function "ConjugacyClassPool" using code from ReidemeisterSpectrum?
        # Only check within pools
        return Number(
            ConjugacyClasses( G ),
            c -> ImagesRepresentative(
                endo,
                Representative( c )
            ) in AsList( c )
        );
    end
);

InstallOtherMethod(
    ReidemeisterNumberOp,
    "default to two-agument version",
    [ IsGroupHomomorphism ],
    0,
    function( endo )
        local G, id;
        G := Source( endo );
        id := IdentityMapping( G );
        return ReidemeisterNumberOp( endo, id );
    end
);
