###############################################################################
##
## ReidemeisterClasses( endo1, endo2 )
##
InstallMethod(
	ReidemeisterClasses,
	"for endomorphisms of torsion-free nilpotent groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	2,
	function ( endo1, endo2 )
		local G, ALCS, Rcl, i, Gi, p, RclQuo;
		G := Source( endo1 );
		if not IsPcpGroup( G ) or not IsNilpotentGroup( G ) or
			not IsTorsionFree( G ) then
			TryNextMethod();
		fi;
		ALCS := AdaptedLowerCentralSeriesOfGroup( G );
		Rcl := [ Identity( G ) ];
		for i in [ 1..Length( ALCS )-1 ] do
			Gi := ALCS[i];
			p := NaturalHomomorphismByNormalSubgroupNC( Gi, ALCS[i+1] );
			RclQuo := ReidemeisterClasses( 
				InducedEndomorphism( p, RestrictedEndomorphism( endo1, Gi ) ),
				InducedEndomorphism( p, RestrictedEndomorphism( endo2, Gi ) )
			);
			if RclQuo = fail then
				return fail;
			fi;
			RclQuo := List( 
				RclQuo,
				tcc -> PreImagesRepresentative( p, Representative( tcc ) )
			);
			Rcl := List( Cartesian( Rcl, RclQuo ), g -> Product( g ) );
		od;
		return List( Rcl, g -> ReidemeisterClass( endo1, endo2, g ) );
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for endomorphisms of nilpotent groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	1,
	function ( endo1, endo2 ) 
		local G, N, p, RclGN, Rcl, g, igendo1, RclN;
		G := Source( endo1 );
		if not IsPcpGroup( G ) or not IsNilpotentGroup( G ) then
			TryNextMethod();
		fi;
		N := TorsionSubgroup( G );
		p := NaturalHomomorphismByNormalSubgroupNC( G, N );
		RclGN := ReidemeisterClasses(
			InducedEndomorphism( p, endo1 ),
			InducedEndomorphism( p, endo2 )
		);
		if RclGN = fail then
			return fail;
		fi;
		RclGN := List(
			RclGN,
			tcc -> PreImagesRepresentative( p, Representative( tcc ) )
		);
		Rcl := [];
		for g in RclGN do
			igendo1 := ComposeWithInnerAutomorphism@( g^-1, endo1 );
			RclN := List( 
				ReidemeisterClasses(
					RestrictedEndomorphism( igendo1, N ),
					RestrictedEndomorphism( endo2, N ) 
				),
				tcc -> Representative( tcc )
			);
			Append( Rcl, 
				List( RclN, n -> ReidemeisterClass( endo1, endo2, n*g ) ) 
			);
		od;
		return Rcl;
	end
);
