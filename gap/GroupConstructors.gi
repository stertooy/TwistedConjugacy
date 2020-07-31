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
	"for nilpotent range", 
	[ IsGroupHomomorphism,
	  IsGroupHomomorphism ],
	function ( hom1, hom2 )
		local H, G, LCS, c, M, N, p, q, CoinHN, qinvCoinHN, gens, diff;
		H := Source( hom1 );
		G := Range( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup( H ) or 
			not IsNilpotentGroup( G ) or IsAbelian( G ) then
			TryNextMethod();
		fi;
		LCS := LowerCentralSeriesOfGroup( G );
		c := Length( LCS )-1;
		M := LCS[c];
		N := LowerCentralSeries( H, c );
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

RedispatchOnCondition( 
	CoincidenceGroup,
	true, 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	[ IsEndoGeneralMapping, IsEndoGeneralMapping ],
	0
);


###############################################################################
##
## LowerCentralSeries( G, i )
##
InstallOtherMethod(
	LowerCentralSeries,
	"returns the i-th element of the lower central series of G",
	[IsGroup, IsPosInt],
	function ( G, i )
		local j, U, LCS;
		if i < 2 then
			return G;
		fi;
		U := DerivedSubgroup( G );
		if HasLowerCentralSeriesOfGroup( G ) then
			LCS := LowerCentralSeriesOfGroup( G );
			return LCS[ Minimum( i, Length( LCS ) ) ];
		fi;
		G!.isNormal := true;
		for j in [3..i] do
			U := CommutatorSubgroup( U, G );
		od;
		Unbind( G!.isNormal );
		return U;
	end
);


###############################################################################
##
## PowerSubgroup( G, n )
## Thanks to 
##
PowerSubgroupByQuotient@ := function( G, n, L )
	local N, p, Q;
	N := NormalClosure( G, SubgroupNC( G, List( L, g -> g^n ) ) );
	p := NaturalHomomorphismByNormalSubgroupNC( G, N );
	Q := Image( p );
	if n mod Exponent( Q ) = 0 then
		return N;
	fi;
	return PreImage( p, PowerSubgroup( Q, n ) );
end;

InstallMethod(
	PowerSubgroup,
	"for abelian pcp-groups",
	[IsPcpGroup and IsAbelian, IsPosInt],
	10,
	function( G, n )
		Print("ABELIAN FUCK YEAH\n");
		return SubgroupNC( G, List( Pcp( G ), g -> g^n ) );
	end
);

InstallMethod(
	PowerSubgroup,
	"for pcp-groups",
	[IsPcpGroup, IsPosInt],
	function( G, n )
		return PowerSubgroupByQuotient@( G, n, Pcp( G ) );
	end
);

InstallMethod(
	PowerSubgroup,
	"for  finite groups",
	[IsGroup and IsFinite, IsPosInt],
	20,
	function( G, n )
		return PowerSubgroupByQuotient@( G, n, [ Random( G ) ] );
	end
);

RedispatchOnCondition( 
	PowerSubgroup,
	true, 
	[ IsGroup, IsPosInt ],
	[ IsFinite, IsPosInt ],
	100
);
