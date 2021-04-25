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
## ReidemeisterSpectrum( G )
##
InstallMethod(
	ReidemeisterSpectrum, 
	"turn group into SpecialPcGroup",
	[ IsGroup and IsFinite ],
	100,
	function ( G )
		if (
			not IsPcpGroup( G )
		) then
			TryNextMethod();
		fi;
		return ReidemeisterSpectrum( Image( IsomorphismPcGroup( G ) ) );
	end
);


###############################################################################
##
## ExtendedReidemeisterSpectrum( G )
##
InstallMethod(
	ExtendedReidemeisterSpectrum, 
	"turn group into SpecialPcGroup",
	[ IsGroup and IsFinite ],
	100,
	function ( G )
		if (
			not IsPcpGroup( G )
		) then
			TryNextMethod();
		fi;
		return ExtendedReidemeisterSpectrum(
			Image( IsomorphismPcGroup( G ) )
		);
	end
);


###############################################################################
##
## CoincidenceReidemeisterSpectrum( H, G )
##
InstallMethod(
	CoincidenceReidemeisterSpectrum, 
	"for finite pcp range",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	101,
	function ( H, G )
		if (
			not IsPcpGroup( G )
		) then
			TryNextMethod();
		fi;
		return CoincidenceReidemeisterSpectrum(
			H, 
			Image( IsomorphismPcGroup( G ) )
		);
	end
);

InstallMethod(
	CoincidenceReidemeisterSpectrum, 
	"for finite pcp source",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	100,
	function ( H, G )
		if (
			not IsPcpGroup( H )
		) then
			TryNextMethod();
		fi;
		return CoincidenceReidemeisterSpectrum(
			Image( IsomorphismPcGroup( H ) ),
			G
		);
	end
);


###############################################################################
##
## CoincidenceReidemeisterSpectrum( G )
##
InstallMethod(
	CoincidenceReidemeisterSpectrum, 
	"turn group into SpecialPcGroup",
	[ IsGroup and IsFinite ],
	100,
	function ( G )
		if (
			not IsPcpGroup( G )
		) then
			TryNextMethod();
		fi;
		return CoincidenceReidemeisterSpectrum(
			Image( IsomorphismPcGroup( G ) )
		);
	end
);


###############################################################################
##
## ReidemeisterZetaCoefficients( endo1, endo2 )
##
InstallMethod(
	ReidemeisterZetaCoefficients,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
	function ( endo1, endo2 )
		local G, iso, inv;
		G := Range( endo1 );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		inv := InverseGeneralMapping( iso );
		return ReidemeisterZetaCoefficients( inv*endo1*iso, inv*endo2*iso );
	end
);


###############################################################################
##
## ReidemeisterZetaCoefficients( endo )
##
InstallOtherMethod(
	ReidemeisterZetaCoefficients,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
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
		return ReidemeisterZetaCoefficients( 
			InverseGeneralMapping( iso ) * endo * iso
		);
	end
);


###############################################################################
##
## IsRationalReidemeisterZeta( endo1, endo2 )
##
InstallMethod(
	IsRationalReidemeisterZeta,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
	function ( endo1, endo2 )
		local G, iso, inv;
		G := Range( endo1 );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		inv := InverseGeneralMapping( iso );
		return IsRationalReidemeisterZeta( inv*endo1*iso, inv*endo2*iso );
	end
);


###############################################################################
##
## IsRationalReidemeisterZeta( endo )
##
InstallOtherMethod(
	IsRationalReidemeisterZeta,
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
		return IsRationalReidemeisterZeta( inv*endo*iso );
	end
);


###############################################################################
##
## ReidemeisterZeta( endo1, endo2 )
##
InstallMethod(
	ReidemeisterZeta,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
	function ( endo1, endo2 )
		local G, iso, inv;
		G := Range( endo1 );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		inv := InverseGeneralMapping( iso );
		return ReidemeisterZeta( inv*endo1*iso, inv*endo2*iso );
	end
);


###############################################################################
##
## ReidemeisterZeta( endo )
##
InstallOtherMethod(
	ReidemeisterZeta,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
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
		return ReidemeisterZeta( InverseGeneralMapping( iso ) * endo * iso );
	end
);


###############################################################################
##
## PrintReidemeisterZeta( endo1, endo2 )
##
InstallMethod(
	PrintReidemeisterZeta,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
	function ( endo1, endo2 )
		local G, iso, inv;
		G := Range( endo1 );
		if (
			not IsPcpGroup( G ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		inv := InverseGeneralMapping( iso );
		return PrintReidemeisterZeta( inv*endo1*iso, inv*endo2*iso );
	end
);


###############################################################################
##
## PrintReidemeisterZeta( endo )
##
InstallOtherMethod(
	PrintReidemeisterZeta,
	"turn group into SpecialPcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	100,
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
		return PrintReidemeisterZeta( 
			InverseGeneralMapping( iso ) * endo * iso
		);
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
