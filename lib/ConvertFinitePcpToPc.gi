###############################################################################
##
## CoincidenceGroup( hom1, hom2 )
##
InstallMethod(
	CoincidenceGroup,
	"for finite pcp range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	101,
	function ( hom1, hom2 )
		local G, iso;
		G := Range( hom1 );
		if (
			not IsPcpGroup(G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		return CoincidenceGroup( hom1*iso, hom2*iso );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for finite pcp source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	100,
	function ( hom1, hom2 )
		local H, iso;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		iso := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		return Image( iso, CoincidenceGroup( iso*hom1, iso*hom2 ) );
	end
);


###############################################################################
##
## FixedPointGroup( endo )
##
InstallMethod(
	FixedPointGroup,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
	function ( endo )
		local G, iso, inv;
		G := Range( endo );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		inv := InverseGeneralMapping( iso );
		return Image( inv, FixedPointGroup( inv*endo*iso ) );
	end
);


###############################################################################
##
## ReidemeisterClasses( hom1, hom2 )
##
InstallMethod(
	ReidemeisterClasses,
	"for finite pcp range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	101,
	function ( hom1, hom2 )
		local G, iso, Rcl;
		G := Range( hom1 );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		Rcl := ReidemeisterClasses( hom1*iso, hom2*iso );
		return List( Rcl, tcc -> ReidemeisterClass(
			hom1, hom2,
			PreImagesRepresentative( iso, Representative( tcc ) )
		));
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for finite pcp source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	100,
	function ( hom1, hom2 )
		local H, iso, Rcl;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		iso := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		Rcl := ReidemeisterClasses( iso*hom1, iso*hom2 );
		if Rcl = fail then
			return fail;
		fi;
		return List( Rcl, tcc -> ReidemeisterClass(
			hom1, hom2,
			Representative( tcc )
		));
	end
);


###############################################################################
##
## ReidemeisterClasses( endo )
##
InstallOtherMethod(
	ReidemeisterClasses,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
	function ( endo )
		local G, iso, inv, Rcl;
		G := Range( endo );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		inv := InverseGeneralMapping( iso );
		Rcl := ReidemeisterClasses( inv*endo*iso );
		return List( Rcl, tcc -> ReidemeisterClass(
			endo,
			PreImagesRepresentative( iso, Representative( tcc ) )
		));
	end
);


###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumber,
	"for finite pcp range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	101,
	function ( hom1, hom2 )
		local G, iso;
		G := Range( hom1 );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		return ReidemeisterNumber( hom1*iso, hom2*iso );
	end
);

InstallMethod(
	ReidemeisterNumber,
	"for finite pcp source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	100,
	function ( hom1, hom2 )
		local H, iso;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		iso := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		return ReidemeisterNumber( iso*hom1, iso*hom2 );
	end
);


###############################################################################
##
## ReidemeisterNumber( endo )
##
InstallOtherMethod(
	ReidemeisterNumber,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	101,
	function ( endo )
		local G, iso;
		G := Range( endo );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		return ReidemeisterNumber( InverseGeneralMapping( iso ) * endo * iso );
	end
);


###############################################################################
##
## RepresentativeTwistedConjugation( hom1, hom2, g1, g2 )
##
InstallMethod(
	RepresentativeTwistedConjugation,
	"for finite pcp range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	101,
	function ( hom1, hom2, g1, g2 )
		local G, iso;
		G := Range( hom1 );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		return RepresentativeTwistedConjugation(
			hom1*iso, hom2*iso,
			g1^iso, g2^iso
		);
	end
);

InstallMethod(
	RepresentativeTwistedConjugation,
	"for finite pcp source",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	100,
	function ( hom1, hom2, g1, g2 )
		local H, iso, h;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		iso := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		h := RepresentativeTwistedConjugation( iso*hom1, iso*hom2, g1, g2 );
		if h = fail then
			return fail;
		fi;
		return h^iso;
	end
);


###############################################################################
##
## IsTwistedConjugate( endo, g1, g2 )
##
InstallOtherMethod(
	IsTwistedConjugate,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	100,
	function ( endo, g1, g2 )
		local G, iso;
		G := Range( endo );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		return IsTwistedConjugate(
			InverseGeneralMapping( iso ) * endo * iso,
			g1^iso, g2^iso
		);
	end
);


###############################################################################
##
## RepresentativeTwistedConjugation( endo, g1, g2 )
##
InstallOtherMethod(
	RepresentativeTwistedConjugation,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	100,
	function ( endo, g1, g2 )
		local G, iso, inv, h;
		G := Range( endo );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		inv := InverseGeneralMapping( iso );
		h := RepresentativeTwistedConjugation(
			inv * endo * iso,
			g1^iso, g2^iso
		);
		if h = fail then
			return fail;
		fi;
		return h^inv;
	end
);
