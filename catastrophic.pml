<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.catastrophic">
	<title>
		Catastrophic Backtracking
	</title>
	
	<markdown>

In this puzzle, we imagine a certain message protocol (as we do in many
of the other puzzles).  We have an message alphabet that consists of the
following symbols:

| Code point | Name            | Appearance
|------------|-----------------|------------
| U+25A0     | Black Square    | ■
| U+25AA     | Black Sm Square | ▪
| U+25CB     | White Circle    | ○
| U+25C9     | Fisheye         | ◉
| U+25A1     | White Square    | □
| U+25AB     | White Sm Square | ▫
| U+25B2     | Black Up Triang | ▲
| U+25CF     | Black Circle    | ●
| U+2404     | End Transmit    | ␄

These geometric characters are attractive and are chosen to avoid
thinking of matches in terms of natural language words that some other
puzzles utilize.  However, feel free in solving it to substitute letters
or numerals, which are probably easier to type in your shell.  As long
as the correspondences are one-to-one, it doesn't matter what symbols
are used.

A message in this protocol consists of alternating blocks, belonging to
either "type 1" or "type 2".  Each block has at least one symbol in it,
but type 1 can have any of black square, black up triangle, white
circle, fisheye, or white square, in any number and order of each.  Type
2 blocks, in contrast, may have white small square, white square, black
small square, black circle, or black up triangle, in the same way.
Optionally, a space may separate blocks, but it is not required.

The "end of transmission" character indicates the end of a message.

An "obvious" pattern to describe a valid message apparently
matches appropriately. Some example are shown below:

~~~
Regex: (^(([■▲○◉□]+) ?([▫□▪●▲]+) ?)+)␄

Structure 1/2/1/2  | Message '■▲◉▫■▪▫␄' is Valid
Structure 1 2 1 2  | Message '■▲◉ ▫ ■ ▪▫␄' is Valid
Missing terminator | Message '■▲◉▫■▪▫' is Invalid
Structure 1 1 2 1  | Message '▲▲▲ ■■■ ▫▫▫ ○○○␄' is Invalid
~~~

The regex pattern shown actually *is* correct in a mathematical sense.
However, it can also become unworkably slow when checking some messages.
For example:

~~~
Quick match     | '■▲○◉□▫□▪●◉◉▫▪▪●●□□▲▲○○◉■■■▲▲□□◉▲␄' is Valid
                |  Checked in 0.00 seconds
Quick failure   | '■▲○◉■▲▫▪●●■■■▲▲◉◉◉■□□□▫▫▪●●●▫■■■␄' is Invalid
                |  Checked in 0.00 seconds
Failure         | '▲□□▲▲□□▲▲▲□□□□□□□□▲▲□▲□▲□▲X' is Invalid
                |  Checked in 4.42 seconds
Slow failure    | '▲□□▲▲▲□□▲▲▲□□□□□□□□▲▲□▲□▲□▲X' is Invalid
                |  Checked in 8.62 seconds
Exponential     | '▲▲▲▲▲▲□□▲▲▲□□□□□□□□▲▲□▲□▲□▲▲X' is Invalid
                |  Checked in 17.59 seconds
One more symbol | '▲▲▲▲□▲□□▲▲□▲□□□□□□□□▲▲□▲□▲□▲▲' is Invalid
                |  Checked in 31.53 seconds
~~~

Why does this happen?! Both the valid and the first invalid pattern
timed are longer than those that detect mismatches slowly.  You can see
that the time to determine the last four messages are invalid
approximately doubles with each additional character.

Before you look at explanation, both determine why this occurs and come
up with a solution using an alternate regular expression that still
validates the message format.  Your solution should take a small
fraction of a second in all cases (even messages that are thousands of
symbols long).

Note that as in other puzzles that use special characters for visual
presentation, you may find experimenting easier if you substitute
letters or numerals that are easy to type for the symbols used here.  It
doesn't change the nature of the puzzle at all; it merely might make it
easier to use your keyboard.

