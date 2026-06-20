###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##
##  OUTPUT:
##      R:          Reidemeister number R(hom1,hom2)
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
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##
##  OUTPUT:
##      R:          Reidemeister number R(hom1,hom2)
##
InstallMethod(
    ReidemeisterNumberOp,
    "for finite source and infinite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    4,
    function( hom1, _ )
        local G, H;
        H := Source( hom1 );
        G := Range( hom1 );
        if IsFinite( G ) or not IsFinite( H ) then TryNextMethod(); fi;
        return infinity;
    end
);

InstallMethod(
    ReidemeisterNumberOp,
    "for abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    2,
    function( hom1, hom2 )
        local G, H, diff, N;
        H := Source( hom1 );
        G := Range( hom1 );
        if not IsAbelian( G ) then TryNextMethod(); fi;
        diff := TWC.DifferenceGroupHomomorphisms( hom1, hom2, H, G );
        N := Image( diff );
        return IndexNC( G, N );
    end
);

InstallMethod(
    ReidemeisterNumberOp,
    "for finite source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    1,
    function( hom1, hom2 )
        local H, G, ccH, ccG, kH, kG, preimgs, sizesH, sizesG, repsH, hom, L,
              i, j, k, I, R;
        H := Source( hom1 );
        G := Range( hom1 );
        if not ( IsFinite( G ) and IsFinite( H ) ) then TryNextMethod(); fi;
        # Inefficient if G <> H and we have to calculate conjugacy classes
        if G <> H and (
            not ( HasConjugacyClasses( G ) and HasConjugacyClasses( H ) )
        ) then TryNextMethod(); fi;

        ccH := List( ConjugacyClasses( H ) );
        ccG := List( ConjugacyClasses( G ) );
        kH := Length( ccH );
        kG := Length( ccG );

        preimgs := [];
        sizesH := List( ccH, Size );
        sizesG := List( ccG, Size );
        repsH := List( ccH, Representative );

        for hom in [ hom1, hom2 ] do
            L := List( [ 1 .. kG ], x -> [] );
            for i in [ 1 .. kH ] do
                j := First(
                    [ 1 .. kG ],
                    k -> ImagesRepresentative( hom, repsH[ i ] )
                        in AsList( ccG[ k ] )
                );
                AddSet( L[ j ], i );
            od;
            Add( preimgs, L );
        od;

        R := 0;
        for k in [ 1 .. kG ] do
            I := IntersectSet( preimgs[ 1 ][ k ], preimgs[ 2 ][ k ] );
            R := R + Sum( I, i -> sizesH[ i ] ) / sizesG[ k ];
        od;
        return Size( G ) / Size( H ) * R;
    end
);

InstallMethod(
    ReidemeisterNumberOp,
    "by counting Reidemeister classes",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    0,
    function( hom1, hom2 )
        local G, Rcl;
        G := Range( hom1 );
        Rcl := RepresentativesTwistedConjugacyClassesOp(
            hom1, hom2, G, false
        );
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
        return Number(
            ConjugacyClasses( G ),
            c -> ImagesRepresentative(
                endo,
                Representative( c )
            ) in AsSSortedList( c )
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
