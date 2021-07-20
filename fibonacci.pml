<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.fibonacci">
	<title>
		Matching the Fibonacci Sequence
	</title>
	<markdown>

Here we get to something harder than the last puzzle.  It is not obvious
whether regular expressions are powerful enough to express this
sequence.  Think about your solution, or the reasons it is impossible,
before you turn the page.

The Fibonacci sequence is a famous recursive relationship, in which each
number in the sequence is the sum of the prior two numbers.  Hence, the
first few Fibonacci numbers are:

~~~
1 1 2 3 5 8 13 21 34 55 89 144
~~~

In fact, the Fibonacci sequence is only one of an infinite number of
similar recursive sequences, known generally as Lucas sequences.  The
Lucas numbers are one such sequence in which the initial elements are 2
and 1 (rather than 1 and 1).  We are actually interested here in
matching "Fibonacci-like" sequences, where given two elements, the next
one is the sum of those prior two.

As in the last puzzle, we represent numeric sequences by a number of
repetitions of the '@' symbol followed by spaces.  For example:

{:language="python"}
~~~
# Match: 1 1 2 3 5 8
fibs = "@ @ @@ @@@ @@@@@ @@@@@@@@ "
# Match: 2 1 3 4 7 11
lucas = "@@ @ @@@ @@@@ @@@@@@@ @@@@@@@@@@@ " 
# Match: 3 2 5 7 12 19
fib2 = "@@@ @@ @@@@@ @@@@@@@ @@@@@@@@@@@@ @@@@@@@@@@@@@@@@@@@ " 
# Fail: 1 1 3 4 7 11 
wrong1 = "@ @ @@@ @@@@ @@@@@@@ @@@@@@@@@@@ "
# Fail: 1 1 2 3 4 7
wrong2 = "@ @ @@ @@@ @@@@ @@@@@@@ "
~~~

Can you create a regular expression that matches only Fibonacci-like
sequences within encoded strings?

[aside important Before You Turn the Page]
<p>
    The Golden Spiral beautifully generalizes the Fibonacci Numbers.
</p>
[/aside]
<pagebreak />

It turns out, matching properly encoded Fibonacci-like sequences is
within the power of regular expressions.  Adding together two prior
elements is actually a lot like simply doubling the one prior element as
we did in the last puzzle.

The main difference in the solution to this puzzle versus the last one
is that we need to backreference two groups in the lookahead pattern
rather than just one.  Study the explanation of the last puzzle before
looking at the solution to this one.

{:language="python"}
~~~
>>> pat1 = r"^(((@+) (@+) )(?=$|\3\4 ))+(\3\4)?$"
>>> pat2 = r"^@+ (((@+) (@+) )(?=\3\4 ))+"
>>> for s in (fibs, lucas, fib2, wrong1, wrong2):
...     match = re.search(pat1, s)
...     if match and re.search(pat2, s):
...         print("VALID", match.group())
...     else:
...         print("INVALID", s)
...
VALID @ @ @@ @@@ @@@@@ @@@@@@@@
VALID @@ @ @@@ @@@@ @@@@@@@ @@@@@@@@@@@
VALID @@@ @@ @@@@@ @@@@@@@ @@@@@@@@@@@@ @@@@@@@@@@@@@@@@@@@
INVALID @ @ @@@ @@@@ @@@@@@@ @@@@@@@@@@@
INVALID @ @ @@ @@@ @@@@ @@@@@@@
~~~

Actually, there are two extra caveats here.  We assume in this solution
that an even number of numbers are represented in the string.  The
lookahead only evaluates the one next number (that must be the sum of
the current two numbers).  However, this means that we match two
different '@' sequences at a time; and hence that there must be an even
number if we match to the end.

The second issue is that since we stride two-by-two through the
"numbers", we need to use a second regular expression to make sure the
sequence *predicts* the next element when offset by one element as well.
We see that problem in `wrong1`. If we only utilized `pat1` it would
incorrectly match as Fibonacci-like. Since `pat1` already collects the
final "number", there is no need for `pat2` to do so as well, the
lookahead suffices.

</markdown>
</recipe>
