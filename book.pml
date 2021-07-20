<?xml version="1.0" encoding="UTF-8"?>
<!-- -*- xml -*- -->
<!DOCTYPE book SYSTEM "local/xml/markup.dtd">

<book xmlns:pml="http://pragprog.com/ns/pml">
  <options>
    <recipetitle name="Puzzle" />
  </options>

  <pml:include file="../bookinfo" />

  <frontmatter>
    <pml:include file="Praise" />
    <pml:include file="Changes" />
    <pml:include file="Acknowledgements" />
    <pml:include file="Preface" />
  </frontmatter>

  <mainmatter>

    <part id="subpatterns">
      <title>Quantifiers and Special Sub-Patterns</title>
      <partintro>
	    <p>Solving the puzzles in this section will require you to have 
		a good understanding of the different quantifiers that regular 
		expressions provide, and to pay careful attention to when you 
		should use sub-patterns (themselves likely quanitifed).  </p>
	  </partintro>
	  <pml:include file="scope" />
      <pml:include file="scope2" />
	  <pml:include file="endpoints" />
      <pml:include file="config" />
      <pml:include file="fasta" />
   </part>

   <part id="pitfalls">
      <title>Pitfalls and Sand in the Gears</title>
      <partintro>
	    <p>As compact and expressive as regular expressions can be,
        there are times when they simply go disasterously wrong.
        Be careful to avoid, or at least to understand and identify,
        where such difficulties arise.</p>
	  </partintro>
	  <pml:include file="catastrophic" />
      <pml:include file="dominoes" />
      <pml:include file="dominoes2" />
      <pml:include file="linedraw" />
    </part>

    <part id="functions">
      <title>Creating Functions using Regexen</title>
      <partintro>
	    <p>Very often in Python, or in other programming languages,
        you will want to wrap a regular expression in a small function
        rather than repeat it inline.</p>
	  </partintro>
	  <pml:include file="count" />
	  <pml:include file="count2" />
	  <pml:include file="naming" />
      <pml:include file="poker1" />
      <pml:include file="poker2" />
      <pml:include file="poker3" />
      <pml:include file="poker4" />
      <pml:include file="poker5" />
    </part>

    <part id="computability">
      <title>Easy, Difficult, and Impossible Tasks</title>
      <partintro>
	    <p>Some things are difficult or impossible with regular 
		expressions, and many are elegant and highly expressive.
		The puzzles in this section ask you to think about which
		situation each puzzle describes.</p>
	  </partintro>
	  <pml:include file="matchcount" />
	  <pml:include file="nodup" /> 
	  <pml:include file="ipv4" />
      <pml:include file="number_sequence" />
	  <pml:include file="fibonacci" />
	  <pml:include file="primes" />
      <pml:include file="relprimes" />
    </part>
  </mainmatter>

  <pml:include file="backmatter" />
</book>
