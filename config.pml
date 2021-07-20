<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.config">
	<title>
		A Configuration Format
	</title>
	<markdown>
	
This exercise requires just a little bit of Python itself, but is mainly
about choosing the right regular expression.  Let's suppose you have a
configuration format that looks like this:

{:language="python"}
~~~
config = """
3 = foobar
14=baz
9= fizzbuzz
21=more_stuff,here
"""
~~~

With a little bit of code, and using a regular expression, you wish to
convert text in this format to a dictionary mapping the numbers to the
left of the equal sign to the strings to the right.  For example, the
above example would produce:

{:language="python"}
~~~
{3: 'foobar', 14: 'baz', 9: 'fizzbuzz', 21: 'more_stuff,here'}
~~~

[aside important Before You Turn the Page]
<p>
    Remember that shapes have edges
</p>
[/aside]
<pagebreak />

As the example shows, there seems to be flexibility in spaces around the
two sides of the equal sign.  We should probably assume zero or more
spaces are permitted on either side.  The format is probably slightly
surprising in that we would more commonly use words on the left and
numbers on the right in most formats; but it is well-defined enough, and
we can stipulate it has a purpose.

The easiest way to capture the relevant information is probably by using
groups for each side, which will be exposed by `re.findall()` and other
regular expression functions.  We *almost* get the right answer with
this:

{:language="python"} 
~~~
>>> dict(re.findall(r'^(\d+) *= *(.*)$', s, re.MULTILINE))
{'3': 'foobar', '14': 'baz', '9': 'fizzbuzz', '21': 'more_stuff,here'}
~~~

Notice that we required the "multiline" modifier to match on each line
of the string.  The one problem is that the puzzle requested that
numbers appear as numbers not as strings of digits.  There are a number
of ways we might achieve that in Python, but one easy one is:

{:language="python"}
~~~
>>> {int(k): v for k, v in 
            re.findall(r'^(\d+) *= *(.*)$', s, re.MULTILINE)}
{3: 'foobar', 14: 'baz', 9: 'fizzbuzz', 21: 'more_stuff,here'}
~~~

	</markdown>
	
</recipe>
