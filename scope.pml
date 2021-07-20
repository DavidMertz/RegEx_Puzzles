<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">
<recipe id="rcp.scope">
	<title>
		Wildcard Scope
	</title>
	<markdown>
	
A powerful element of Python regular expression syntax—shared by many other
regex engines—is the option of creating either "greedy" or "non-greedy"
matches.  The former matches as much as it possibly can, as long as it finds
the later part of a pattern.  The latter matches as little as it possibly can
to reach the next part of a pattern.

Suppose you have these two regular expressions:

{:language="python"}
~~~
pat1 = re.compile(r'x.*y')    # greedy
pat2 = re.compile(r'x.*?y')   # non-greedy
~~~

And also this block of text that you want to match.  You can think of it as a
sort of *lorem ipsum* that only has 'X' words, if you will.

{:language="python"}
~~~
txt = """
xenarthral xerically xenomorphically xebec xenomania 
xenogenic xenogeny xenophobically xenon xenomenia 
xylotomy xenogenies xenografts xeroxing xenons xanthous 
xenoglossy xanthopterins xenoglossy xeroxed xenophoby 
xenoglossies xanthoxyls xenoglossias xenomorphically 
xeroxes xanthopterin xebecs xenodochiums xenodochium
xylopyrography xanthopterines xerochasy xenium xenic 
"""
~~~

You'd like to match all and only words that start with 'X' and end with
'Y'.  What pattern makes sense to use, and why?  The code to find the
words can look like:

{:language="python"}
~~~
xy_words = re.findall(_pat, txt)
~~~

[aside important Before You Turn the Page]
<p>
    Think about what each pattern will match.
</p>
[/aside]

<pagebreak />

Did this puzzle fool you? Welcome to the world of regular expressions!
Both `pat1` and `pat2` match the wrong thing, but in different ways.

If you liked `pat1`, you've greedily matched too much. The 'y' might
occur in later words (per line), and the match won't end until the last
'y' on a line.

{:language="python"}
~~~
>>> for match in re.findall(pat1, txt):
...     print(match)
...
xenarthral xerically xenomorphically
xenogenic xenogeny xenophobically
xylotomy
xenoglossy xanthopterins xenoglossy xeroxed xenophoby
xenoglossies xanthoxyls xenoglossias xenomorphically
xylopyrography xanthopterines xerochasy
~~~

On each line, the greedy pattern started at the first 'x', which is
often not what you want.  Moreover, most lines match multiple words,
with only the line beginning with 'xylotomy' happening to be the only
word we actually want.  The line that begins with 'xeroxes' is not
matched at all, which is what we want.

If you liked `pat2` you often get words, but at other times either 
too much *or too little* might be matched.  For example, if 'xy' occurs 
in a longer word, either as a prefix or in the middle, it can also match. 

{:language="python"}
~~~
>>> for match in re.findall(pat2, txt):
...     print(match)
...
...
xenarthral xerically
xenomorphically
xenogenic xenogeny
xenophobically
xy
xenoglossy
xanthopterins xenoglossy
xeroxed xenophoby
xenoglossies xanthoxy
xenoglossias xenomorphically
xy
xanthopterines xerochasy
~~~

By being non-greedy, we stop when the first 'y' is encountered, but as
you see, that still is not quite what we want.

What we actually need to focus on for this task is the *word
boundaries*. Things that are not letters (for our wordlist, all are
lowercase) cannot be part of matches. In this simple case, non-letters
are all spaces and newlines, but other characters might occur in other
texts.
 
We can be greedy to avoid matching prefixes or infixes, but we also 
want to ignore non-letter characters..

{:language="python"}
~~~
>>> pat3 = re.compile(r'x[a-z]*y')
>>> for match in re.findall(pat3, txt):
...     print(match)
...
xerically
xenomorphically
xenogeny
xenophobically
xylotomy
xenoglossy
xenoglossy
xenophoby
xanthoxy
xenomorphically
xylopyrography
xerochasy
~~~

Everything we matched, anywhere on each line, had an 'x', some other
letters (perhaps including 'x's or 'y's along the way), then a 'y'.
Whatever came after each match was a non-letter character.

	</markdown>
	
</recipe>
