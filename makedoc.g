if fail = LoadPackage("AutoDoc", ">= 2018.09.20") then
    Error("AutoDoc 2018.09.20 or newer is required");
fi;

AutoDoc(rec(autodoc:=true,scaffold:=true));
