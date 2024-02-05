###############################################################################
##
## RepresentativeActionOp( G, d, e, act )
##
##  INPUT:
##      G:          acting group
##      d:          source element
##      e:          target element
##      act:        group action
##
##  OUTPUT:
##      g:          element of G mapping d to e under the action act, or "fail"
##                  if no such element exists
##
##  REMARKS:
##      We only implement this for a PcpGroup G acting on itself via OnPoints
##
InstallOtherMethod( RepresentativeActionOp,
    "For PcpGroups and OnPoints",
    true,
    [ IsPcpGroup, IsPcpElement, IsPcpElement, IsFunction ],
    function( G, d, e, act )
        local pcp, c;
        if act <> OnPoints then TryNextMethod(); fi;
        if not ( d in G and e in G ) then TryNextMethod(); fi;
        pcp := PcpsOfEfaSeries( G );
        c := ConjugacyElementsBySeries( G, d, e, pcp );
        if c = false then
            return fail;
        fi;
        return c;
    end
);


###############################################################################
##
## StabilizerFuncOp( G, g, gens, acts, act )
##
##  INPUT:
##      G:          acting group
##      g:          element
##      gens:       generators of G
##      acts:       images of gens that act on the set g belongs to
##      act:        group action
##
##  OUTPUT:
##      stab:       stabiliser of g under the action act
##
##  REMARKS:
##      We only implement this for a PcpGroup G acting on itself via OnPoints
##
InstallOtherMethod( StabilizerFuncOp,
    "For PcpGroups and OnPoints",
    true,
    [ IsPcpGroup, IsPcpElement,
      IsPcpElementCollection, IsPcpElementCollection, IsFunction ],
    function( G, g, gens, acts, act )
        if gens <> acts then TryNextMethod(); fi;
        if act <> OnPoints then TryNextMethod(); fi;
        return Centraliser( G, g );
    end
);
