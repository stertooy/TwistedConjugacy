###############################################################################
##
## InclusionHomomorphism( H, G )
##
##  INPUT:
##      H:          subgroup of G
##      G:          group
##
##  OUTPUT:
##      hom:        natural inclusion H -> G
##
TWC.InclusionHomomorphism := function( H, G )
    local gens;
    gens := GeneratorsOfGroup( H );
    return GroupHomomorphismByImagesNC( H, G, gens, gens );
end;
