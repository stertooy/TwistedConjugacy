###############################################################################
##
## FixedPointGroup( endo )
##
InstallMethod(
	FixedPointGroup,
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		return CoincidenceGroup( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition( 
	FixedPointGroup,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0 
);


###############################################################################
##
## CoincidenceGroup( hom1, hom2 )
##
InstallMethod(
	CoincidenceGroup,
	"for abelian range", 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	21,
	function ( hom1, hom2 )
		local G, H;
		H := Source( hom1 );
		G := Range( hom1 );
		if not IsPcpGroup( H ) or not IsPcpGroup( G ) or 
		   not IsAbelian( G ) then
			TryNextMethod();
		fi;
		return Kernel( DifferenceGroupHomomorphisms@ ( hom1, hom2 ) );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for finite source", 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	20,
	function ( hom1, hom2 )
		local H;
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		return SubgroupNC( H, Filtered( H, h -> h^hom1 = h^hom2 ) );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for endomorphisms of nilpotent groups", 
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo1, endo2 )
		local G, LCS, N, p, CoinGN, pinvCoinGN, gens, diff;
		G := Source( endo1 );
		if not IsPcpGroup( G ) or not IsNilpotentGroup( G ) or
			IsAbelian( G ) then
			TryNextMethod();
		fi;
		LCS := LowerCentralSeriesOfGroup( G );
		N := LCS[ Length( LCS )-1 ];
		p := NaturalHomomorphismByNormalSubgroupNC( G, N );
		CoinGN := CoincidenceGroup( 
			InducedEndomorphism( p, endo1 ), 
			InducedEndomorphism( p, endo2 )
		);
		pinvCoinGN := PreImage( p, CoinGN );
		gens := GeneratorsOfGroup( pinvCoinGN );
		diff := GroupHomomorphismByImagesNC( 
			pinvCoinGN, N, 
			gens, List( gens, g -> g^endo2*( g^endo1 )^-1 )
		);
		return Kernel( diff );
	end
);

RedispatchOnCondition( 
	CoincidenceGroup,
	true, 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	[ IsEndoGeneralMapping, IsEndoGeneralMapping ],
	0
);
