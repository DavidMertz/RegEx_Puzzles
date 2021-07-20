<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">
<recipe id="rcp.scope2">
	<title>
		Words and Sequences
	</title>
	<markdown>
	
In the previous problem, we identified words that started with 'x' and
ended with 'y'.  You may have noticed, however, that we had already
included the assumption that all the words started with 'x'.  Perhaps
your solution was clever enough not to fall for the danger shown in this
puzzle.  Namely, perhaps not all words will actually start with 'x' to
begin with.
 
{:language="python"}
~~~
>>> txt = """
expurgatory xylometer xenotime xenomorphically exquisitely
xylology xiphosurans xenophile oxytocin xylogen
xeriscapes xerochasy inexplicably exabyte inexpressibly
extremity xiphophyllous xylographic complexly vexillology
xanthenes xylenol xylol xylenes coextensively
"""
>>> pat3 = re.compile(r'x[a-z]*y')
>>> re.findall(pat3, txt)
['xpurgatory', 'xy', 'xenomorphically', 'xquisitely', 
'xylology', 'xy', 'xy', 'xerochasy', 'xplicably', 'xaby', 
'xpressibly', 'xtremity', 'xiphophy', 'xy', 'xly', 
'xillology', 'xy', 'xy', 'xy', 'xtensively']
~~~

As you can see, we matched a number of substrings within word, not only
whole words.  What pattern can you use actually to match only words that
start with 'x' and end with 'y'?

[aside important Before You Turn the Page]
<p>
    Think about what defines word boundaries.
</p>
[/aside]
<pagebreak />

There are a few ways you might approach this task.  The easiest is to
use the explicit "word boundary" special *zero-width match* pattern,
spelled as `\b` in Python and many other regular expression engines.

{:language="python"}
~~~
>>> pat4 = re.compile(r'\bx[a-z]*y\b')
>>> re.findall(pat4, txt)
['xenomorphically', 'xylology', 'xerochasy']
~~~

Less easy ways to accomplish this include using look-ahead and
look-behind to find non-matching characters that must "bracket" the
actual match.  For example:

{:language="python"}
~~~
>>> pat5 = re.compile(r'(?<=^|(?<=[^a-z]))x[a-z]+y(?=$|[^a-z])')
>>> re.findall(pat5, txt)
['xenomorphically', 'xylology', 'xerochasy']
~~~

One trick here is that when we perform a look-behind assertion, it must
have a fixed width of the match.  However, words in our list might
either follow spaces or occur at the start of a line.  So we need to
create an alternation between the zero-width look-behind and the one
non-letter character look-behind. For the look-ahead element, it is
enough to say it is *either* end-of-line (`$`) *or* is a non-letter
(`[^a-z]`).

	</markdown>
	
</recipe>
