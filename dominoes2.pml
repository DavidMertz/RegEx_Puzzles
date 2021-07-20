<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.dominoes2">
	<title>
		Advanced Dominoes
	</title>
	
	<markdown>

As the last puzzle showed, there are Unicode characters for domino
tiles.  In the last puzzle, we played a game of evaluating whether a
particular sequence of "tiles"—represented by ASCII sequences—were
winning plays. However, in that last puzzle, we took a shortcut by
taking advantage of the internal structure of the ASCII representation. 

It is not too hard to match domino tiles as their Unicode characters.
For example, this pattern matches any linear sequence of (horizontal)
tiles:

{:language="python"}
~~~
pat = (r'[\N{Domino Tile Horizontal-00-00}-'
         '\N{Domino Tile Horizontal-06-06}]+)'
~~~

Most of those sequences will not be winning plays, of course.  Recall the examples of winning and losing plays from the prior lesson:

Winning:

![Dominoes good](images/Dominoes-good.png){:width="80%"} 

Losing:

![Dominoes bad](images/Dominoes-bad.png){:width="80%"} 

For this game we will simplify in two ways.  First, rather than use
hard-to-enter and hard-to-see tile icons, we will use ASCII characters.
In fact, if we only want the tiles with numbers from 1-6 on their ends,
that gives us exactly 36 of them.  Conveniently, that happens to be the
same number of symbols as there are numerals plus capital letters (in
English).

However, this puzzle is simplified further by only utilizing four of the
36 possible tiles.  Each of those is given the following ASCII
representation.  The letters are not mnemonic, but at least they are
easy to type.

| Code point | Name                         | Substitute
|------------|------------------------------|------------
| U+1F03B    | Domino Tile Horizontal-01-03 | A
| U+1F049    | Domino Tile Horizontal-03-03 | B
| U+1F04C    | Domino Tile Horizontal-03-06 | C
| U+1F05C    | Domino Tile Horizontal-06-01 | D

Repeating our winning and losing examples with this encoding:

{:language="python"}
~~~
win  = 'ABCDABB'
lose = 'ABDABCB'
~~~

Plays may be of any length, and you have infinitely many of each of the
four tile types to use.  Write a regular expression that distinguishes
every winning play from a losing play.  Note that any character outside
the tile symbol set is trivially losing.

[aside important Before You Turn the Page]
<p>
    Thoughts about digrams are always pleasant thoughts.
</p>
[/aside]
<pagebreak />

It probably comes as no surprise to you that a larger tile set would
require a larger regular expression to match winning plays.  But the
principle would remain the same if you used more tiles, up to all of
them.

The basic idea here is that you want each tile to be followed by a tile
from some subset of other tiles. Namely, those that begin with the same
number of dots that the current tile ends with.
 
Of course, a given tile might be the end of a play, so you have to
include that option in your lookahead pattern.  You also definitely want
a match to begin at the start of the play and end at the end of the
play, so be sure to include the match patterns `^` and `$` to indicate
that.

{:language="python"}
~~~
>>> win = 'ABCDABB'
>>> lose = 'ABDABCB'
>>> pat = r'^(A(?=$|[BC])|B(?=$|[BC])|C(?=$|D)|D(?=$|A))+$'
>>> re.search(pat, win)
<re.Match object; span=(0, 7), match='ABCDABB'>
>>> re.search(pat, lose) or "No Match"
'No Match'
~~~

	</markdown>
</recipe>