[aside important Before You Turn the Page]
<p>
    Try hard to avoid catastrophies.
</p>
[/aside]

<pagebreak />

The reason why the slow-failing messages fail is somewhat obvious to
human eyes.  None of them end with the "end-of-transmission" character.
As you can see, whether they end with an entirely invalid symbol `X` or
simply with a valid symbol and no terminator, is not significant.

You may want to think about whey the quick-failing message also fails.
Pause for a moment. 

But then notice that the final few symbols in that message are "black
square" which can only occur in type 1 blocks; a type 2 block must
always come immediatey before the end-of-transmission terminator.
Nonetheless, the regular expression engine figures that out in
(significantly) less than 1/100th of a second.

What you need to notice is that the symbol set overlaps between type 1
blocks and type 2 blocks. Therefore, it is ambiguous whether a given
symbol belongs to a given block or the next block.  If we simply look
for a match, *one possible* match is found quickly, when it exists.  For
example, this message that has only the ambiguous "white square" and
"black up triangle" validates immediately.  However we do not know how
many blocks of type 1 and how many of type 2 were created in the match
(pedantically, I know enough about the internals of the regular
expression engine to know that answer, but we are not guaranteed by the
API; it could be different in a later version of the library without
breaking compatibility).

~~~
Ambiguous quick | '▲▲▲▲□▲□□▲▲□▲□□□□□□□□▲▲□▲□▲□▲▲␄' is Valid
                |  Checked in 0.00 seconds
~~~

Regular expressions are not smart enough to look ahead to the final
symbol to make sure it is a terminator, unless we tell it to do so.  The
produced answer is still *eventually* correct, but it is not as
efficient as we would like.  The engine tries every possible permutation
of "some symbols in this block, some in that"—which is of exponential
complexity on the length of the message—before it finally decides that
none match.

Let's solve that by doing a little extra work for the engine.
Specifically, before we try to identify alternating type 1 and type 2
blocks, let's just make sure that the entire message is made up of valid
symbols that end with the terminator symbol.  That check will complete
almost instantly, and will eliminate very many (but not all) ways of
encountering catastrophic backtracking.

~~~
Regex: (^(?=^[■▲○◉□▫▪● ]+␄)(([■▲○◉□]+) ?([▫□▪●▲]+) ?)+)␄

Structure 1/2/1/2  | Message '■▲◉▫■▪▫␄' is Valid
Structure 1 2 1 2  | Message '■▲◉ ▫ ■ ▪▫␄' is Valid
Missing terminator | Message '■▲◉▫■▪▫' is Invalid
Structure 1 1 2 1  | Message '▲▲▲ ■■■ ▫▫▫ ○○○␄' is Invalid

Quick match     | '■▲○◉□▫□▪●◉◉▫▪▪●●□□▲▲○○◉■■■▲▲□□◉▲␄' is Valid
                |  Checked in 0.00 seconds
Quick failure   | '■▲○◉■▲▫▪●●■■■▲▲◉◉◉■□□□▫▫▪●●●▫■■■␄' is Invalid
                |  Checked in 0.00 seconds
Failure         | '▲□□▲▲□□▲▲▲□□□□□□□□▲▲□▲□▲□▲X' is Invalid
                |  Checked in 0.00 seconds
Slow failure    | '▲□□▲▲▲□□▲▲▲□□□□□□□□▲▲□▲□▲□▲X' is Invalid
                |  Checked in 0.00 seconds
Exponential     | '▲▲▲▲▲▲□□▲▲▲□□□□□□□□▲▲□▲□▲□▲▲X' is Invalid
                |  Checked in 0.00 seconds
One more symbol | '▲▲▲▲□▲□□▲▲□▲□□□□□□□□▲▲□▲□▲□▲▲' is Invalid
                |  Checked in 0.00 seconds
Ambiguous quick | '▲▲▲▲□▲□□▲▲□▲□□□□□□□□▲▲□▲□▲□▲▲␄' is Valid
                |  Checked in 0.00 seconds
~~~

	</markdown>
</recipe>
