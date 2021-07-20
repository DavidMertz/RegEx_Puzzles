<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.count">
	<title>
		Reimplementing str.count()
	</title>
	<markdown>

The Python method `str.count()` is widely useful to find substrings
inside a larger string.  For example, here is some typical code you
might write: 

{:language="python"}
~~~
# Lyric from song "Hot Knife" by Fiona Apple
>>> s = """If I'm butter, if I'm butter
If I'm butter, then he's a hot knife
He makes my heart a CinemaScope screen
Showing the dancing bird of paradise
"""
>>> s.count('e')
15
>>> s.count('tt')
3
~~~

Imagine that Python did not have the method `str.count()` but you wished
to implement a similar function by utiizing regular expressions, with
the signature:

{:language="python"}
~~~
def my_count(substring: str, string: str) -> int:
    # re.sub(..., ...)  # maybe something like this?
    ...
~~~

[aside important Before You Turn the Page]
<p>
    How can a regex count the substring occurrences?
</p>
[/aside]

<pagebreak />

Two functions in the Python `re` module seem especially likely to be
useful.  The `re.sub()` function will replace a pattern with something
else.  We might try a solution using that, for example:

{:language="python"}
~~~
>>> def my_count(substring, string):
...     return len(re.sub(fr"[^{substring}]", "", string))
>>> my_count('e', s)
15
>>> my_count('tt', s)   # Oops, this goes wrong
10
~~~

So that try is not quite correct. It will count single characters fine,
but for larger substrings it gets confused.  In the example, the
inversion of the character class is `[^tt]` which is the same as
simply being "not a 't'".  In other words, we counted the 't's not
the 'tt's.  Even if the substring hadn't been the same letter twice,
we would count the individual letters in the pattern.

We can fix this with a more complex regular expression (think about how
as a bonus puzzle), but even easier is using `re.findall()`:

{:language="python"}
~~~
>>> def my_count(substring, string):
...     return len(re.findall(fr"{substring}", string))
>>> my_count('e', s)
15
>>> my_count('tt', s)
3
~~~

</markdown>
</recipe>
