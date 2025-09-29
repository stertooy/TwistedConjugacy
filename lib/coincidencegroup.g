###############################################################################
##
## InducedCoincidenceGroup( q, p, hom1, hom2 )
##
##  INPUT:
##      q:          projection H -> Q
##      p:          projection G -> P
##      hom1:       group endomorphism H -> G
##      hom2:       group endomorphism H -> G
##
##  OUTPUT:
##      coin:       coincidence group of the induced homomorphisms Q -> P
##
TWC.InducedCoincidenceGroup := function( q, p, hom1, hom2 )
    local ind1, ind2;
    ind1 := InducedHomomorphism( q, p, hom1 );
    ind2 := InducedHomomorphism( q, p, hom2 );
    return CoincidenceGroup2( ind1, ind2 );
end;
