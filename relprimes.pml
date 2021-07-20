<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.relprimes">
	<title>
		Matching Relative Prime Numbers
	</title>
	<markdown>

If you read the last puzzle, you saw the subtle reason why a regular
expression cannot match an initial sequence of primes.  Think *finite*
automaton.  If you skipped that puzzle, at least go back and refresh
your understanding of the Sieve of Eratosthenes.

Mathematics has a concept of *relative primes* which is slightly weaker
than primality.  All prime numbers are relatively prime—also called
*coprime*—with each other, but other pairs are as well.  Two coprime
numbers have no common divisors other than 1.  This is certainly true
of prime numbers; for example, 11 and 53 are relatively prime since
neither has an divisors other than themselves and 1.  But likewise 10
and 21 are relatively since the divisors of the first are 2 and 5, but
those of the second are 3 and 7, which do not overlap.

So the question for this puzzle is whether you can create an expression
that will identify all and only sequences of ascending natural numbers
where all of them are relatively prime to each other.  Trivially, any
sequence of ascending primes qualifies here, but so do other sequences.

As in the last three puzzles, we encode numeric sequences using a
number of contiguous '@' symbols, with each "number" separated by
spaces. For example:

{:language="python"}
~~~
# Match: 2 3 5 7 11
primes5 = "@@ @@@ @@@@@ @@@@@@@ @@@@@@@@@@@ "
# Match: 2 5 7 9 11
relprime1 = "@@ @@@@@ @@@@@@@ @@@@@@@@@ @@@@@@@@@@@ "
# Match: 3 4 7 10
relprime2 = "@@@ @@@@ @@@@@@@ @@@@@@@@@ "
# Match: 9 16
startbig = "@@@@@@@@@ @@@@@@@@@@@@@@@ "
# Fail: 2 3 4 5 7  (2, 4 relatively composite)
fail1 = "@@ @@@ @@@@ @@@@@ @@@@@@@ "
# Fail: 5 7 2 3 11 (all primes, non-ascending)
fail2 = "@@@@@ @@@@@@@ @@ @@@ @@@@@@@@@@ "
~~~

Are relative primes consigned to the same fate as primes?

[aside important Before You Turn the Page]
<p>
    Nothing is either true or false but thinking makes it so.
</p>
[/aside]
<pagebreak />

There are a couple issues to consider in this solution.  It turns out
that such a solution is indeed possible, using much the same style as
the Sieve of Eratosthenes, but not an identical technique.  That is, as
discussed in the last puzzle, we are perfectly well able to reject a
string based on a future multiple of a given number.

The trick is that we do not need to reject *infinitely* many if we do
not assume that a string needs to contain all the initial primes.
Instead, we can focus just on a single number at a time, and rule out
*its* multiples.  We might miss some primes in our sequence, or indeed
have some relatively prime composite numbers.  But that satisfies the
current puzzle.

However, for this "striking through" to work, we need also to enforce 
the rule that sequences are ascending.  Otherwise, we might encounter, 
e.g.  `@@@@@@@@ @@@@ @@` (i.e. '8 4 2').  Those are definitely not 
mutually coprime.  However, "string out" multiples of 8 does not help 
reject 4 later in the string.  Python only allows fixed length 
lookbehind assertions, but some other regex implementation could 
technically relax this ascending sequence restriction (however, a 
library that did so would quickly face catastrophic exponential 
complexity in this case).

{:language="python"}
~~~
pat = r'^((@@+) (?=\2@)(?!.* \2{2,} ))+'
~~~

Here we first identify a group of 2 or more '@' symbols.  Then we do a
postive lookahead to assure that the next group of '@' symbols has at
least one more symbol.

The real crux of this is the *negative lookahead* assertion that we
never later see a (space delimited) sequence of two or more copies of
the group.  This pattern does not capture the final "number" in the
sequence, it is just used to provide a true or false answer to whether
the sequence matches.

</markdown>
</recipe>
