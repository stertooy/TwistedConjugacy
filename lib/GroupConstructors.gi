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
## CoincidenceGroupByFiniteCoin@( hom1, hom2, M )
##
CoincidenceGroupByFiniteCoin@ := function ( hom1, hom2, M )
	local G, H, N, p, q, CoinHN, hom1N, hom2N, tc, gens, qh, h, n;
	if IsTrivial ( M ) then
		TryNextMethod();
	fi;
	G := Range( hom1 );
	H := Source( hom1 );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	CoinHN := CoincidenceGroup(
		InducedHomomorphism( q, p, hom1 ),
		InducedHomomorphism( q, p, hom2 )
	);
	if not IsFinite( CoinHN ) then
		TryNextMethod();
	fi;
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	tc := TwistedConjugation( hom1, hom2 );
	gens := [];
	for qh in CoinHN do
		h := PreImagesRepresentative( q, qh );
		n := RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) );
		if n <> fail then
			Add( gens, h*n );
		fi;
	od;
	return ClosureSubgroupNC(
		AsSubgroup( H, CoincidenceGroup( hom1N, hom2N ) ),
		gens
	);
end;


###############################################################################
##
## CoincidenceGroupByCentre@( hom1, hom2 )
##
CoincidenceGroupByCentre@ := function ( hom1, hom2 )
	local G, M, p, q, Coin;
	G := Range( hom1 );
	M := Centre( G );
	if IsTrivial( M ) then
		TryNextMethod();
	fi;
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC(
		Source( hom1 ),
		IntersectionPreImage@( hom1, hom2, M )
	);
	Coin := PreImage( q, CoincidenceGroup(
		InducedHomomorphism( q, p, hom1 ),
		InducedHomomorphism( q, p, hom2 )
	));
	return Kernel( DifferenceGroupHomomorphisms@ (
		RestrictedHomomorphism( hom1, Coin, G ),
		RestrictedHomomorphism( hom2, Coin, G )
	));
end;


###############################################################################
##
## CoincidenceGroup( hom1, hom2 )
##
InstallMethod(
	CoincidenceGroup,
	"for finite pcp range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	5,
	function ( hom1, hom2 )
		local G, iso;
		#TryNextMethod();
		G := Range( hom1 );
		if not IsFinite( G ) or not IsPcpGroup( G ) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		return CoincidenceGroup( hom1*iso, hom2*iso );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for finite pcp source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	5,
	function ( hom1, hom2 )
		local H, iso, inv;
		#TryNextMethod();
		H := Source( hom1 );
		if not IsFinite( H ) or not IsPcpGroup( H ) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( H );
		inv := InverseGeneralMapping( iso );
		return Image( inv, CoincidenceGroup( inv*hom1, inv*hom2 ) );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for finite source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	4,
	function ( hom1, hom2 )
		local H;
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		return Stabiliser(
			H,
			One( Range( hom1 ) ),
			TwistedConjugation( hom1, hom2 )
		);
	end
);

InstallMethod(
	CoincidenceGroup,
	"for polycyclic source and abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		if (
			not IsAbelian( Range( hom1 ) ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return Kernel( DifferenceGroupHomomorphisms@ ( hom1, hom2 ) );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for polycyclic source and nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		if (
			not IsNilpotentGroup( G ) or IsAbelian( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return CoincidenceGroupByCentre@( hom1, hom2 );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for polycyclic source and nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if (
			not IsNilpotentByFinite( G ) or IsNilpotent( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return CoincidenceGroupByFiniteCoin@(
			hom1, hom2,
			FittingSubgroup( G )
		);
	end
);

InstallMethod(
	CoincidenceGroup,
	"for polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if ( 
			not IsPolycyclicGroup( G ) or IsNilpotentByFinite( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return CoincidenceGroupByFiniteCoin@(
			hom1, hom2,
			DerivedSubgroup( G )
		);
	end
);
