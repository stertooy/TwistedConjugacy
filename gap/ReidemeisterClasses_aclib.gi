###############################################################################
##
## ReidemeisterClasses( hom1, hom2 )
##
InstallMethod( ReidemeisterClasses, "for torsion-free nilpotent groups",
	[IsGroupHomomorphism and IsEndoGeneralMapping,
	 IsGroupHomomorphism and IsEndoGeneralMapping],
	1,
	function ( hom1, hom2 )
		local G, ALCS, Rcl, i, Gi, Gip1, p, hom1N, hom2N, hom1Np, hom2Np, RGiGip1, g, RclFactor, tcc;
		G := Source( hom1 );
		if not IsPcpGroup( G ) or not IsNilpotentGroup( G ) or not IsTorsionFree( G ) then
			TryNextMethod();
		fi;
		ALCS := AdaptedLowerCentralSeriesOfGroup( G );
		Rcl := [ Identity( G ) ];
		for i in [1..Length( ALCS )-1 ] do
			Gi := ALCS[i];
			Gip1 := ALCS[i+1];
			p := NaturalHomomorphismByNormalSubgroupNC( Gi, Gip1 );
			hom1N := RestrictedEndomorphism( hom1, Gi );
			hom2N := RestrictedEndomorphism( hom2, Gi );
			hom1Np := InducedEndomorphism( p, hom1N );
			hom2Np := InducedEndomorphism( p, hom2N );
			RGiGip1 := ReidemeisterClasses( hom1Np, hom2Np );
			if RGiGip1 = fail then
				return fail;
			fi;
			RclFactor := [];
			for tcc in RGiGip1 do
				g := Representative( tcc );
				Add( RclFactor, PreImagesRepresentative( p, g ) );
			od;
			Rcl := List( Cartesian( Rcl, RclFactor ), x -> Product( x ) );
		od;
		return List( Rcl, x -> ReidemeisterClass( hom1, hom2, x ) );
	end
);


InstallMethod( ReidemeisterClasses, "for nilpotent groups",
	[IsGroupHomomorphism and IsEndoGeneralMapping,
	 IsGroupHomomorphism and IsEndoGeneralMapping],
	0,
	function ( hom1, hom2 ) 
		local G, p, RclGN, Rcl, pg, g, ighom1, RclN, iRclN, h, ihghom1, N;
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
			return fail;
		fi;
		RclGN := List( RclGN, g -> PreImagesRepresentative( p, Representative( g ) ) );
		Rcl := [];
		for g in RclGN do
			ighom1 := ComposeWithInnerAutomorphism@( g^-1, hom1 );
			RclN := ReidemeisterClasses( RestrictedEndomorphism( ighom1, N ),
				RestrictedEndomorphism( hom2, N ) 
			);
			if RclN = fail then
				return fail;
			fi;
			RclN := List( RclN, g -> Representative( g ) );
			Append( Rcl, 
				List( RclN, l -> ReidemeisterClass( hom1, hom2, l*g ) ) 
			);
		od;
		return Rcl;
	end
);
