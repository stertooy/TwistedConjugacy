###############################################################################
##
## RepresentativeActionOp( G, d, e, act )
##
InstallOtherMethod( RepresentativeActionOp,
    "For PcpGroups",
    true,
    [ IsPcpGroup, IsPcpElement, IsPcpElement, IsFunction ],
    function( G, d, e, act )
        local pcp, c;
        if act <> OnPoints then TryNextMethod(); fi;
        pcp := PcpsOfEfaSeries( G );
        c := ConjugacyElementsBySeries( G, d, e, pcp );
        if c = false then
            return fail;
        fi;
        return c;
    end
);
