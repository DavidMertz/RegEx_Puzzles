<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.primes">
	<title>
		Matching the Prime Numbers
	</title>
	<markdown>

Perhaps surprisingly, in the last puzzle we were able to match
Fibonacci-like sequences using regular expressions.  Let's turn next to
whether we might do the same thing with prime numbers.  In particular,
if you can find it, your regular expression(s) will only need to match
initial sequences of the primes, but all such initial sequences.

As in the last two puzzles, we encode numeric sequences using a number
of contiguous '@' symbols, with each "number" separated by spaces. For
example:

{:language="python"}
~~~
# Match: 2 3 5 7
primes4 = "@@ @@@ @@@@@ @@@@@@@ "
# Match: 2 3 5 7 11
primes5 = "@@ @@@ @@@@@ @@@@@@@ @@@@@@@@@@@ "
# Fail: 2 3 7 11
fail1 = "@@ @@@ @@@@@@@ @@@@@@@@@@@ "
# Fail: 2 3 4 5 7
fail2 = "@@ @@@ @@@@ @@@@@ @@@@@@@ "
~~~

The Sieve of Erathosthenes is a lovely and ancient algorithm for finding
all the prime numbers.  It "strikes out" each multiple of a prime as it
steps through all the natural numbers, leaving only primes thereby.  In
a compact Python implementation it can look like the below (this can be
made much more efficient, but at the price of more code).

{:language="python"}
~~~
def get_primes():
    "Simple lazy Sieve of Eratosthenes"
    candidate = 2
    found = []
    while True:
    	if all(candidate % prime != 0 for prime in found):
        	yield candidate
            found.append(candidate)
        candidate += 1
~~~

The form of the Sieve is definitely reminiscent of lookahead assertions
which we have used in many of the puzzles.  Think about whether you can
implement this using regular expressions (don't think about performance
for this puzzle).  Before you look at the discussion, try to either find
a regular expression to match the valid sequences or formulate clearly
why you cannot.

[aside important Before You Turn the Page]
<p>
    Honor the Fundamental Theorem of Arithmetic.
</p>
[/aside]
<pagebreak />

This puzzle turns out to be another one that exceeds the ability of
regular expressions.  On the face of it, it might seem like *negative
lookahead assertions* are exactly what you would use to implement the
Sieve, or something akin to it.  That is, if some group matched, e.g.
`(@@@)` or `(@+)`, then you should be able to backreference to a
repetition of that group.

Let's say the hypothetical group was number 7.  In that case, a negative
lookahead assertion like `(?! \7{2,} )` would state precisely that no
contiguous number of '@' symbols whose count is a multiple of the number
in the prior match group occur later in the string.  That sounds a lot
like what the Sieve does.

Negative lookahead is indeed a powerful and useful technique.  In fact,
you could perfectly well implement a partial sieve to exclude all the
multiples of the first N primes from occuring in a candidate string.
The problem is that regular expressions can only have a finite number of
match groups by definition.  That is, regular expressions are a way of
expressing *finite state* machines.  The exact maximum number of groups
can vary between regex engines; it is 100 in the Python standard library
`re` module, 500 in the third-party `regex` module, and various other
numbers in other programming languages or libraries.  But it is always a
finite number.

To match *every* string of initial primes, we need to "strike out"
indefinitely many primes along the way.  This same problem would occur for
every other sequential prime-finding algorithm.  There do exist direct
primality tests that do not iterate through the smaller primes, such as the
probabalistic Miller–Rabin test[^fn-grh] or the deterministic
Agrawal–Kayal–Saxena test.  However, all of those require mathematical
calculations that are not possible in regular expressions.

[^fn-grh]: The Miller-Rabin test can be made deterministic if the Generalized Riemann hypothesis holds.

</markdown>
</recipe>
