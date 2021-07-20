<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.numbers">
	<title>
	    Matching a Numeric Sequence 
	</title>
	<markdown>

Here's a giveaway for you.  This puzzle is *possible* to solve.  I won't
give you that same assurance when I describe the next two (related)
puzzles.

Regular expressions do not really understand numbers.  A '7' or a '777'
might be sequences of digits matched in a string, but they are not
fundamentally different, to regexen, than any other character patterns.
Quantifiers can express numbers, either 0/1 with '?', 0 or more with
'*', or 1 or more with '+'.  In extended regexen like Python uses, we
can even express specific counts like '{3, 6}' for "at least three and
not more than 6."  But those are specific numbers, not calculated
quantities.

Nonetheless, we would like to recognize a distinct integer sequence, and
rule out other integer sequences, using a regular expression.  The trick
here is that we can represent integer as repetitions of the same
character, and the number of such repetitions can (to us, at least)
represent numbers.  

Specifically, for this puzzle, you would like to identify strings that
represent successive doublings, and exclude all strings that do not
have that pattern.  We use the symbol '@' for one unit simply because it
is available and doesn't have special meaning with regex patterns.
Spaces can separate numbers from each other. So for example:

{:language="python"}
~~~
>>> s1 = "@@@ @@@@@@ @@@@@@@@@@@@ " # 3 6 12
>>> s2 = "@ @@ @@@@ @@@@@@@@ @@@@@@@@@@@@@@@@ " # 1 2 4 8 16
>>> s3 = "@@ @@@@ @@@@@ @@@@@@@@@@ " # 2 4 5 10
>>> s4 = "@ @ @@ @@@@ " # 1 1 2 4
>>> for s in (s1, s2, s3, s4):
...     match = re.search(pat, s)
...     if match:
...         print("VALID", match.group())
...     else:
...         print("INVALID", s)
...
VALID @@@ @@@@@@ @@@@@@@@@@@@
VALID @ @@ @@@@ @@@@@@@@ @@@@@@@@@@@@@@@@
INVALID @@ @@@@ @@@@@ @@@@@@@@@@
INVALID @ @ @@ @@@@
~~~

The pattern you come up with should match strings of any length that
follow the doubling sequence, and should reject strings of any length
that fail to follow it all the way to their end.  The final "number" in
a string will always be followed by a space, otherwise it won't have
been terminated and shouldn't match.

[aside important Before You Turn the Page]
<p>
    Be sure to rule out the strings that do not express the sequence.
</p>
[/aside]
<pagebreak />

Let's start with the solution, then explain why it works.

{:language="python"}
~~~
pat = r"^(((@+) )(?=\3\3 ))+(\3\3 )$"
~~~

What we do here is several steps:

First, make sure we are beginning at the start of the string ('^').  This
is where 's4' failed, it doubles as a suffix, but we are required to
start at the beginning.

Second, match at least one '@' symbol, up to however many occur in a
row.  After that group of '@'s, we have a space that is not part of the
group.

Third, *lookahead* to a pattern that has twice as many '@' symbols as
the group we last saw.  I spelled that as `\3\3`, which feels intuitive,
but you could likewise spell it as `\3{2}` to mean the same thing.

Fourth, and finally, after all those repetitions of lookaheads and
groups, collect the same pattern as the lookahead just before the end of
the string.  We want to have the entire sequence in `match.group()`, not
to leave off the last "number."

</markdown>
</recipe>
