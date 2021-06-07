###############################################################################
##
## TwistedConjugation( hom1, hom2 )
##
InstallMethod(
	TwistedConjugation,
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	function ( hom1, hom2 )
		return function ( g, h )
			return OnLeftInverse( g, ImagesRepresentative( hom2, h ) ) *
				ImagesRepresentative( hom1, h );
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
		local G;
		G := Range( endo );
		return TwistedConjugation( endo, IdentityMapping( G ) );
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
		local G;
		G := Range( endo );
		return IsTwistedConjugate( endo, IdentityMapping( G ), g1, g2 );
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
## IsTwistedConjugate( hom1L, hom2L, g1L, g2L )
##
InstallOtherMethod(
	IsTwistedConjugate,
	[ IsList, IsList, IsList, IsList ],
	function ( hom1L, hom2L, g1L, g2L )
		return RepresentativeTwistedConjugation(
			hom1L, hom2L,
			g1L, g2L
		) <> fail;
	end
);


###############################################################################
##
## IsTwistedConjugate( endoL, g1L, g2L )
##
InstallOtherMethod(
	IsTwistedConjugate,
	[ IsList, IsList, IsList ],
	function ( endoL, g1L, g2L )
		local n, G, hom2L;
		n := Length( endoL );
		G := Range( endoL[1] );
		hom2L := ListWithIdenticalEntries( n, IdentityMapping( G ) );
		return IsTwistedConjugate( endoL, hom2L, g1L, g2L );
	end
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
		local G, g2inv, inn_g2;
		G := Range( hom1 );
		g2inv := g2^-1;
		inn_g2 := InnerAutomorphismNC( G, g2inv );
		return RepTwistConjToId( hom1*inn_g2, hom2, g1*g2inv );
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
		local G;
		G := Range( endo );
		return RepresentativeTwistedConjugation(
			endo, IdentityMapping( G ),
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
## RepresentativeTwistedConjugation( hom1L, hom2L, g1L, g2L )
##
InstallOtherMethod(
	RepresentativeTwistedConjugation,
	[ IsList, IsList, IsList, IsList ],
	function ( hom1L, hom2L, g1L, g2L  )
		local n, ighom1L, gL, i, G, g2inv, inn_g2;
		n := Length( hom1L );
		ighom1L := ShallowCopy( hom1L );
		gL := ShallowCopy( g1L );
		for i in [1..n] do
			G := Range( hom1L[i] );
			g2inv := g2L[i]^-1;
			inn_g2 := InnerAutomorphismNC( G, g2inv );
			ighom1L[i] := hom1L[i]*inn_g2;
			gL[i] := g1L[i]*g2inv;
		od;
		return RepTwistConjToId( ighom1L, hom2L, gL );
	end
);


###############################################################################
##
## RepresentativeTwistedConjugation( endoL, g1L, g2L )
##
InstallOtherMethod(
	RepresentativeTwistedConjugation,
	[ IsList, IsList, IsList ],
	function ( endoL, g1L, g2L )
		local n, G, hom2L;
		n := Length( endoL );
		G := Range( endoL[1] );
		hom2L := ListWithIdenticalEntries( n, IdentityMapping( G ) );
		return RepresentativeTwistedConjugation( endoL, hom2L, g1L, g2L );
	end
);


###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod(
	RepTwistConjToId,
	"for trivial range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	7,
	function ( hom1, hom2, g )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsTrivial( G ) then
			TryNextMethod();
		fi;
		return One( H );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for finite source",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	6,
	function ( hom1, hom2, g )
		local G, H, tc;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		tc := TwistedConjugation( hom1, hom2 );
		return RepresentativeAction( H,	g, One( G ), tc	);
	end
);


###############################################################################
##
## RepTwistConjToId( hom1L, hom2L, gL )
##
InstallOtherMethod(
	RepTwistConjToId,
	[ IsList, IsList, IsList ],
	function ( hom1L, hom2L, gL )
		local n, Coin, h, i, G, hom1, hom2, tc, g, hi;
		n := Length( hom1L );
		Coin := Source( hom1L[1] );
		h := One( Coin );
		for i in [1..n] do
			hom1 := hom1L[i];
			hom2 := hom2L[i];
			G := Range( hom1 );
			tc := TwistedConjugation( hom1, hom2 );
			g := tc( gL[i], h );
			hom1 := RestrictedHomomorphism( hom1, Coin, G );
			hom2 := RestrictedHomomorphism( hom2, Coin, G );
			hi := RepTwistConjToId( hom1, hom2, g );
			if hi = fail then
				return fail;
			elif i < n then
				Coin := CoincidenceGroup( hom1, hom2 );
			fi;
			h := h*hi;
		od;
		return h;
	end
);
