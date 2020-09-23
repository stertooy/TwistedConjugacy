SetPackageInfo( rec(

PackageName := "TwistedConjugacy",
Subtitle := "Computation with twisted conjugacy classes",
Version := "1.1.0",
Date := "23/09/2020",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sam",
    LastName := "Tertooy",
    WWWHome := "https://stertooy.github.io/",
    Email := "sam.tertooy@hotmail.com",
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

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "TwistedConjugacy",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Computation with twisted conjugacy classes",
),

Dependencies := rec(
  GAP := ">= 4.11",
  NeededOtherPackages := [
    [ "Polycyclic", "2.16" ],
    [ "GAPDoc", "1.6.3" ],
    [ "AutoDoc", "2019.09.04" ]
  ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [
	"twisted conjugacy",
	"Reidemeister number",
	"Reidemeister zeta",
	],

));
