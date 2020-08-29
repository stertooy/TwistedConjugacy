###############################################################################
##
## TwistedConjugation( hom1, hom2 )
##
InstallMethod(
	TwistedConjugation,
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	function ( hom1, hom2 )
		return function ( g, h )
			return ( h^hom2 )^-1 * g * h^hom1;
		end;
	end
);


###############################################################################
##
## TwistedConjugation( endo )
##
InstallOtherMethod(
	TwistedConjugation, 
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		return TwistedConjugation( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition(
	TwistedConjugation,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);
	

###############################################################################
##
## IsTwistedConjugate( hom1, hom2, g1, g2 )
##
InstallMethod(
	IsTwistedConjugate, 
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	function ( hom1, hom2, g1, g2 )
		local R;
		R := RepresentativeTwistedConjugation( hom1, hom2, g1, g2 );
		if R = fail then
			return false;
		else
			return true;
		fi;
	end
);


###############################################################################
##
## IsTwistedConjugate( endo, g1, g2 )
##
InstallOtherMethod(
	IsTwistedConjugate, 
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	function ( endo, g1, g2 )
		return IsTwistedConjugate( 
			endo, IdentityMapping( Source( endo ) ), g1, g2 
		);
	end
);

RedispatchOnCondition(
	IsTwistedConjugate,
	true, 
	[ IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	[ IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	0
);


###############################################################################
##
## RepresentativeTwistedConjugation( hom1, hom2, g1, g2 )
##
InstallMethod(
	RepresentativeTwistedConjugation, 
	[ IsGroupHomomorphism, IsGroupHomomorphism, 
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	function ( hom1, hom2, g1, g2 )
		return RepTwistConjToId( 
			ComposeWithInnerAutomorphism@( g2^-1, hom1 ), hom2, g1*g2^-1 
		);
	end
);


###############################################################################
##
## RepresentativeTwistedConjugation( endo, g1, g2 )
##
InstallOtherMethod(
	RepresentativeTwistedConjugation, 
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	function ( endo, g1, g2 )
		return RepresentativeTwistedConjugation( 
			endo, IdentityMapping( Source( endo ) ), g1, g2
		);
	end
);

RedispatchOnCondition(
	RepresentativeTwistedConjugation,
	true, 
	[ IsGroupHomomorphism, 
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	[ IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
	0
);


###############################################################################
##
## RepTwistConjToIdByFiniteCoin( hom1, hom2, g, M )
##
RepTwistConjToIdByFiniteCoin@ := function ( hom1, hom2, g, M ) 
	local G, H, N, p, q, hom1HN, hom2HN, qh1, Coin, h1, tc, m1, hom1N, hom2N,
	qh2, h2, m2, n;
	G := Range( hom1 );
	H := Source ( hom1 );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	qh1 := RepTwistConjToId( hom1HN, hom2HN, g^p );
	if qh1 = fail then
		return fail;
	fi;
	Coin := CoincidenceGroup( hom1HN, hom2HN );
	if not IsFinite( Coin ) then
		TryNextMethod();
	fi;
	h1 := PreImagesRepresentative( q, qh1 );
	tc := TwistedConjugation( hom1, hom2 );
	m1 := tc( g, h1 );
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	for qh2 in Coin do
		h2 := PreImagesRepresentative( q, qh2 );
		m2 := tc( m1, h2 );
		n := RepTwistConjToId( hom1N, hom2N, m2 );
		if n <> fail then
			return h1*h2*n;
		fi;
	od;
	return fail;
end;


###############################################################################
##
## RepTwistConjToIdByCentre( hom1, hom2, g )
##
RepTwistConjToIdByCentre@ := function ( hom1, hom2, g ) 
	local G, H, M, N, p, q, hom1HN, hom2HN, qh1, h1, tc, m, CoinHN, qinvCoinHN,
	gens, deltaLift, h2, m2, n;
	G := Range( hom1 );
	H := Source ( hom1 );
	M := Centre( G );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	qh1 := RepTwistConjToId( hom1HN, hom2HN, g^p );
	if qh1 = fail then
		return fail;
	fi;
	h1 := PreImagesRepresentative( q, qh1 );
	tc := TwistedConjugation( hom1, hom2 );
	m := tc( g, h1 );
	CoinHN := CoincidenceGroup( hom1HN, hom2HN );
	qinvCoinHN := PreImage( q, CoinHN );
	gens := GeneratorsOfGroup( qinvCoinHN );
	deltaLift := GroupHomomorphismByImagesNC(
		qinvCoinHN, M,
		gens, List( gens, h -> h^hom2 *( h^hom1 )^-1 )
	);
	if not m in Image( deltaLift ) then
		return fail;
	fi;
	h2 := PreImagesRepresentative( deltaLift, m );
	n := RepTwistConjToId(
		RestrictedHomomorphism( hom1, N, M ),
		RestrictedHomomorphism( hom2, N, M ),
		tc( m, h2 )
	);
	return h1*h2*n;
end;


###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod(
	RepTwistConjToId,
	"for pcp-groups with abelian range", 
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	4,
	function ( hom1, hom2, g )
		local G, H, diff;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup ( H ) or
		not IsAbelian( G ) then
			TryNextMethod();
		fi;
		diff := DifferenceGroupHomomorphisms@( hom1, hom2, H, G );
		if g in Image( diff ) then
			return PreImagesRepresentative( diff, g );
		else
			return fail;
		fi;
	end
);

InstallMethod(
	RepTwistConjToId,
	"for pcp-groups with nilpotent range",
	[ IsGroupHomomorphism,
	  IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	3,
	function ( hom1, hom2, g )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup( H ) or
		not IsNilpotent( G ) or	IsAbelian( G ) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByCentre@( hom1, hom2, g );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for pcp-groups with nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	2,
	function ( hom1, hom2, g )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup( H ) or
		not IsNilpotentByFinite( G ) or	IsNilpotent( G ) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByFiniteCoin@( 
			hom1, hom2, g, FittingSubgroup( G )
		);
	end
);

InstallMethod(
	RepTwistConjToId,
	"for pcp-groups",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	1,
	function ( hom1, hom2, g )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup( H ) or
		IsNilpotentByFinite( G ) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByFiniteCoin@( 
			hom1, hom2,
			g, DerivedSubgroup( G )
		);
	end
);

InstallMethod(
	RepTwistConjToId,
	"for finite groups",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	0,
	function ( hom1, hom2, g )
		local H;
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		return RepresentativeAction( H, g, One( Range( hom1 ) ), 
			TwistedConjugation( hom1, hom2 ) 
		);
	end
);
