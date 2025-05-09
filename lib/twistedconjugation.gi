###############################################################################
##
## TwistedConjugation( hom1, arg... )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##
##  OUTPUT:
##      tc:         function (g,h) -> (h^hom1)^-1 * g * (h^hom2)
##
InstallGlobalFunction(
    TwistedConjugation,
    function( hom1, arg... )
        local hom2;
        if Length( arg ) = 0 then
            return { g, h } -> ImagesRepresentative( hom1, h ) ^ -1 * g * h;
        else
            hom2 := arg[1];
            return function( g, h )
                return ImagesRepresentative( hom1, h ) ^ -1 * g *
                    ImagesRepresentative( hom2, h );
            end;
        fi;
    end
);


###############################################################################
##
## IsTwistedConjugate( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##      g1:         element of G
##      g2:         element of G (optional)
##
##  OUTPUT:
##      bool:       true if there exists an element h of H such that
##                  (h^hom1)^-1 * g_1 * h^hom2 = g_2, or false otherwise.
##
##  REMARKS:
##      If no hom2 is given, it is assumed that hom1 is an endomorphism G -> G
##      and hom2 is assumed to be the identity mapping of G. If no g2 is given,
##      it is assumed to be 1.
##
InstallGlobalFunction(
    IsTwistedConjugate,
    function( arg... )
        return CallFuncList( RepresentativeTwistedConjugation, arg ) <> fail;
    end
);


###############################################################################
##
## RepresentativeTwistedConjugation( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##      g1:         element of G
##      g2:         element of G (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom1)^-1 * g_1 * h^hom2 = g_2, or
##                  fail if no such element exists
##
##  REMARKS:
##      If no hom2 is given, it is assumed that hom1 is an endomorphism G -> G
##      and hom2 is assumed to be the identity mapping of G. If no g2 is given,
##      it is assumed to be 1.
##
InstallGlobalFunction(
    RepresentativeTwistedConjugation,
    function( arg... )
        local G, c, tc;
        if Length( arg ) < 4 then
            G := Range( arg[1] );
            if arg[2] in G then
                Add( arg, IdentityMapping( G ), 2 );
            fi;
        fi;
        c := CallFuncList( RepresentativeTwistedConjugationOp, arg );
        if ASSERT@ and c <> fail then
            tc := TwistedConjugation( arg[1], arg[2] );
            if Length( arg ) < 4 then
                Add( arg, One( G ) );
            fi;
            if tc( arg[3], c ) <> arg[4] then Error( "Assertion failure" ); fi;
        fi;
        return c;
    end
);


###############################################################################
##
## RepresentativeTwistedConjugationOp( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g1:         element of G
##      g2:         element of G (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom1)^-1 * g_1 * h^hom2 = g_2, or
##                  fail if no such element exists
##
##  REMARKS:
##      If no g2 is given, it is assumed to be 1.
##
InstallMethod(
    RepresentativeTwistedConjugationOp,
    "for two homomorphisms and two elements",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
    function( hom1, hom2, g1, g2 )
        local G, inn;
        G := Range( hom1 );
        inn := InnerAutomorphismNC( G, g2 );
        return RepresentativeTwistedConjugationOp(
            hom1 * inn, hom2, g2 ^ -1 * g1
        );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for trivial element",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    7,
    function( hom1, hom2, g )
        local H;
        if not IsOne( g ) then TryNextMethod(); fi;
        H := Source( hom1 );
        return One( H );
    end
);


InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    5,
    function( hom1, hom2, g )
        local G, H, diff;
        G := Range( hom1 );
        if not IsAbelian( G ) then TryNextMethod(); fi;
        H := Source( hom1 );
        diff := DifferenceGroupHomomorphisms@( hom1, hom2, H, G );
        # TODO: Replace this by PreImagesRepresentative (without NC) eventually
        if not g in ImagesSource( diff ) then return fail; fi;
        return PreImagesRepresentativeNC( diff, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for finite source",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    4,
    function( hom1, hom2, g )
        local H, tc, d, todo, conj, trail, h, i, k, gens, l;
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
                        h := conj[i] * h;
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
