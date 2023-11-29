###############################################################################
##
## RepresentativeActionOp( G, d, e, act )
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
