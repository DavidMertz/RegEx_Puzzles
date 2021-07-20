<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.poker2">
	<title>
		Playing Poker (Part 2)
	</title>
	
	<markdown>

In the last puzzle, you converted "poker hands" from ASCII to Unicode
suit symbols, and you also made sure that hands are listed in
canonical desceneding card order.

For this puzzle, you want to start using regular expressions to figure
out whether hands belong to various kinds.  Here's an obvious trick we
can use as a shortcut:

{:language="python"}
~~~
def is_straight_flush(hand):
    return is_straight(hand) and is_flush(hand)
~~~

For this puzzle, write the functions `is_flush(hand)` and
`is_straight(hand)`, continuing with the assumption that hands are
represented in the same manner as the last puzzle (including the cards
being in descending order).  Feel free to use the `prettify()`
function you wrote if it makes entering test cases easier.

[aside important Before You Turn the Page]
<p>
    Functions are a big help in larger programs.
</p>
[/aside]
<pagebreak />

Identifying a flush is somewhat easier.  Moreover, if we are clever, we
can add two features to the function not specifically required in the
puzzle.  We can make it work identically with the ASCII codes like 'S'
for spaces and 'H' for hearts simultaneously with the Unicode special
symbols.

But while we are creating the function, we can also return extra
"truthy" information in the return value.  Namely, if it *is* a flush,
let's return the suit also.

{:language="python"}
~~~
>>> def is_flush(hand):
...     match = re.search(r'^.(.)(.*\1){4}$', hand)
...     return match.group(1) if match else False

>>> is_flush('J♣ T♣ 9♣ 8♣ 7♣')
'♣'
>>> is_flush('J♦ 9♦ 6♦ 5♦ 2♦')
'♦'
>>> is_flush('J♦ 9♥ 6♦ 5♦ 2♦')
False
>>> is_flush('JD 9H 6D 5D 2D')
False
>>> is_flush('JD 9D 6D 5D 2D')
'D'
~~~

For checking for straights, let's add a similar bit of extra information
in the return value.  Obviously, if the hand is not a straight, we
should return False.  But if it is one, we can return the high card
number for later use.  Those are all "truthy" values (like all strings).

{:language="python"}
~~~
>>> def is_straight(hand):
...     pat = r'[ SHDC\u2660\u2665\u2666\u2663]'
...     h = re.sub(pat, '', hand)
...     return h[0] if re.search(h, 'AKQJT98765432') else False
~~~

As with the first function, we might as well be friendly in accepting
the ASCII version of suits, even though they could always be
`prettify()`d if necessary.  The pattern looks for everything that is a
suit character or a space, and strips it out to create a simplified
"hand".

With the simplified hand of just "numbers", we know that any straight
must be a substring of the run of all numbers.  We do not check again
that the length is 5, trusting that other functions have validated this.
We could easily add that if we wanted, of course.

At this point, you might consider a richer implementation of
`is_straight_flush()`.  Perhaps this:

{:language="python"}
~~~
>>> def is_straight_flush(hand):
...     s = is_straight(hand)
...     f = is_flush(hand)
...     return s+f if s and f else False

>>> is_straight_flush('JD TD 9D 8D 7D')
'JD'
>>> is_straight_flush('JD TD 9H 8D 7D')
False
~~~

	</markdown>
</recipe>
