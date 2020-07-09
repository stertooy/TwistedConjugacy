###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumber,
	"by counting Reidemeister classes",
	[IsGroupHomomorphism, IsGroupHomomorphism],
	0,
	function ( hom1, hom2 )
		local Rcl;
		Print("fallback");
		Rcl := ReidemeisterClasses( hom1, hom2 );
		if Rcl <> fail then
			return Size( Rcl );
		else
			return infinity;
		fi;
	end
);

InstallMethod(
	ReidemeisterNumber,
	"for finite groups with abelian range",
	[IsGroupHomomorphism, IsGroupHomomorphism],
	1,
	function ( hom1, hom2 )
		local G, H, Rcl;
		Print(" HAI COIN ");
		H := Source( hom1 );
		G := Range( hom1 );
		if not IsFinite( G ) or not IsFinite( H ) or
			not IsAbelian( G ) then
			TryNextMethod();
		fi;

		return Size( G ) / Size( H ) * Size( CoincidenceGroup( hom1, hom2 ) );
	end
);

InstallMethod(
	ReidemeisterNumber,
	"for pcp-groups with abelian range",
	[IsGroupHomomorphism, IsGroupHomomorphism],
	20,
	function ( hom1, hom2 )
		local G, H;
		Print(" Hai index  ");
		H := Source( hom1 );
		G := Range( hom1 );
		if not IsPcpGroup( H ) or not IsPcpGroup( G ) or 
			not IsAbelian( G ) then
			TryNextMethod();
		fi;
		return IndexNC( G, Image( DifferenceGroupHomomorphisms@( hom1, hom2 ) ) );
	end
);

InstallMethod( ReidemeisterNumber, "for nilpotent groups",
	[IsGroupHomomorphism and IsEndoGeneralMapping,
	 IsGroupHomomorphism and IsEndoGeneralMapping],
	0,
	function ( hom1, hom2 ) 
		local G, N, p, RclGN, Rcl, pg, g, ighom1, RclN, iRclN, h, ihghom1, R;
		Print("nilpotent\n");
		G := Source( hom1 );
		if not IsNilpotentGroup( G ) then
			TryNextMethod();
		fi;
		N := TorsionSubgroup( G );
		p := NaturalHomomorphismByNormalSubgroupNC( G, N );
		RclGN := ReidemeisterClasses( InducedEndomorphism( p, hom1 ),
			InducedEndomorphism( p, hom2 )
		);
		if RclGN = fail then
			return infinity;
		fi;
		RclGN := List( RclGN, g -> PreImagesRepresentative( p, Representative( g ) ) );
		R := 0;
		for g in RclGN do
			ighom1 := ComposeWithInnerAutomorphism@( g^-1, hom1 );
			R := R + ReidemeisterNumber( RestrictedEndomorphism( ighom1, N ),
				RestrictedEndomorphism( hom2, N ) 
			);
		od;
		return R;
	end
);

InstallMethod( ReidemeisterNumber, "for torsion-free nilpotent groups",
	[IsGroupHomomorphism and IsEndoGeneralMapping,
	 IsGroupHomomorphism and IsEndoGeneralMapping],
	1,
	function ( hom1, hom2 )
		local G, ALCS, Rcl, i, Gi, Gip1, p, hom1N, hom2N, hom1Np, hom2Np, R;
		Print("TFnilpotent\n");
		G := Source( hom1 );
		if not IsNilpotentGroup( G ) or not IsTorsionFree( G ) or IsAbelian( G ) then
			TryNextMethod();
		fi;
		ALCS := AdaptedLowerCentralSeriesOfGroup( G );
		R := 1;
		for i in [1..Length( ALCS )-1 ] do
			Gi := ALCS[i];
			Gip1 := ALCS[i+1];
			p := NaturalHomomorphismByNormalSubgroupNC( Gi, Gip1 );
			hom1N := RestrictedEndomorphism( hom1, Gi );
			hom2N := RestrictedEndomorphism( hom2, Gi );
			hom1Np := InducedEndomorphism( p, hom1N );
			hom2Np := InducedEndomorphism( p, hom2N );
			R := R * ReidemeisterNumber( hom1Np, hom2Np );
		od;
		return R;
	end
);



RedispatchOnCondition( ReidemeisterNumber, true, 
	[IsGroupHomomorphism, IsGroupHomomorphism],
	[IsEndoGeneralMapping, IsEndoGeneralMapping], 999 );


###############################################################################
##
## ReidemeisterNumber( endo )
##
InstallOtherMethod( ReidemeisterNumber, 
	[IsGroupHomomorphism and IsEndoGeneralMapping],
	function ( endo )
		return ReidemeisterNumber( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition( ReidemeisterNumber, true, 
	[IsGroupHomomorphism],
	[IsEndoGeneralMapping], 999 );
