###############################################################################
##
## CoincidenceGroup2( hom1, hom2 )
##
InstallMethod(
    CoincidenceGroup2,
    "turn finite PcpGroup range into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    101,
    function ( hom1, hom2 )
        local G, iso;
        G := Range( hom1 );
        if not (
            IsPcpGroup( G ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        iso := IsomorphismPcGroup( G );
        return CoincidenceGroup2( hom1*iso, hom2*iso );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "turn finite PcpGroup source into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    100,
    function ( hom1, hom2 )
        local H, inv;
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( H )
        ) then TryNextMethod(); fi;
        inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
        return ImagesSet( inv, CoincidenceGroup2( inv*hom1, inv*hom2 ) );
    end
);


###############################################################################
##
## RepresentativesReidemeisterClasses( hom1, hom2 )
##
InstallMethod(
    RepresentativesReidemeisterClasses,
    "turn finite PcpGroup range into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    101,
    function ( hom1, hom2 )
        local G, iso, Rcl;
        G := Range( hom1 );
        if not (
            IsPcpGroup( G ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        iso := IsomorphismPcGroup( G );
        Rcl := RepresentativesReidemeisterClasses( hom1*iso, hom2*iso );
        return List( Rcl, g -> PreImagesRepresentative( iso, g ) );
    end
);

InstallMethod(
    RepresentativesReidemeisterClasses,
    "turn finite PcpGroup source into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    100,
    function ( hom1, hom2 )
        local H, inv, Rcl;
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( H )
        ) then TryNextMethod(); fi;
        inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
        return RepresentativesReidemeisterClasses( inv*hom1, inv*hom2 );
    end
);


###############################################################################
##
## ReidemeisterNumberOp( hom1, hom2 )
##
InstallMethod(
    ReidemeisterNumberOp,
    "turn finite PcpGroup range into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    101,
    function ( hom1, hom2 )
        local G, iso;
        G := Range( hom1 );
        if not (
            IsPcpGroup( G ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        iso := IsomorphismPcGroup( G );
        return ReidemeisterNumberOp( hom1*iso, hom2*iso );
    end
);

InstallMethod(
    ReidemeisterNumberOp,
    "turn finite PcpGroup source into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    100,
    function ( hom1, hom2 )
        local H, inv;
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( H )
        ) then TryNextMethod(); fi;
        inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
        return ReidemeisterNumberOp( inv*hom1, inv*hom2 );
    end
);


###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod(
    RepTwistConjToId,
    "turn finite PcpGroup range into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    101,
    function ( hom1, hom2, g )
        local G, iso;
        G := Range( hom1 );
        if not (
            IsPcpGroup( G ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        iso := IsomorphismPcGroup( G );
        return RepTwistConjToId(
            hom1*iso, hom2*iso,
            ImagesRepresentative( iso, g )
        );
    end
);

InstallMethod(
    RepTwistConjToId,
    "turn finite PcpGroup source into PcGroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    100,
    function ( hom1, hom2, g )
        local H, inv, h;
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( H )
        ) then TryNextMethod(); fi;
        inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
        h := RepTwistConjToId( inv*hom1, inv*hom2, g );
        if h = fail then
            return fail;
        fi;
        return ImagesRepresentative( inv, h );
    end
);
