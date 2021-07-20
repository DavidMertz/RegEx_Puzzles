<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.poker">
	<title>
		Playing Poker (Part 1)
	</title>
	
	<markdown>

In earlier puzzles, we had fun playing dominoes.  For the next few
puzzles, let's play poker.  In particular, let's says that a player has
five cards, and we wish to compare two hands to each other.  We will do
this over several puzzles, by building up small functions to answer
various questions.  

As much as possible, you should use regular expressions to express the
logic; however, a few of the questions will require a little bit of
non-regex code as well.  First, let's remind ourselves of the ranking of
different hands of 5 cards.  Our encoding will simplify card
representations a little bit.  Specifically, the card that might be
called, e.g. `10♥` will be called `T♥` so that every card is a two
symbol combination.

* Straight flush, e.g. `J♣ T♣ 9♣ 8♣ 7♣`
* Four of a kind, e.g. `A♥ 3♠ 3♥ 3♦ 3♣`
* Full house, e.g. `K♠ K♣ 6♥ 6♦ 6♣`
* Flush, e.g. `J♦ 9♦ 6♦ 5♦ `2♦`
* Straight, e.g. `9♦ 8♣ 7♣ 6♥ 5♣`
* Three of a kind, e.g. `Q♣ 8♠ 8♦ 8♣ 3♥`
* Two pairs, e.g. `J♠ J♣ 9♥ 8♥ 8♦`
* One Pair, e.g. `A♥ K♦ 4♠ 4♥ 3♠`
* High card, e.g. `K♠ 9♥ 8♠ 4♥ 2♣`

Within the same kind of hand, other rules come into play.  Let's ignore
those for now.  We'd like two support functions to start.  First, you
should write a function `prettify(hand)` that takes an easier to type
representation of suits as 'S', 'H', 'D', 'C', and turns the hands into
their Unicode symbols.

The second and more difficult function for this puzzle asks you to make
sure all the cards are sorted in descending order (as in the examples),
where aces are always considered high, and the suits are ordered spades,
hearts, diamonds, clubs.

This second function, `cardsort(hand)` uses more Python than regular
expressions per se, so just read the solution if you are less
comfortable with Python itself.

[aside important Before You Turn the Page]
<p>
    Functions are a big help in larger programs.
</p>
[/aside]
<pagebreak />

The truth is, we do not genuinely *need* regular expressions for either of
these support functions.  But we do have the opportunity to use them.
First let's transform any ASCII version of a hand into the Unicode
version. Along the way, we make sure the hand consists of five valid ASCII
cards.

{:language="python"}
~~~
def prettify(hand):
    assert re.search(r'^([2-9TJQKA][SHDC] ?){5}$', hand)
    symbols = {'S': '\u2660', 'H': '\u2665',
               'D': '\u2666', 'C': '\u2663'}
    for let, suit in symbols.items():
        hand = re.sub(let, suit, hand)
    return hand
~~~

Sorting uses mostly plain Python techniques.  In particular, we can rely
on the fact that Python's sort is *stable*.  This means the order will not
change between equivalent elements.  Therefore, sorting first by suit,
then by number will be guaranteed to have the right overall effect.

{:language="python"}
~~~
def cardsort(hand):
    def by_num(card):
        map = {'T':'A', 'J':'B', 'Q':'C',
               'K':'D', 'A':'E'}
        num = card[0]
        return num if num not in 'AKQJT' else map[num]

    def by_suit(card):
        map = {'\u2663': 1, '\u2666': 2,
               '\u2665': 3, '\u2660': 4}
        return map[card[1]]

    hand = re.split(' ', hand)
    hand.sort(key=by_suit, reverse=True)
    hand.sort(key=by_num, reverse=True)
    return ' '.join(hand)
~~~

Combining these:

{:language="python"}
~~~
>>> cardsort(prettify('8C AS 4H KS 2C'))
'A♠ K♠ 8♣ 4♥ 2♣'
~~~

More regular expressions in the next puzzles which continue this theme.

	</markdown>
</recipe>
