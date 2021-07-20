<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.matchcount">
	<title>
		Identifying Equal Counts
	</title>
	<markdown>
	
At times we encounter a message or a stream that uses balanced
"increment" and "decrement" symbols.  For example, one way to check that
a message has terminated might be to match up the increments and
decrements.  The same concept would apply to many kinds of messages and
symbols—perhaps you'd like to set the table with the same number of
forks and knives, for example.

As a simplification of the general problem, write a regular expression
that matches strings that consist  of any number of 'A' characters,
followed by the same number of 'B' characters. 

For example `AAABBB` and `AAAAAAABBBBBBB` should match, while
`AAAABBBBBB` should fail to match.

[aside important Before You Turn the Page]
<p>
    Lateral thinking might help you find the answer.
</p>
[/aside]
<pagebreak />

You cannot match patterns based on having an equal number of different
symbols using regular expressions.  Or at least you cannot do so in the
general case.  It is, of course, perfectly possible to require exactly
seven 'A's and exactly seven 'B's.  But if the count is arbitrarily
large, the kind of "machine" that can match the message requires
additional power.

In computer science or mathematical terms, a regular expression is
equivalet to a *nondeterministic finite automaton* (NFA), where a regex
provides a very compact spelling of such an NDA.  More powerful machines
include *pushdown automata* (PDA) which have an indefinitely large
"stack" of stored symbols.  One most often encounters PDAs as parsers.
A PDA, even the nondeterministic variety remains formally less powerful
than a Turing Machine.

In simple terms, if you want to count occurrences, you need to use
variables that can store a number (or a data structure like a list to
hold the symbols).

Many new users of regexen fall into a trap of hoping this puzzle is
solvable. Or more often still, something equivalent like matching up
opening and closing parentheses, brackets, or XML/HTML tags.  *Hic sunt
dracones*! (here be dragons).

	</markdown>
</recipe>
