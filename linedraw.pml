<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.linedraw">
	<title>
		Sensor Art
	</title>
	
	<markdown>
	
A hypothical data format uses a character string to represent state
transitions in a two-state system.  For example, this might be the
status of some sort of electrical sensor.  Each string represents a
"signal" of some time duration.

The signal can occupy the "high" state for any duration, and it can
occupy the "low" state for any duration.  Moreover, the transition
between the two can either be "fast" or "slow", but it must stay in a
state for at least one time interval after each transition.

The format has a mnemonic version that uses simple ASCII art to
represent states and transitions.  However, it also has a letter based
version you may wish to play with instead, simply because some of the
line drawing characters have special meanings in regex syntax. Special
characters can be escaped, but it makes the patterns harder to read.

Some valid and invalid signals are below:

{:language="python"}
~~~
valid_1a = "_/^^^\_/^|___|^\____|^^\__/"
valid_1b = "LuHHHdLuHFLLLFHdLLLLFHHdLLu"
valid_2a = "____/^^^^^^"
valid_2b = "LLLLuHHHHHH"

invalid_1a = "_^/^^^/__\_"
invalid_1b = "LHuHHHuLLdL"
invalid_2a = "|\/|"
invalid_2b = "FduF"
invalid_3a = "__/^^|__X__/"
invalid_3b = "LLuHHFLLXLLu"
invalid_4a = "|_^|__"
invalid_4b = "FLHFLL"
~~~

Signals `valid_1a` and `valid_1b` represent the same measurement.  Where
'L' maps to '_' (low state), 'u' maps to '/' (up transition), 'd' maps
to '\\' (down transition),'H' maps to '^' (high state), and 'F' maps to
'|' (fast transition).  Likewise, `valid_2a` and `valid_2b` are
equivalent and simpler signals with just one up transition, but a
duration in each state.

The invalid signals are likewise matched up by the different character
options.  Signals `invalid_1a` or `invalid_1b` have *several* problems.
Low and high states are adjacent with no transition (not permitted).  An
alleged up transition occurs from the high state (also not permitted).
Likewise a down transition from the low state.  The chief problem with
`invalid_2a` or `invalid_2b` are that they have transitions with no
states in between, which is also prohibited.  In the case of
`invalid_3a` or `invalid_3b`, the states and transitions are generally
fine, but there is an invalid symbol thrown in.

You wish to define a regular expression that will match *all* and *only*
valid signal strings.  Pick which character set you wish to
define—"ASCII" or "linedraw", but not intermixed—and find the pattern
you need.

That is, find the pattern that will work *only if* regular expressions
are sufficienty powerful to perform this test. 

[aside important Before You Turn the Page]
<p>
    Find a matching pattern, if possible.
</p>
[/aside]

<pagebreak />

This puzzle *is* solvable with regexen.  There are a few observations to
keep in mind when thinking about it.  The rules for a valid signal
actually consist of just two constraints:

* All signals must be drawn only from the limited alphabet
* Only a subset of *digrams** of symbols are valid. 

In particular, since the alphabet is 5 symbols, there are 25 possible
digrams.  However, only 10 of those can occur in a valid signal.  You
might be tempted simply to match any number of repetitions of valid
digrams.  However, that would go wrong in examples like `invalid_4`.
Symbols 1 and 2 might form a valid digram, and symbols 3 and 4 might
also be a valid digram; but quite possibly symbols 2 and 3 are not a
valid digram together.

What we need to do is *lookahead* to two symbols, but then only match
one symbol.  Moreover, we need to consider the special case where the
regex engine is currently looking at the final symbol in the signal,
since that needs to be included as well.  So an alternate lookahead of
"anything then end" is used.  Notice that we can use the `.` wildcard
because the digram was already guaranteed by the *prior* lookahead in
the repetition.

Shown first is `patB` which matches the ASCII version of the format,
then the much more difficult to read `patA` which uses several symbols
requiring escaping for the pattern definition since they would otherwise
have regex meanings.

{:language="python"}
~~~
patB =  r'^(((?=LL|Lu|LF|HH|Hd|HF|uH|dL|FH|FL)|(?=.$))[LHudF])+$'

patA =  (r'^(((?=__|_/|_\||\^\^|\^\\|\^\||/\^|\\_|\|\^|\|_)'
         r'|(?=.$))[_\^/\\\|])+$')
~~~
	</markdown>
</recipe>
