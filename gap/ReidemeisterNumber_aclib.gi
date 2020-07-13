###############################################################################
##
## ReidemeisterNumber( endo1, endo2 )
##
InstallMethod(
	ReidemeisterNumber,
	"for endomorphisms of torsion-free nilpotent groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	2,
	function ( hom1, hom2 )
		local G, ALCS, Rcl, i, Gi, Gip1, p, hom1N, hom2N, hom1Np, hom2Np, R;
		G := Source( hom1 );
		if not IsPcpGroup( G ) or not IsNilpotentGroup( G ) or 
			not IsTorsionFree( G ) or IsAbelian( G ) then
			TryNextMethod();
		fi;
		ALCS := AdaptedLowerCentralSeriesOfGroup( G );
		R := 1;
		for i in [1..Length( ALCS )-1 ] do
			Gi := ALCS[i];
			p := NaturalHomomorphismByNormalSubgroupNC( Gi, ALCS[i+1] );
			R := R * ReidemeisterNumber( 
				InducedEndomorphism( p, RestrictedEndomorphism( hom1, Gi ) ),
				InducedEndomorphism( p, RestrictedEndomorphism( hom2, Gi ) )
			);
		od;
		return R;
	end
);

InstallMethod(
	ReidemeisterNumber,
	"for endomorphisms of nilpotent groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	1,
	function ( endo1, endo2 ) 
		local G, N, p, RclGN, R, g, igendo1;
		G := Source( endo1 );
		if not IsPcpGroup( G ) or not IsNilpotentGroup( G ) or
			IsTorsionFree( G ) then
			TryNextMethod();
		fi;
		N := TorsionSubgroup( G );
		p := NaturalHomomorphismByNormalSubgroupNC( G, N );
		RclGN := ReidemeisterClasses(
			InducedEndomorphism( p, endo1 ),
			InducedEndomorphism( p, endo2 )
		);
		if RclGN = fail then
			return infinity;
		fi;
		RclGN := List( 
			RclGN,
			tcc -> PreImagesRepresentative( p, Representative( tcc ) )
		);
		R := 0;
		for g in RclGN do
			igendo1 := ComposeWithInnerAutomorphism@( g^-1, endo1 );
			R := R + ReidemeisterNumber(
				RestrictedEndomorphism( igendo1, N ),
				RestrictedEndomorphism( endo2, N ) 
			);
		od;
		return R;
	end
);

RedispatchOnCondition(
	ReidemeisterNumber,
	true, 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	[ IsEndoGeneralMapping, IsEndoGeneralMapping ],
	999
);
