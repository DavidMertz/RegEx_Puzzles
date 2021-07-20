<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.poker4">
	<title>
		Playing Poker (Part 4)
	</title>
	
	<markdown>

Keeping in mind that we need only minimally identify each type of hand
within the corresponding function, not rule out other higher ranked
hands, we can take several different approaches to poker regexen.

Recall our possible hands:

* `is_four_of_kind(hand)`
* `is_full_house(hand)`
* `is_three_of_kind(hand)`
* `is_two_pairs(hand)`
* `is_pair()`

Four-of-a-kind we did in the last puzzle, so now we want to deal with a
full house.  Write a function, using regular expressions as much as
possible, to identify a hand that contains a full house.

[aside important Before You Turn the Page]
<p>
    You might risk identifying the "dead man's hand".
</p>:b p
[/aside]
<pagebreak />

One approach you might take for this puzzle is to identify both
`is_three_of_kind()` and `is_pair()` in the same hand.  Every full house
will match those functions.  However, in many of the obvious
implementations of those support functions, the two initial cards that
make up a triple would trigger `is_pair()` even if the last two cards
are unmatched.  There are ways to make that work, but let's instead do
it directly.

For this solution we use regular expressions to strip the suits, and
also to match the actual pattern.  We can utilize the `cardsort()`
function from an earlier puzzle to guarantee the hand is sorted; we also
make sure it is the "pretty" version rather than the ASCII version since
sorting assumes that.

The pattern itself is either two of the high number followed by three of
the low number, or three of the high number followed by two of the low
number.  For later use, we can be extra nice in by returning the 3-card
number first as the "truthy" value in a match.  In most poker rules, the
3-card match takes precedence when the same hands are evaluated for the
win.

{:language="python"}
~~~
>>> def is_full_house(hand):
...     try:
...         hand = prettify(hand)
...     except:
...         pass  # Already pretty
...     hand = cardsort(hand)
...     hand = re.sub(r'[^AKQJT98765432]', '', hand)
...     # Either three of suit then two of other, or
...     # Two of suit then three of other
...     pat = r"^((.)\2{1,2})((.)\4{1,2})$"
...     match = re.search(pat, hand)
...     if not match:
...         return False
...     elif len(match.group(3)) > len(match.group(1)):
...         return hand[4] + hand [0]
...     else:
...         return hand[0] + hand[4]

>>> is_full_house(prettify('AS AC 8H 8D 8C'))
'8A'
>>> is_full_house(prettify('AS AH AC 8D 8C'))
'A8'
>>> is_full_house(prettify('AS AH JD 8D 8C'))
False
~~~

Obviously, this solution involves a moderate amount of non-regex Python.
But the heart of it is the same reduction to number-only we saw with
`is_four_of_kind()` followed by the pattern described.  The just-Python
part is really only to provide the friendly truthy values, not in asking
the predicate itself.

	</markdown>
</recipe>
