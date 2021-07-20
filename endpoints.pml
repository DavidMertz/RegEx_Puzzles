<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.endpoints">
	<title>
		Endpoint Classes
	</title>
	<markdown>
	
This puzzle continues the word matching theme of the last two puzzles.
However, here we have a new wrinkle.  We would like to identify *both*
words that start with 'x' and end with 'y', but *also* words that start
with 'y' and end with 'x'.

Remembering the word boundary special zero-width pattern we already saw, a first try at this task might be:

{:language="python"}
~~~
>>> txt = """
expurgatory xylometer yex xenomorphically exquisitely
xylology xiphosurans xenophile yunx oxytocin xylogen
xeriscapes xerochasy inexplicably yonderly inexpressibly
extremity xerox xylographic complexly vexillology
xanthenes xylenol xylol yexing xylenes coextensively
>>> pat6 = re.compile(r'\b[xy][a-z]*[xy]\b')
>>> re.findall(pat6, txt)
['yex', 'xenomorphically', 'xylology', 'yunx', 'xerochasy', 
'yonderly', 'xerox']
"""
~~~

What went wrong there? Clearly we matched some words we do not want,
even though all of them began with 'x' or 'y' and ended with 'x' or 'y'.

[aside important Before You Turn the Page]
<p>
    Try to refine the regular expression to match what we want. 
</p>
[/aside]
<pagebreak />

The first pattern shown allows for either 'x' or 'y' to occur at either
the beginning or the end of a word.  The word boundaries are handled
fine, but this allows words both beginning and ending with 'x', and
likewise beginning and ending with 'y'.  The character classes at each
end of the overall pattern are independent.

This may seem obvious on reflection, but it is very much like errors I
myself have made embarrassingly many times in real code. A robust
approach is simply to list everything you want as alternatives in a
pattern.

{:language="python"} 
~~~
>>> pat7 = re.compile(r'\b((x[a-z]*y)|(y[a-z]*x))\b')
>>> [m[0] for m in re.findall(pat7, txt)]
['yex', 'xenomorphically', 'xylology', 'yunx', 'xerochasy']
~~~

In this solution, there is a little bit of Python specific detail in the
function API.  The function `re.findall()` returns tuples when a pattern
contains multiple groups.  Group 1 will be the whole word, but one or
the other of group 2 and 3 will be blank, i.e.:

{:language="python"} 
~~~
>>> re.findall(pat7, txt)
[('yex', '', 'yex'), 
('xenomorphically', 'xenomorphically', ''), 
('xylology', 'xylology', ''), 
('yunx', '', 'yunx'), 
('xerochasy', 'xerochasy', '')]
~~~

	</markdown>
	
</recipe>
