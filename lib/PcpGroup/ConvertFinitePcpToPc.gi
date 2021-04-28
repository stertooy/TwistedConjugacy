###############################################################################
##
## CoincidenceGroup( hom1, hom2 )
##
InstallMethod(
	CoincidenceGroup,
	"turn finite PcpGroup range into PcGroup",
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
		return CoincidenceGroup( hom1*iso, hom2*iso );
	end
);

InstallMethod(
	CoincidenceGroup,
	"turn finite PcpGroup source into PcGroup",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	100,
	function ( hom1, hom2 )
		local H, inv;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		return ImagesSet( inv, CoincidenceGroup( inv*hom1, inv*hom2 ) );
	end
);


###############################################################################
##
## FixedPointGroup( endo )
##
InstallMethod(
	FixedPointGroup,
	"turn finite PcpGroup into PcGroup",
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
		return ImagesSet( inv, FixedPointGroup( inv*endo*iso ) );
	end
);


###############################################################################
##
## ReidemeisterClasses( hom1, hom2 )
##
InstallMethod(
	ReidemeisterClasses,
	"turn finite PcpGroup range into PcGroup",
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
		return List( 
			Rcl,
			tcc -> ReidemeisterClass(
				hom1, hom2,
				PreImagesRepresentative( iso, Representative( tcc ) )
			)
		);
	end
);

InstallMethod(
	ReidemeisterClasses,
	"turn finite PcpGroup source into PcGroup",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	100,
	function ( hom1, hom2 )
		local H, inv, Rcl;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		Rcl := ReidemeisterClasses( inv*hom1, inv*hom2 );
		if Rcl = fail then
			return fail;
		fi;
		return List(
			Rcl,
			tcc -> ReidemeisterClass(
				hom1, hom2,
				Representative( tcc )
			)
		);
	end
);


###############################################################################
##
## ReidemeisterClasses( endo )
##
InstallOtherMethod(
	ReidemeisterClasses,
	"turn finite PcpGroup into PcGroup",
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
		return List(
			Rcl,
			tcc -> ReidemeisterClass(
				endo,
				PreImagesRepresentative( iso, Representative( tcc ) )
			)
		);
	end
);


###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumber,
	"turn finite PcpGroup range into PcGroup",
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
	"turn finite PcpGroup source into PcGroup",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	100,
	function ( hom1, hom2 )
		local H, inv;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		return ReidemeisterNumber( inv*hom1, inv*hom2 );
	end
);


###############################################################################
##
## ReidemeisterNumber( endo )
##
InstallOtherMethod(
	ReidemeisterNumber,
	"turn finite PcpGroup into PcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	101,
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
		return ReidemeisterNumber( inv*endo*iso );
	end
);


###############################################################################
##
## IsTwistedConjugate( hom1, hom2, g1, g2 )
##
InstallMethod(
	IsTwistedConjugate,
	"turn finite PcpGroup range into PcGroup",
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
		return IsTwistedConjugate(
			hom1*iso, hom2*iso,
			ImagesRepresentative( iso, g1 ), ImagesRepresentative( iso, g2 )
		);
	end
);

InstallMethod(
	IsTwistedConjugate,
	"turn finite PcpGroup source into PcGroup",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	100,
	function ( hom1, hom2, g1, g2 )
		local H, inv, h;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		return IsTwistedConjugate( inv*hom1, inv*hom2, g1, g2 );
	end
);


###############################################################################
##
## IsTwistedConjugate( endo, g1, g2 )
##
InstallOtherMethod(
	IsTwistedConjugate,
	"turn finite PcpGroup into PcGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	100,
	function ( endo, g1, g2 )
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
		return IsTwistedConjugate(
			inv*endo*iso,
			ImagesRepresentative( iso, g1 ), ImagesRepresentative( iso, g2 )
		);
	end
);


###############################################################################
##
## RepresentativeTwistedConjugation( hom1, hom2, g1, g2 )
##
InstallMethod(
	RepresentativeTwistedConjugation,
	"turn finite PcpGroup range into PcGroup",
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
			ImagesRepresentative( iso, g1 ), ImagesRepresentative( iso, g2 )
		);
	end
);

InstallMethod(
	RepresentativeTwistedConjugation,
	"turn finite PcpGroup source into PcGroup",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	100,
	function ( hom1, hom2, g1, g2 )
		local H, inv, h;
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		inv := InverseGeneralMapping( IsomorphismPcGroup( H ) );
		h := RepresentativeTwistedConjugation( inv*hom1, inv*hom2, g1, g2 );
		if h = fail then
			return fail;
		fi;
		return ImagesRepresentative( inv, h );
	end
);


###############################################################################
##
## RepresentativeTwistedConjugation( endo, g1, g2 )
##
InstallOtherMethod(
	RepresentativeTwistedConjugation,
	"turn finite PcpGroup into PcGroup",
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
			inv*endo*iso,
			ImagesRepresentative( iso, g1 ), ImagesRepresentative( iso, g2 )
		);
		if h = fail then
			return fail;
		fi;
		return ImagesRepresentative( inv, h );
	end
);
