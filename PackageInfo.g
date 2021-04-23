SetPackageInfo( rec(

PackageName := "TwistedConjugacy",
Subtitle := "Computation with twisted conjugacy classes",
Version := "1.1.0",
Date := "23/04/2021",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sam",
    LastName := "Tertooy",
    WWWHome := "https://stertooy.github.io/",
    Email := "sam.tertooy@kuleuven.be",
    PostalAddress := Concatenation( "Wiskunde\n",
			"KU Leuven Campus Kulak Kortrijk\n",
			"Etienne Sabbelaan 53\n",
			"8500 Kortrijk\n",
			"Belgium" ),
    Place := "Kortrijk",
    Institution := "KU Leuven Campus Kulak Kortrijk",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/sTertooy/TwistedConjugacy",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://sTertooy.github.io/TwistedConjugacy/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/archive/", ~.Version ),

ArchiveFormats := ".tar.gz",

Status := "dev",

AbstractHTML   :=  Concatenation( 
    "The <span class=\"pkgname\">TwistedConjugacy</span> package provides",
	"algorithms to calculate Reidemeister classes, numbers, spectra and zeta ",
	"functions, as well as fixed point groups and coincidence groups of "
	"group homomorphisms. This package is designed to be used with either ",
    "finite groups or with polycyclically presented groups."
  );

PackageDoc := rec(
  BookName  := "TwistedConjugacy",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Computation with twisted conjugacy classes",
),

Dependencies := rec(
  GAP := ">= 4.9",
  NeededOtherPackages := [
    [ "Polycyclic", "2.13.1" ],
    [ "GAPDoc", "1.6.1" ],
    [ "AutoDoc", "2018.02.14" ]
  ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [
	"coincidence group",
	"fixed point group",
	"Reidemeister number",
	"Reidemeister spectrum",
	"Reidemeister zeta function",
	"twisted conjugacy",
	],

));
