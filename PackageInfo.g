SetPackageInfo( rec(

PackageName := "TwistedConjugacy",
Subtitle := "Computation with twisted conjugacy classes",
Version := "3.0.0dev",
Date := "25/05/2025",
License := "GPL-2.0-or-later",

Persons := [
    rec(
        IsAuthor := true,
        IsMaintainer := true,
        FirstNames := "Sam",
        LastName := "Tertooy",
        WWWHome := "https://stertooy.github.io/",
        Email := "sam.tertooy@kuleuven.be",
        PostalAddress := """
            Wiskunde
            KU Leuven, Kulak Kortrijk Campus
            Etienne Sabbelaan 53
            8500 Kortrijk
            Belgium
        """,
        Place := "Kortrijk, Belgium",
        Institution := "KU Leuven, Kulak Kortrijk Campus"
    ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/stertooy/", ~.PackageName )
),
SupportEmail := "sam.tertooy@kuleuven.be",

IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation(
    "https://stertooy.github.io/",
    ~.PackageName
),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
ArchiveURL      := Concatenation(
    ~.SourceRepository.URL,
    "/releases/download/v", ~.Version,
    "/", ~.PackageName, "-", ~.Version
),

ArchiveFormats := ".tar.gz",

AbstractHTML := """
    The TwistedConjugacy package provides methods for solving the twisted
    conjugacy problem (including the "search" and "multiple" variants) and for
    computing Reidemeister classes, numbers, spectra, and zeta functions. It
    also includes utility functions for working with (double) cosets, group
    homomorphisms, and group derivations.

    These methods are primarily designed for use with finite groups and with
    polycyclically presented groups (finite or infinite).
""",

PackageDoc := rec(
    BookName  := ~.PackageName,
    ArchiveURLSubset := [ "doc" ],
    HTMLStart := "doc/chap0_mj.html",
    PDFFile   := "doc/manual.pdf",
    SixFile   := "doc/manual.six",
    LongTitle := ~.Subtitle
),

Dependencies := rec(
    GAP := ">= 4.14"
),

Extensions := [
    rec(
        needed := [ [ "Polycyclic", "2.16" ] ],
        filename := "lib/pcp/read_pcp.g"
    )
],

TestFile := "tst/testall.g",

Keywords := [
    "automorphism",
    "coincidence group",
    "coset",
    "derivation",
    "endomorphism",
    "fixed point group",
    "homomorphism",
    "Reidemeister class",
    "Reidemeister number",
    "Reidemeister spectrum",
    "Reidemeister zeta function",
    "twisted conjugacy"
],

));
