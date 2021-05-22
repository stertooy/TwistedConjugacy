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
