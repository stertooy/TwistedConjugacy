Measured on GAP 4.16.1, x86-64 Linux, comparing commit `aff333a` with these
changes. The script uses 16 selected cases and three repetitions per case.
Times below are median CPU milliseconds from `Runtime()`. Every repetition
constructs fresh groups and resets both GAP random sources; construction and
an explicit pre-run garbage collection are outside the timer. Package startup
is excluded. Lazy initialization inside the operation is included: for example,
the first SL(2,5) sample took about 330 ms on both versions, while later samples
took 21 ms. Millisecond-scale differences should not be read as precise speedups.

| Operation and input | Before (ms) | After (ms) |
| --- | ---: | ---: |
| ordinary D64 (pc) | 13 | 13 |
| ordinary S4 (perm) | 19 | <1 |
| extended D32 (pc) | 17 | 17 |
| extended G96 (pc) | 92 | 94 |
| coincidence D256 (pc) | 76 | 43 |
| coincidence SmallGroup(32,44) (pc) | 106 | 107 |
| coincidence S4 (perm) | 2 | 2 |
| coincidence SL(2,5) fresh (perm) | 21 | 21 |
| coincidence C4xC2 -> D16 (pc) | 6 | 6 |
| total D16 (pc) | 359 | 368 |
| total A4 (perm) | 42 | 43 |
| endomorphisms D64 (pc) | 8 | 7 |
| endomorphisms C4xC8 excluding auts (pc) | 22 | 23 |
| endomorphisms D8xC2 (pc) | 96 | 99 |
| homomorphisms D8xC2 -> itself (pc) | 117 | 99 |
| homomorphisms C2^3 -> S4 (pc/perm) | 72 | 77 |

Here Dn denotes GAP's `DihedralGroup(n)`, of order n. G96 is
`PcGroupCode(553128533058418720,96)`. The script prints its full inputs,
individual timings, spectra, and representative counts. All 16 before/after
outputs agreed. Representative counts are supplemented by the independent
comparisons described below; equal counts alone do not establish correctness.

The clear gains in this sample are the ordinary spectrum of S4, the coincidence
spectrum of D256 (about 1.8 times faster), and homomorphism representatives from
D8xC2 to itself (about 1.2 times faster). Extended spectra, total spectra, and
most other representative cases show no meaningful change. In particular, the
small increases in some rows are comparable with variation during preliminary
runs; no speedup is claimed for those rows.

The changes retain the existing algorithms:

- Ordinary spectra omit singleton buckets of conjugacy classes having the same
  size and element order, and return immediately when all buckets are singletons.
  An automorphism sends a conjugacy class bijectively onto a conjugacy class,
  since it preserves products and inverses; it preserves element order since
  it and its inverse preserve powers. Thus a singleton bucket is fixed. Removing
  these fixed points does not change the number of moved points used by the
  existing algorithm. The link from fixed conjugacy classes to Reidemeister
  numbers is the package's existing use of R. Ree, *On generalized conjugate
  classes in a finite group*, Illinois J. Math. 3 (1959), 440–444, Theorem 1
  ([reference](https://doi.org/10/hb2rkv)).
- Coincidence calculations cache the conjugacy class of each image element
  encountered, reuse sorted class lists, and remove duplicate rows of class
  images before comparing pairs. The cache is local to one calculation and
  stores only encountered elements. Deduplication is an immediate consequence
  of the existing `CalcFromImgs` formula: replacing a row by an equal row
  changes none of its comparisons or summands. Diagonal pairs remain included.
  The underlying endomorphism formula is Senden–Tertooy, *Bi-twisted conjugacy
  in finite groups*, §3.1 (the conjugacy-class sum)
  ([paper](https://arxiv.org/html/2603.01679v1)). In the selected order-32 case,
  74 homomorphism representatives produce 72 distinct rows; the overall timing
  is essentially unchanged because constructing representatives dominates.
- The coincidence wrapper computes the quasisimple property before selecting
  the existing specialized method. Passing the identical group object twice
  to `RepresentativesHomomorphismClasses` delegates to the existing
  endomorphism implementation.
- The two-generator search examines five candidate pairs instead of nine and
  computes target class orders once. The deleted candidates could never improve
  the score: it depends only on the two element orders, and each deleted pair
  duplicates an earlier pair's orders. Indeed, `b*a` is conjugate to `a*b`,
  and `b*a^-1` is the inverse of `a*b^-1`. Conjugation preserves powers,
  and an element and its inverse have the same order. The strict improvement
  test therefore never selected any of the removed candidates in the old code.
  The generic endomorphism method also computes its allowed subgroup sizes
  once, outside the filter.
- Total spectra iterate directly over subgroup classes, reuse the action domain,
  and use `OrbitsDomain`. The existing permutation action is on all of the
  listed points, so this domain is invariant. GAP documents this operation for
  invariant domains in its [reference manual, §41.4-3](https://gap-system.github.io/gap/doc/ref/chap41_mj.html).

One correctness bug was fixed: the simple-source homomorphism method used only
two lists of possible generator images even when `SmallGeneratingSet` returned
more generators. It now retains every list and creates the matching number of
free generators. GAP explicitly does not guarantee minimal length for
[`SmallGeneratingSet`, §39.22-4](https://gap-system.github.io/gap/doc/ref/chap39.html).
With a three-element generating set for A5 and a separately constructed target
A5, the old code raises `<gens> and <imgs> must be lists of same length`; the
fixed code returns three valid representatives. Validation checked the maps
and compared their simultaneous conjugacy classes with GAP's
`AllHomomorphismClasses`. Three further small source/target pairs received the
same comparison in both pc and permutation representations. These added `.tst`
checks were subsequently removed as requested. The full package
suite passed: 19 pc/permutation test files and 10 PcpGroup test files.

To rerun, use `gap -q -b --quitonbreak tst/benchmark-spectra.g` with the desired
package version installed. The printed package directory identifies what was
actually loaded. For the recorded comparison, the baseline was exported with
`git archive aff333a` into a separate GAP root, and GAP was run with `-r -l`
to select that root explicitly and exclude the user's package directory.
