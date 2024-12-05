###############################################################################
##
## FixedPointGroup( endo )
##
##  INPUT:
##      endo:       group endomorphism G -> G
##
##  OUTPUT:
##      fix:        subgroup of G consisting of g for which g^phi = g
##
InstallGlobalFunction(
    FixedPointGroup,
    function( endo )
        local G;
        G := Range( endo );
        return CoincidenceGroup( endo, IdentityMapping( G ) );
    end
);


###############################################################################
##
## CoincidenceGroup( hom1, hom2, arg... )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      ...
##      homN:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which
##                  h^hom1 = h^hom2 = ... = h^homN
##
InstallGlobalFunction(
    CoincidenceGroup,
    function( hom1, hom2, arg... )
        local G, H, Coin, new, homi, h, imgs;
        G := Range( hom1 );
        Coin := CoincidenceGroup2( hom1, hom2 );
        for homi in arg do
            new := CoincidenceGroup2(
                RestrictedHomomorphism( hom1, Coin, G ),
                RestrictedHomomorphism( homi, Coin, G )
            );
            Coin := new;
        od;
        if ASSERT@ then
            arg := Concatenation( [ hom1 ], arg );
            for h in GeneratorsOfGroup( Coin ) do
                imgs := [];
                for homi in arg do
                    AddSet( imgs, ImagesRepresentative( homi, h ) );
                od;
                if Length( imgs ) > 1 then Error("Assertion failure"); fi;
            od;
        fi;
        return Coin;
    end
);


###############################################################################
##
## CoincidenceGroup2( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
InstallMethod(
    CoincidenceGroup2,
    "for trivial range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    7,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not IsTrivial( G ) then TryNextMethod(); fi;
        return H;
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    5,
    function( hom1, hom2 )
        local G, H, diff;
        G := Range( hom1 );
        H := Source( hom1 );
        if not IsAbelian( G ) then TryNextMethod(); fi;
        diff := DifferenceGroupHomomorphisms@ ( hom1, hom2, H, G );
        return Kernel( diff );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for finite source",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    4,
    function( hom1, hom2 )
        local G, H, gens, tc;
        G := Range( hom1 );
        H := Source( hom1 );
        if not IsFinite( H ) then TryNextMethod(); fi;
        if CanEasilyComputePcgs( H ) then
            gens := Pcgs( H );
        else
            gens := SmallGeneratingSet( H );
        fi;
        tc := TwistedConjugation( hom1, hom2 );
        return StabilizerOp( H, One( G ), gens, gens, tc );
    end
);
