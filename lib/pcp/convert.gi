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
    "turn finite PcpGroup range into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    101,
    function( hom1, hom2 )
        local G, iso;
        G := Range( hom1 );
        if not (
            IsPcpGroup( G ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        iso := IsomorphismPcGroup( G );
        return CoincidenceGroup2( hom1 * iso, hom2 * iso );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "turn finite PcpGroup source into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    100,
    function( hom1, hom2 )
        local H, inv;
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( H )
        ) then TryNextMethod(); fi;
        inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
        return ImagesSet( inv, CoincidenceGroup2( inv * hom1, inv * hom2 ) );
    end
);

###############################################################################
##
## RepresentativesReidemeisterClassesOp( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class, or fail if there are infinitely
##                  many
##
InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "turn finite PcpGroup range into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    101,
    function( hom1, hom2, N, one )
        local G, iso, Rcl;
        G := Range( hom1 );
        if not (
            IsPcpGroup( G ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        iso := IsomorphismPcGroup( G );
        Rcl := RepresentativesReidemeisterClassesOp(
            hom1 * iso, hom2 * iso,
            ImagesSet( iso, N ), one
        );
        if Rcl = fail then
            return fail;
        fi;
        return List( Rcl, g -> PreImagesRepresentativeNC( iso, g ) );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "turn finite PcpGroup source into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    100,
    function( hom1, hom2, N, one )
        local H, inv;
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( H )
        ) then TryNextMethod(); fi;
        inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
        return RepresentativesReidemeisterClassesOp(
            inv * hom1, inv * hom2, N, one
        );
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
    "turn finite PcpGroup range into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    101,
    function( hom1, hom2 )
        local G, iso;
        G := Range( hom1 );
        if not (
            IsPcpGroup( G ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        iso := IsomorphismPcGroup( G );
        return ReidemeisterNumberOp( hom1 * iso, hom2 * iso );
    end
);

InstallMethod(
    ReidemeisterNumberOp,
    "turn finite PcpGroup source into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    100,
    function( hom1, hom2 )
        local H, inv;
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( H )
        ) then TryNextMethod(); fi;
        inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
        return ReidemeisterNumberOp( inv * hom1, inv * hom2 );
    end
);

###############################################################################
##
## RepresentativeTwistedConjugationOp( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g1:         element of G
##      g2:         element of G (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * g_1 * h^hom1 = g_2, or
##                  fail if no such element exists
##
##  REMARKS:
##      If no g2 is given, it is assumed to be 1.
##
InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "turn finite PcpGroup range into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    101,
    function( hom1, hom2, g )
        local G, iso;
        G := Range( hom1 );
        if not (
            IsPcpGroup( G ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        iso := IsomorphismPcGroup( G );
        return RepresentativeTwistedConjugationOp(
            hom1 * iso, hom2 * iso,
            ImagesRepresentative( iso, g )
        );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "turn finite PcpGroup source into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    100,
    function( hom1, hom2, g )
        local H, inv, h;
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( H )
        ) then TryNextMethod(); fi;
        inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
        h := RepresentativeTwistedConjugationOp( inv * hom1, inv * hom2, g );
        if h = fail then
            return fail;
        fi;
        return ImagesRepresentative( inv, h );
    end
);
