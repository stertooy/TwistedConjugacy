###############################################################################
##
## TwistedConjugation( hom1, arg... )
##
InstallGlobalFunction(
	TwistedConjugation,
	function ( hom1, arg... )
		local hom2;
		if Length( arg ) = 0 then
			return function ( g, h )
				return OnLeftInverse( g, h ) *
					ImagesRepresentative( hom1, h );
			end;
		else
			hom2 := arg[1];
			return function ( g, h )
				return OnLeftInverse( g, ImagesRepresentative( hom2, h ) ) *
					ImagesRepresentative( hom1, h );
			end;
		fi;
	end
);


###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod(
	RepTwistConjToId,
	"for trivial element",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	7,
	function ( hom1, hom2, g )
		local H;
		H := Source( hom1 );
		if not IsOne( g ) then TryNextMethod(); fi;
		return One( H );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	5,
	function ( hom1, hom2, g )
		local G, H, diff;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsAbelian( G ) then TryNextMethod(); fi;
		diff := DifferenceGroupHomomorphisms@( hom1, hom2, H, G );
		if not g in ImagesSource( diff ) then
			return fail;
		fi;
		return PreImagesRepresentative( diff, g );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for finite source",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	4,
	function ( hom1, hom2, g )
		local G, H, tc, d, todo, conj, trail, h, i, k, gens, l;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsFinite( H ) then TryNextMethod(); fi;
		tc := TwistedConjugation( hom1, hom2 );
		g := Immutable( g );
		d := NewDictionary( g, true );
		AddDictionary( d, g, 0 );
		todo := [ g ];
		conj := [];
		trail := [];
		while not IsEmpty( todo ) do
			k := Remove( todo );
			if CanEasilyComputePcgs( H ) then
				gens := Pcgs( H );
			else
				gens := SmallGeneratingSet( H );
			fi;
			for h in gens do
				l := Immutable( tc( k, h ) );
				if IsOne( l ) then
					while k <> g do
						i := LookupDictionary( d, k );
						k := trail[i];
						h := conj[i]*h;
					od;
					return h;
				elif not KnowsDictionary( d, l ) then
					Add( trail, k );
					Add( todo, l );
					Add( conj, h );
					AddDictionary( d, l, Length( trail ) );
				fi;
			od;
        od;
        return fail;
	end
);


###############################################################################
##
## RepTwistConjToIdMultiple@( hom1L, hom2L, gL )
##
RepTwistConjToIdMultiple@ := function ( hom1L, hom2L, gL  )
	local hom1, hom2, h, n, i, Coin, tc, g, G, hi;
	hom1 := hom1L[1];
	hom2 := hom2L[1];
	h := RepTwistConjToId( hom1, hom2, gL[1] );
	if h = fail then
		return fail;
	fi;
	n := Length( hom1L );
	for i in [2..n] do
		Coin := CoincidenceGroup2( hom1, hom2 );
		hom1 := hom1L[i];
		hom2 := hom2L[i];
		tc := TwistedConjugation( hom1, hom2 );
		g := tc( gL[i], h );
		G := Range( hom1 );
		hom1 := RestrictedHomomorphism( hom1, Coin, G );
		hom2 := RestrictedHomomorphism( hom2, Coin, G );
		hi := RepTwistConjToId( hom1, hom2, g );
		if hi = fail then
			return fail;
		fi;
		h := h*hi;
	od;
	return h;
end;


###############################################################################
##
## RepresentativeTwistedConjugation( hom1, x, y, arg... )
##
InstallGlobalFunction(
	RepresentativeTwistedConjugation,
	function ( hom1, x, y, arg... )
		local n, ighom1, g, G, hom2, g1, g2, i, g2inv, inn;
		if IsList( hom1 ) then
			n := Length( hom1 );
			ighom1 := ShallowCopy( hom1 );
			g := ShallowCopy( y );
			if Length( arg ) = 0 then
				G := Range( hom1[1] );
				hom2 := ListWithIdenticalEntries( n, IdentityMapping( G ) );
				g1 := x;
				g2 := y;
			else
				hom2 := x;
				g1 := y;
				g2 := arg[1];
			fi;
			for i in [1..n] do
				G := Range( hom1[i] );
				g2inv := g2[i]^-1;
				inn := InnerAutomorphismNC( G, g2inv );
				ighom1[i] := hom1[i]*inn;
				g[i] := g1[i]*g2inv;
			od;
			return RepTwistConjToIdMultiple@( ighom1, hom2, g );
		fi;
		G := Range( hom1 );
		if Length( arg ) = 0 then
			hom2 := IdentityMapping( G );
			g1 := x;
			g2 := y;
		else
			hom2 := x;
			g1 := y;
			g2 := arg[1];
		fi;
		g2inv := g2^-1;
		inn := InnerAutomorphismNC( G, g2inv );
		ighom1 := hom1*inn;
		g := g1*g2inv;
		return RepTwistConjToId( ighom1, hom2, g );
	end
);


###############################################################################
##
## IsTwistedConjugate( arg... )
##
InstallGlobalFunction(
	IsTwistedConjugate,
	function ( arg... )
		return CallFuncList( RepresentativeTwistedConjugation, arg ) <> fail;
	end
);
