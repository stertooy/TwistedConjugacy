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
	2,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup( H ) or 
		not IsAbelian( G ) then
			TryNextMethod();
		fi;
		return Kernel( DifferenceGroupHomomorphisms@ ( hom1, hom2 ) );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for nilpotent range", 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local H, G, M, N, p, q, CoinHN, qinvCoinHN, gens, diff;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup( H ) or 
		not IsNilpotentGroup( G ) or IsAbelian( G ) then
			TryNextMethod();
		fi;
		M := Centre( G );
		N := IntersectionPreImage@( hom1, hom2, M );
		p := NaturalHomomorphismByNormalSubgroupNC( G, M );
		q := NaturalHomomorphismByNormalSubgroupNC( H, N );
		CoinHN := CoincidenceGroup( 
			InducedHomomorphism( q, p, hom1 ), 
			InducedHomomorphism( q, p, hom2 )
		);
		qinvCoinHN := PreImage( q, CoinHN );
		gens := GeneratorsOfGroup( qinvCoinHN );
		diff := GroupHomomorphismByImagesNC( 
			qinvCoinHN, M, 
			gens, List( gens, h -> h^hom2*( h^hom1 )^-1 )
		);
		return Kernel( diff );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for finite source", 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( hom1, hom2 )
		local H;
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		return SubgroupNC( H, Filtered( H, h -> h^hom1 = h^hom2 ) );
	end
);
