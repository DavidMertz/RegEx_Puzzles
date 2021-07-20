<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.nodup">
	<title>
		Match Before Duplicate Words
	</title>
	<markdown>

If you looked at the last puzzle, you saw that some match patterns you
might anticipate to be possible with regular expressions are actually
not expressible with regexen.  Think about whether this puzzle is
possible, and if so how.
	
Write a regular expression that will match all the initial words of a
string (including any punctuation or spacing that might surround words),
stopping before any word that is duplicated in the string.  For example:

{:language="python"}
~~~
s1 = "this and that not other"
assert re.match(pat, s1).group() == s1
~~~

Remember that `re.match()` always starts at the beginning of a string
when looking for a match.  If you preferred `re.search()` you would need
to begin the pattern with `^`.  In the first example no word is
duplicated in the phrase, and therefore the entire phrase matches.  In
contrast:

{:language="python"}
~~~
s2 = "this and that and other"
assert re.match(pat, s2).group() == 'this '
~~~

The second example is a little different.  The first word 'this' never
reoccurs.  But the second word 'and' does occur later in the phrase, and
therefore it, and everything following the duplicated word must be
excluded.

[aside important Before You Turn the Page]
<p>
    Find a pattern that will fulfill the requirment.
</p>
[/aside]
<pagebreak />

This match pattern is indeed possible to write as a regular expression.
We need to use back references to check it, but those are a standard
feature of reqular expression engines.

{:language="python"}
~~~
pat = r'((\w+\b)(?!.*\2\b)\W*)+'
~~~

As well as the back reference, we use a negative lookahead assertion.
That is, the basic thing being matched is `(\w+\b)\W*)+`.  That is to
say, match one or more alphanumeic characters `\w` followed by a word
boundary.  That "word" might be followed by zero or more
non-alphanumeric characters.  Then overall, match one or more
repetitions of that general pattern.

So far, so good. But we have not excluded the repeated words.  We do
that with the negative lookahead, `(?!.*\2\b)`.  That is, we want to
look through the entire rest of the string being evaluated, and make
sure that we do not encounter the same word currently matched.  The
initial `.*` just matches any number of characters, but the `\2` is the
actual current word.  We still use word boundary in the negative
lookahead because a longer word of which the current word is a prefix
would be permitted.

Keep in mind how groups are numbered.  Since there are parentheses
surrounding the entire expression (other than the `+` quantifier), that
whole thing is group 1.  So the first subpattern inside of that,
matching the current word, is group 2, hence named as `\2`.

	</markdown>
</recipe>
