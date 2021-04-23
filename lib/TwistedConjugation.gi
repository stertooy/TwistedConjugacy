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
		return RepresentativeTwistedConjugation( hom1, hom2, g1, g2 ) <> fail;
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
			endo, IdentityMapping( Source( endo ) ),
			g1, g2
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
			hom1 * InnerAutomorphismNC( Range( hom1 ), g2^-1 ), hom2,
			g1*g2^-1
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
			endo, IdentityMapping( Source( endo ) ),
			g1, g2
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
	local N, p, q, hom1HN, hom2HN, qh1, Coin, h1, tc, m, hom1N, hom2N, qh2, h2,
		n;
	if IsTrivial( M ) then
		TryNextMethod();
	fi;
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( Range( hom1 ), M );
	q := NaturalHomomorphismByNormalSubgroupNC( Source( hom1 ), N );
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
	m := tc( g, h1 );
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	for qh2 in Coin do
		h2 := PreImagesRepresentative( q, qh2 );
		n := RepTwistConjToId( hom1N, hom2N, tc( m, h2 ) );
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
	local G, M, N, p, q, hom1HN, hom2HN, qh1, h1, tc, m, Coin, delta, h2;
	G := Range( hom1 );
	M := Centre( G );
	if IsTrivial( M ) then
		TryNextMethod();
	fi;
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( Source ( hom1 ), N );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	qh1 := RepTwistConjToId( hom1HN, hom2HN, g^p );
	if qh1 = fail then
		return fail;
	fi;
	h1 := PreImagesRepresentative( q, qh1 );
	tc := TwistedConjugation( hom1, hom2 );
	m := tc( g, h1 );
	Coin := PreImage( q, CoincidenceGroup( hom1HN, hom2HN ) );
	delta := DifferenceGroupHomomorphisms@ (
		RestrictedHomomorphism( hom1, Coin, G ),
		RestrictedHomomorphism( hom2, Coin, G )
	);
	if not m in Image( delta ) then
		return fail;
	fi;
	h2 := PreImagesRepresentative( delta, m );
	return h1 * h2 * RepTwistConjToId(
		RestrictedHomomorphism( hom1, N, M ),
		RestrictedHomomorphism( hom2, N, M ),
		tc( m, h2 )
	);
end;


###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod(
	RepTwistConjToId,
	"for finite pcp range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	6,
	function ( hom1, hom2, g )
		local G, iso;
		G := Range( hom1 );
		if not IsFinite( G ) or not IsPcpGroup( G ) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		return RepTwistConjToId( hom1*iso, hom2*iso, g^iso );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for finite pcp source",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	5,
	function ( hom1, hom2, g )
		local H, iso, inv, rep;
		H := Source( hom1 );
		if not IsFinite( H ) or not IsPcpGroup( H ) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( H );
		inv := InverseGeneralMapping( iso );
		rep := RepTwistConjToId( inv*hom1, inv*hom2, g );
		if rep = fail then
			return fail;
		fi;
		return rep^inv;
	end
);

InstallMethod(
	RepTwistConjToId,
	"for finite source",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	4,
	function ( hom1, hom2, g )
		local H;
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		return RepresentativeAction(
			H,
			g, One( Range( hom1 ) ),
			TwistedConjugation( hom1, hom2 ) 
		);
	end
);

InstallMethod(
	RepTwistConjToId,
	"for polycyclic source and abelian range", 
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	3,
	function ( hom1, hom2, g )
		local diff;
		if (
			not IsAbelian( Range( hom1 ) ) or
			not IsPolycyclicGroup ( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		diff := DifferenceGroupHomomorphisms@( hom1, hom2 );
		if not g in Image( diff ) then
			return fail;
		fi;
		return PreImagesRepresentative( diff, g );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for polycyclic source and nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	2,
	function ( hom1, hom2, g )
		local G;
		G := Range( hom1 );
		if (
			not IsNilpotent( G ) or IsAbelian( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByCentre@( hom1, hom2, g );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for polycyclic source and nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	1,
	function ( hom1, hom2, g )
		local G;
		G := Range( hom1 );
		if (
			not IsNilpotentByFinite( G ) or	IsNilpotent( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByFiniteCoin@( 
			hom1, hom2,
			g,
			FittingSubgroup( G )
		);
	end
);

InstallMethod(
	RepTwistConjToId,
	"for polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	0,
	function ( hom1, hom2, g )
		local G;
		G := Range( hom1 );
		if (
			not IsPolycyclicGroup( G ) or IsNilpotentByFinite( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByFiniteCoin@(
			hom1, hom2,
			g,
			DerivedSubgroup( G )
		);
	end
);
