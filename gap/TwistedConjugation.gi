###############################################################################
##
## TwistedConjugation( hom1, hom2 )
##
InstallMethod( TwistedConjugation, [IsGroupHomomorphism, IsGroupHomomorphism],
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
InstallOtherMethod( TwistedConjugation, 
	[IsGroupHomomorphism and IsEndoGeneralMapping],
	function ( endo )
		return TwistedConjugation( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition( TwistedConjugation, true, 
	[IsGroupHomomorphism], [IsEndoGeneralMapping], 0 );
	

###############################################################################
##
## IsTwistedConjugate( hom1, hom2, g1, g2 )
##
InstallMethod( IsTwistedConjugate, 
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsObject],
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
InstallOtherMethod( IsTwistedConjugate, 
	[IsGroupHomomorphism and IsEndoGeneralMapping, IsObject, IsObject],
	function ( endo, g1, g2 )
		return IsTwistedConjugate( 
			endo, IdentityMapping( Source( endo ) ), g1, g2 
		);
	end
);

RedispatchOnCondition( IsTwistedConjugate, true, 
	[IsGroupHomomorphism, IsObject, IsObject],
	[IsEndoGeneralMapping, IsObject, IsObject], 0 );


###############################################################################
##
## RepresentativeTwistedConjugation( hom1, hom2, g1, g2 )
##
InstallMethod( RepresentativeTwistedConjugation, 
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsObject], 
	function ( hom1, hom2, g1, g2 )
		return RepTwistConjToId( 
			ComposeWithInnerAutomorphism( g2^-1, hom1 ), hom2, g1*g2^-1 
		);
	end
);


###############################################################################
##
## RepresentativeTwistedConjugation( endo, g1, g2 )
##
InstallOtherMethod( RepresentativeTwistedConjugation, 
	[IsGroupHomomorphism and IsEndoGeneralMapping, IsObject, IsObject], 
	function ( endo, g1, g2 )
		return RepresentativeTwistedConjugation( 
			endo, IdentityMapping( Source( endo ) ), g1, g2
		);
	end
);

RedispatchOnCondition( RepresentativeTwistedConjugation, true, 
	[IsGroupHomomorphism, IsObject, IsObject],
	[IsEndoGeneralMapping, IsObject, IsObject], 0 );
	

###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod( RepTwistConjToId, "for finite groups",
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject],
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

InstallMethod( RepTwistConjToId, "for abelian groups", 
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject],
	function ( hom1, hom2, g )
		local G;
		G := Range( hom1 );
		if not IsAbelian( G ) then
			TryNextMethod();
		fi;
		return PreImagesRepresentative( 
			DifferenceGroupHomomorphisms( hom1, hom2 ), g
		);
	end
);

InstallMethod( RepTwistConjToId, "for polycyclic groups",
	[IsGroupHomomorphism and IsEndoGeneralMapping, IsGroupHomomorphism and IsEndoGeneralMapping, IsObject],
	function ( hom1, hom2, g )
		local G;
		G := Source( hom1 );
		if not IsPcpGroup( G ) or IsAbelian( G ) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByNormal( hom1, hom2, g, DerivedSubgroup( G ) );
	end
);

RedispatchOnCondition( RepTwistConjToId, true, 
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject],
	[IsEndoGeneralMapping, IsEndoGeneralMapping, IsObject], 0 );


###############################################################################
##
## RepTwistConjToIdByNormal( hom1, hom2, g, N )
##
InstallMethod( RepTwistConjToIdByNormal,
	[IsGroupHomomorphism and IsEndoGeneralMapping, IsGroupHomomorphism and IsEndoGeneralMapping, IsObject, IsGroup], 
	function ( hom1, hom2, g, N ) 
		local G, p, hom1GN, hom2GN, Coin, 
			pk, k, tc, n, hom1N, hom2N, ph, h, l;
		
		G := Source( hom1 );

		p := NaturalHomomorphismByNormalSubgroupNC( G, N );
		
		hom1GN := InducedEndomorphism( p, hom1 );
		hom2GN := InducedEndomorphism( p, hom2 );
		# If Fixed point group is infinite, algorithm does not work
		Coin := CoincidenceGroup( hom1GN, hom2GN );
		if not IsFinite( Coin ) then
			TryNextMethod();
		fi;
		pk := RepTwistConjToId( hom1GN, hom2GN, g^p );
		if pk = fail then
			return fail;
		fi;
		k := PreImagesRepresentative( p, pk );
		tc := TwistedConjugation( hom1, hom2 );
		n := tc( g, k ); # n = k^-1 * g * endo( k )
		hom1N := RestrictedEndomorphism( hom1, N );
		hom2N := RestrictedEndomorphism( hom2, N );
		for ph in Coin do
			h := PreImagesRepresentative( p, ph );
			l := RepTwistConjToId( hom1N, hom2N, tc( n, h ) );
			if l <> fail then
				return k*h*l;
			fi;
		od;
		return fail;
	end
);

RedispatchOnCondition( RepTwistConjToIdByNormal, true, 
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsGroup],
	[IsEndoGeneralMapping, IsEndoGeneralMapping, IsObject, IsGroup], 0 );
