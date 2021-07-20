<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.poker3">
	<title>
		Playing Poker (Part 3)
	</title>
	
	<markdown>

In this puzzle let's continue with matching poker hands.  We handled
straights and flushes in the last puzzle (and straight flushes by
obvious combination).  There are some other types of hands to consider 
now.

The next several types of hand have containing relationships among them.
That is, just like a straight flush is both a straight and a flush,
four-of-a-kind is trivially also three-of-a-kind and a pair.  A full
house is both three-of-a-kind and a pair.  However, for our purposes, we
will simply assume the various tests are performed in appropriate
descening order of strength.  The first successful test will be the
classified type of the hand.

For the next few puzzles, therefore write these functions:

* `is_four_of_kind(hand)`
* `is_full_house(hand)`
* `is_three_of_kind(hand)`
* `is_two_pairs(hand)`
* `is_pair()`

This and the next frew puzzles cover the various functions. See if you
can solve all of them (possibly using shared functionality) before
looking at the discussion.

[aside important Before You Turn the Page]
<p>
    Functions are a big help in larger programs.
</p>
[/aside]
<pagebreak />

If we have a four-of-a-kind, then the kind must occur in either the
first or second card.  In fact, if we retain our assumption that the
cards are completely ordered, then the four can only occur as the
initial four or the final four.  But the following implementation does
not rely on that ordering:

{:language="python"}
~~~
>> def is_four_of_kind(hand):
...     hand = re.sub(r'[^AKQJT98765432]', '', hand)
...     pat = r'^.?(.)(.*\1){3}'
...     match = re.search(pat, hand)
...     # Return the card number as truthy value
...     return match.group(1) if match else False
...
>>> is_four_of_kind('6H 6D 6S 6C 3S') # sorted
'6'
>>> is_four_of_kind('6♦ 3♠ 6♥ 6♠ 6♣') # not sorted
'6'
>>> is_four_of_kind('6H 6D 6S 4C 3S') # not four-of-kind
False
~~~

The first step is to remove everything that isn't a card number.  Then
we either match nothing or the first character of the simplified hand.
In the zero-width case, the following group will get the number of the
first card.  In the one-width case, the group will capture the second
card.

The group simply grabs one character, then we must find 3 more copies of
that group, but allow any prefix before each repetition.  If we promised
that the hand was always ordered the extra stuff before the back
reference would not be needed, but it does no harm in being zero width.

	</markdown>
</recipe>
