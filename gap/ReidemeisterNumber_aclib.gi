###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod( ReidemeisterNumber, "for nilpotent groups",
	[IsGroupHomomorphism and IsEndoGeneralMapping,
	 IsGroupHomomorphism and IsEndoGeneralMapping],
	1,
	function ( hom1, hom2 ) 
		local G, N, p, RclGN, Rcl, pg, g, ighom1, RclN, iRclN, h, ihghom1, R;
		G := Source( hom1 );
		if not IsPcpGroup( G ) or not IsNilpotentGroup( G ) then
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
	2,
	function ( hom1, hom2 )
		local G, ALCS, Rcl, i, Gi, Gip1, p, hom1N, hom2N, hom1Np, hom2Np, R;
		G := Source( hom1 );
		if not IsPcpGroup( G ) or not IsNilpotentGroup( G ) or 
			not IsTorsionFree( G ) then
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