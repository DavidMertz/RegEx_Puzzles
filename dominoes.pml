<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.dominoes">
	<title>
		Playing Dominoes
	</title>
	
	<markdown>

Dominoes is an old family of games dating at least from the Yuan Dynasty
(around 1300 CE).  The game is played with tiles in which each half of
one side is marked, generally with a number of dots corresponding to a
number.  Specific games vary in their rules, but most require matching
the symbol or number on half of a tile with the corresponding symbols on
another tile.

There are, in fact, unicode characters for all the domino tiles having
zero to six dots on each half.  We will come back to those characters in
the next puzzle.  As a reminder, some of those Unicode characters are
listed in this table.

![Domino examples](images/Dominoes-examples.png){:width="60%"}

The actual codepoints are hard to enter, and hard to see unless they are
displayed at a large font size (as here).  But to illustrate the "game"
our regex will play, we can show examples of, first, a valid/winning
pattern:

![Dominoes good](images/Dominoes-good.png){:width="80%"} 

And second, an invalid/losing pattern:

![Dominoes bad](images/Dominoes-bad.png){:width="80%"} 

In this game, tiles are placed in linear order, and two may occur
adjacently only if they have the same number of dots where they "touch."
Unlike with physical tiles, these symbols may not be turned around, but
maintain the same left-right order.

Because of the display and entry problems mentioned, we play an
alternative version of this game in which "tiles" are spelled as ASCII
characters.  For example, the winning and losing patterns shown as
Unicode characters are as follows in their ASCII versions:

~~~
# Winning
{1:3}{3:3}{3:6}{6:1}{1:3}{3:3}{3:3}

# Losing
{1:3}{3:3}{6:1}{1:3}{3:3}{3:6}{3:3}
~~~

Plays may be of any length. Infinitely many tiles, with ends having the
numbers 1-6 in every combination, are available.  Write a regular
expression that distinguishes every winning play from a losing play.
Note that any character sequence that doesn't define a series of one or
more tiles is trivially losing.

[aside important Before You Turn the Page]
<p>
    You may be able to do this more efficiently than your first thought.
</p>
[/aside]
<pagebreak />

Because of our ASCII encoding we have a shortcut available for the
regular expression that can judge whether a play is winning.  This would
not be available with the icon characters for the domino tiles.  

The same digit must occur at the end of one tile, and again at the start
of the next tile.  Therefore, we can shortcut specifically matching '3's
with '3's and '5's with '5's.  Instead, we can just use a lookahead to
match a back reference group.

{:language="python"}
~~~
>>> good = '{1:3}{3:3}{3:6}{6:1}{1:3}{3:3}{3:3}'
>>> bad = '{1:3}{3:3}{6:1}{1:3}{3:3}{3:6}{3:3}' # mismatched ends
>>> awful = '{1:3}{{3:5}}{5:2}'  # malformed syntax

>>> pat = r'^(({[1-6]:([1-6])})(?=$|{\3))+$'

>>> for play in (good, bad, awful):
...     match = re.search(pat, play)
...     if match:
...         print(match.group(), "wins!")
...     else:
...         print(play, "loses!")
...
{1:3}{3:3}{3:6}{6:1}{1:3}{3:3}{3:3} wins!
{1:3}{3:3}{6:1}{1:3}{3:3}{3:6}{3:3} loses!
{1:3}{{3:5}}{5:2} loses!
~~~

	</markdown>
</recipe>
