<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.naming">
    <title>
        Finding a Name for a Function
    </title>
<markdown>
	
Suppose you come across some code that a previous employee on your
project, long moved on an unavailable wrote.  Their code passes unit
tests and integration tests, so probably it does the right thing.  But
they have not given a useful name or documentation for a certain
function:

{:language="python"}
~~~
def is_something(s):
    return not re.match(r'^(.+?)\1+$', s)
~~~

For this puzzle, simply provide a good name and a docstring for this
function, to be kind to later programmers.

[aside important Before You Turn the Page]
<p>
    Code is read far more often than it is written...
</p>
[/aside]


<pagebreak />

This puzzle certainly has many possible answers.  For all of them,
understanding what the regular expression is doing is the crucual
element.  The short pattern might look odd, and you need to figure it
out.  Here is a possibility.

{:language="python"}
~~~
def repeated_prefix(s):
    """Look for any prefix string in 's' and match only if that
    prefix is repeated at least once, but it might be repeated
    many times.  No other substring may occur between the start 
    and end of the string for a match.
    """
    return not re.match(r'^(.+?)\1+$', s)
~~~

	</markdown>
</recipe>
