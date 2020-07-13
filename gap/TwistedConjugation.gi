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
	[ IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsObject ],
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
	[ IsGroupHomomorphism and IsEndoGeneralMapping, IsObject, IsObject ],
	function ( endo, g1, g2 )
		return IsTwistedConjugate( 
			endo, IdentityMapping( Source( endo ) ), g1, g2 
		);
	end
);

RedispatchOnCondition(
	IsTwistedConjugate,
	true, 
	[ IsGroupHomomorphism, IsObject, IsObject ],
	[ IsEndoGeneralMapping, IsObject, IsObject ],
	0
);


###############################################################################
##
## RepresentativeTwistedConjugation( hom1, hom2, g1, g2 )
##
InstallMethod(
	RepresentativeTwistedConjugation, 
	[ IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsObject ], 
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
	[ IsGroupHomomorphism and IsEndoGeneralMapping, IsObject, IsObject ], 
	function ( endo, g1, g2 )
		return RepresentativeTwistedConjugation( 
			endo, IdentityMapping( Source( endo ) ), g1, g2
		);
	end
);

RedispatchOnCondition(
	RepresentativeTwistedConjugation,
	true, 
	[ IsGroupHomomorphism, IsObject, IsObject ],
	[ IsEndoGeneralMapping, IsObject, IsObject ],
	0
);


###############################################################################
##
## RepTwistConjToIdByNormal( endo1, endo2, g, N )
##
RepTwistConjToIdByNormal@ := function ( endo1, endo2, g, N ) 
	local G, p, endo1GN, endo2GN, Coin, pk, k, tc, n, endo1N, endo2N, ph, h, l;
	G := Source( endo1 );
	p := NaturalHomomorphismByNormalSubgroupNC( G, N );
	endo1GN := InducedEndomorphism( p, endo1 );
	endo2GN := InducedEndomorphism( p, endo2 );
	Coin := CoincidenceGroup( endo1GN, endo2GN );
	if not IsFinite( Coin ) then
		Error( "no algorithm available!" );
	fi;
	pk := RepTwistConjToId( endo1GN, endo2GN, g^p );
	if pk = fail then
		return fail;
	fi;
	k := PreImagesRepresentative( p, pk );
	tc := TwistedConjugation( endo1, endo2 );
	n := tc( g, k );
	endo1N := RestrictedEndomorphism( endo1, N );
	endo2N := RestrictedEndomorphism( endo2, N );
	for ph in Coin do
		h := PreImagesRepresentative( p, ph );
		l := RepTwistConjToId( endo1N, endo2N, tc( n, h ) );
		if l <> fail then
			return k*h*l;
		fi;
	od;
	return fail;
end;


###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod(
	RepTwistConjToId,
	"for finite groups",
	[ IsGroupHomomorphism, IsGroupHomomorphism, IsObject ],
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

InstallMethod(
	RepTwistConjToId,
	"for pcp-groups with abelian range", 
	[ IsGroupHomomorphism, IsGroupHomomorphism, IsObject ],
	20,
	function ( hom1, hom2, g )
		local G, H;
		H := Source( hom1 );
		G := Range( hom1 );
		if not IsPcpGroup( G ) or not IsPcpGroup ( H )
			or not IsAbelian( G ) then
			TryNextMethod();
		fi;
		# Due to bug in the 'Polycyclic' package, PreImagesRepresentative 
		# may return the neutral element instead of "fail"
		# As a failsafe, we wrap this in a condtional statement
		if g in Image( DifferenceGroupHomomorphisms@( hom1, hom2 ) ) then
			return PreImagesRepresentative( 
				DifferenceGroupHomomorphisms@( hom1, hom2 ), g
			);
		else
			return fail;
		fi;
	end
);

InstallMethod(
	RepTwistConjToId,
	"for endomorphisms of nilpotent groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsObject ],
	1,
	function ( endo1, endo2, g )
		local G, LCS, N, p, endo1GN, endo2GN, Coin, pk, k, tc, n,
			endo1N, endo2N, q, gens, delta, nq, ph, h, l;
		G := Source( endo1 );
		if not IsPcpGroup( G ) or not IsNilpotent( G ) or
			IsAbelian( G ) then
			TryNextMethod();
		fi;
		LCS := LowerCentralSeriesOfGroup( G );
		N := LCS[ Length( LCS )-1 ];
		p := NaturalHomomorphismByNormalSubgroupNC( G, N );
		endo1GN := InducedEndomorphism( p, endo1 );
		endo2GN := InducedEndomorphism( p, endo2 );
		pk := RepTwistConjToId( endo1GN, endo2GN, g^p );
		if pk = fail then
			return fail;
		fi;
		k := PreImagesRepresentative( p, pk );
		tc := TwistedConjugation( endo1, endo2 );
		n := tc( g, k );
		endo1N := RestrictedEndomorphism( endo1, N );
		endo2N := RestrictedEndomorphism( endo2, N );
		q := NaturalHomomorphismByNormalSubgroup( 
			N, Image( DifferenceGroupHomomorphisms@( endo1N, endo2N ) )
		);
		Coin := CoincidenceGroup( endo1GN, endo2GN );
		gens := GeneratorsOfGroup( Coin );
		delta := GroupHomomorphismByImages(
			Coin, Image( q ),
			gens, 
			List( 
				List( gens, x -> PreImagesRepresentative( p, x ) ),
				x -> ( ( x^endo2 )*( x^endo1 )^-1 )^q
			)
		);
		nq := n^q;
		# Due to bug in the 'Polycyclic' package, PreImagesRepresentative 
		# may return the neutral element instead of "fail"
		# As a failsafe, we wrap this in a condtional statement
		if nq in Image( delta ) then
			ph := PreImagesRepresentative( delta, nq );
		else
			return fail;
		fi;
		h := PreImagesRepresentative( p, ph );
		l := RepTwistConjToId( endo1N, endo2N, tc( n, h ) );
		return k*h*l;
	end
);

InstallMethod(
	RepTwistConjToId,
	"for endomorphisms of polycyclic groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsObject ],
	0,
	function ( endo1, endo2, g )
		local G;
		G := Source( endo1 );
		if not IsPcpGroup( G ) or IsAbelian( G ) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByNormal@( 
			endo1, endo2,
			g, DerivedSubgroup( G )
		);
	end
);

RedispatchOnCondition(
	RepTwistConjToId,
	true, 
	[ IsGroupHomomorphism, IsGroupHomomorphism, IsObject ],
	[ IsEndoGeneralMapping, IsEndoGeneralMapping, IsObject ],
	999
);
