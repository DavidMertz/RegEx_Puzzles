<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.poker5">
	<title>
		Playing Poker (Part 5)
	</title>
	
	<markdown>

In the last couple puzzles we identified four-of-a-kind and full house.
Much of the logic for this puzzle will be similar to those, but
obviously tweaked somewhat for the next cases.

All you have left in our poker regex family is to identify
three-of-a-kind, a pair, and two pairs.  As before, you may assume that
tests for various hands will run in descending order of strength.  So,
for example, if your test for a pair will incidentally detect a hand
that has four-of-a-kind, that is not a problem since it indeed ipso
facto has a pair.

Create these three functions in this puzzle:

* `is_three_of_kind(hand)`
* `is_two_pairs(hand)`
* `is_pair()`

[aside important Before You Turn the Page]
<p>
    Remember that three is more than two, but less than four.
</p>
[/aside]
<pagebreak />

Identifying two or three of a kind is a lot like identifying
four-of-a-kind, just with fewer repetitions.  We could do it without
sorting the hand, but doing so, as with our full house solution, is a
bit easier.

{:language="python"}
~~~
>>> def is_three_of_kind(hand):
...     try:
...         hand = prettify(hand)
...     except:
...         pass  # Already pretty
...     hand = cardsort(hand)
...     hand = re.sub(r'[^AKQJT98765432]', '', hand)
...     pat = r'(.)\1{2}'  # No begin/end markers
...     match = re.search(pat, hand)
...     return match.group(1) if match else False
...
...
>>> is_three_of_kind('AS 6H QH 6S 2D')
False
>>> is_three_of_kind('AS 6H QH 6S 6D')
'6'
~~~

Identifying a pair is basically identical.  We simply need to settle for
one copy of a card number rather two copies.

{:language="python"}
~~~
def is_pair(hand):
    try:
        hand = prettify(hand)
    except:
        pass  # Already pretty
    hand = cardsort(hand)
    hand = re.sub(r'[^AKQJT98765432]', '', hand)
    pat = r'(.)\1'  # No begin/end markers
    match = re.search(pat, hand)
    return match.group(1) if match else False
~~~

Matching two pairs is actually a little trickier.  Remember that for a
full house we matched either two of one number followed by three of the
other, or matched the reverse three then two.  However, the "gap" of a
unmatched number can occur in more different ways in this case.
Thinking about it, two pairs might look like any of the following (even
assuming sorting):

* `X X _ Y Y`
* `_ X X Y Y`
* `X X Y Y _`

The unmatched number cannot occur in sorted positions 2 or 4 since that
leaves only three cards to the other side of the unmatched number (and
we have stipulated sorted order of the hand).

As elsewhere, we return the helpful "truthy" value that might be used
later in comparing hands of the same type (namely, the two numbers of
the pairs, in sorted order).

{:language="python"}
~~~
>>> def is_two_pairs(hand):
...     try:
...         hand = prettify(hand)
...     except:
...         pass  # Already pretty
...     hand = cardsort(hand)
...     hand = re.sub(r'[^[AKQJT98765432]', '', hand)
...     # Three ways to match with unmatched number
...     pat = (r"(.)\1.(.)\2|"
...            r".(.)\3(.)\4|"
...            r"(.)\5(.)\6.")
...     match = re.search(pat, hand)
...     if not match:
...         return False
...     else:
...         return ''.join(n for n in match.groups() if n)
...
>>> is_two_pairs('AH 6S 3H AD 6C')
'A6'
>>> is_two_pairs('AH 6S 3H AD 3C')
'A3'
>>> is_two_pairs('AH 6S 3H KD 3C')
False
~~~

The remainder of your poker game program is left for a further exercise.
The rest of what you'd need to do won't have much to do with regular
expressions, simply usual program flow and data structures. 

	</markdown>
</recipe>
