###############################################################################
##
## ReidemeisterNumber( hom1, arg... )
##
InstallGlobalFunction(
    ReidemeisterNumber,
    function ( arg... )
        return CallFuncList( ReidemeisterNumberOp, arg );
    end
);


###############################################################################
##
## ReidemeisterNumberOp( hom1, hom2 )
##
InstallMethod(
    ReidemeisterNumberOp,
    "for abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    1,
    function ( hom1, hom2 )
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
    function ( hom1, hom2 )
        local Rcl;
        Rcl := RepresentativesReidemeisterClasses( hom1, hom2 );
        if Rcl <> fail then
            return Size( Rcl );
        else
            return infinity;
        fi;
    end
);

InstallOtherMethod(
    ReidemeisterNumberOp,
    "for finite non-abelian groups",
    [ IsGroupHomomorphism ],
    1,
    function ( endo )
        local G;
        G := Source( endo );
        if not (
            IsFinite( G ) and
            not IsAbelian( G )
        ) then TryNextMethod(); fi;
        return Number(
            ConjugacyClasses( G ),
            c -> ImagesRepresentative( endo, Representative( c ) ) in AsList( c )
        );
    end
);

InstallOtherMethod(
    ReidemeisterNumberOp,
    "default to two-agument version",
    [ IsGroupHomomorphism ],
    0,
    function ( endo )
        local G, id;
        G := Source( endo );
        id := IdentityMapping( G );
        return ReidemeisterNumberOp( endo, id );
    end
);
