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
	4,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup( H ) or 
		not IsAbelian( G ) then
			TryNextMethod();
		fi;
		return Kernel( DifferenceGroupHomomorphisms@ ( hom1, hom2, H, G ) );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for nilpotent range", 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local H, G, M, N, p, q, CoinHN, deltaLift;
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
		deltaLift := DifferenceGroupHomomorphisms@ ( 
			hom1, hom2,
			PreImage( q, CoinHN ), M
		);
		return Kernel( deltaLift );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for nilpotent-by-finite range", 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local H, G, M, N, p, q, CoinHN, hom1N, hom2N, gens, tc, qh, h, n,
		qCoin, done;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup( H ) or 
		not IsNilpotentByFinite( G ) or IsNilpotent( G ) then
			TryNextMethod();
		fi;
		M := FittingSubgroup( G );
		N := IntersectionPreImage@( hom1, hom2, M );
		p := NaturalHomomorphismByNormalSubgroupNC( G, M );
		q := NaturalHomomorphismByNormalSubgroupNC( H, N );
		CoinHN := CoincidenceGroup( 
			InducedHomomorphism( q, p, hom1 ), 
			InducedHomomorphism( q, p, hom2 )
		);
		hom1N := RestrictedHomomorphism( hom1, N, M );
		hom2N := RestrictedHomomorphism( hom2, N, M );
		tc := TwistedConjugation( hom1, hom2 );
		gens := [];
		qCoin := TrivialSubgroup( CoinHN );
		done := false;
		while not done do
			done := true;
			for qh in RightTransversal( CoinHN, qCoin ) do
				if IsOne( qh ) then
					continue;
				fi;
				h := PreImagesRepresentative( q, qh );
				n := RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) );
				if n <> fail then
					Add( gens, h*n );
					qCoin := SubgroupNC( CoinHN, Concatenation( 
						GeneratorsOfGroup( qCoin ),
						[ qh ] 
					));
					done := false;
					break;
				fi;
			od;
		od;
		#for qh in CoinHN do
		#	h := PreImagesRepresentative( q, qh );
		#	n := RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) );
		#	if n <> fail then
		#		Add( gens, h*n );
		#	fi;
		#od;
		return SubgroupNC( H, Concatenation( 
			gens,
			GeneratorsOfGroup( CoincidenceGroup( hom1N, hom2N ) )
		));
	end
);

InstallMethod(
	CoincidenceGroup,
	"for finite source", 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		return Stabiliser( H, One( G ), TwistedConjugation( hom1, hom2 ) );
	end
);

InstallMethod(
	CoincidenceGroup,
	"fall-back if no other methods are available", 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( hom1, hom2 )
		return SubgroupByProperty( Source( hom1 ), h -> h^hom1 = h^hom2 );
	end
);
