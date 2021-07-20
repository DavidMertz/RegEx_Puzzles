<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.count2">
	<title>
		Reimplementing str.count() (With More Restrictions)
	</title>
	<markdown>
	
In the last puzzle, we reimplemented `str.count()` using regular
expressions.  However, the solutions I presented—and most likely the
solution you arrvied at on your own—ultimately came down to utilizing
`len()` on something derived from the original string (to count the
number of matches found).

For this puzzle, pretend that Python also does not have the `len()`
function; and also do not implement your own equivalent by, for example,
looping through an iterable and incrementing a counter when a substring
is found.  One way to express this is that your function should use no
numeric variables or values.

In fact, what we want as the result is a string that represents the
number of the count, not an actual number.  To simplify the problem,
however, we can assume that we are only counting single characters,
not substrings in general. In fact, to simplify even more, let's just
assume the input strings are exclusively nucleotide symbols like in the
example below (generalizing this isn't too difficult).  A solution will
look something like this:

{:language="python"}
~~~
>>> def let_count(char: str, string: str) -> str:
...     # maybe a while loop, some calls to re.something()
        ...
~~~

For example, using it to count nucleotides:

{:language="python"}
~~~
>>> mRNA = '''
GGGAAATAAGAGAGAAAAGAAGAGTAAGAAGAAATATAAGACCCCGGCGCCGCCACCATGTTCGTGTTC
CTGGTGCTGCTGCCCCTGGTGAGCAGCCAGTGCGTGAACCTGACCACCCGGACCCAGCTGCCACCAGCC
TACACCAACAGCTTCACCCGGGGCGTCTACTACCCCGACAAGGTGTTCCGGAGCAGCGTCCTGCACAGC
ACCCAGGACCTGTTCCTGCCCTTCTTCAGCAACGTGACCTGGTTCCACGCCATCCACGTGAGCGGCACC
AACGGCACCAAGCGGTTCGACAACCCCGTGCTGCCCTTCAACGACGGCGTGTACTTCGCCAGCACCGAG
AAGAGCAACATCATCCGGGGCTGGATCTTCGGCACCACCCTGGACAGCAAGACCCAGAGCCTGCTGATC
GTGAATAACGCCACCAACGTGGTGATCAAGGTGTGCGAGTT
'''
>>> let_count('G', mRNA)
'120'
>>> let_count('C', mRNA)
'152'
>>> let_count('T', mRNA)
'74'
>>> let_count('A', mRNA)
'109'
~~~


[aside important Before You Turn the Page]
<p>
    Try to write a Python function with the restrictions given.
</p>
[/aside]

<pagebreak />

This one turns out to be somewhat difficult, but also to be
<emph>possible</emph>, which is itself sort of amazing.  No numbers
whatsoever are involved in the solution shown.  No counters, no integer
variables, no Python functions returning numbers. 

We also do not need to use any Python string methods, although it is
fair to note that some of what is performed via regular expressions
might be more simple to express as string methods.  The function can
perform strictly and only regular expressions operations... along with a
little bit of Python looping (but never over numbers).

We use two sentinels in alternation for the loop, indicating either the number
of items at a certain power of ten, or the number at the next higher power.  A
dictionary can map zero to nine repetions of a sentinel to the corresponding
numeral, but leave the rest of string unchanged.

{:language="python"}
~~~
# Group 1: zero or more leading @'s
# Group 2: some specific number of _'s
# Group 3: anything until end; digits expected
counter = {
    r'(^@*)(_________)(.*$)': r'\g<1>9\g<3>',
    r'(^@*)(________)(.*$)': r'\g<1>8\g<3>',
    r'(^@*)(_______)(.*$)': r'\g<1>7\g<3>',
    r'(^@*)(______)(.*$)': r'\g<1>6\g<3>',
    r'(^@*)(_____)(.*$)': r'\g<1>5\g<3>',
    r'(^@*)(____)(.*$)': r'\g<1>4\g<3>',
    r'(^@*)(___)(.*$)': r'\g<1>3\g<3>',
    r'(^@*)(__)(.*$)': r'\g<1>2\g<3>',
    r'(^@*)(_)(.*$)': r'\g<1>1\g<3>',
    r'(^@*)(_*)(.*$)': r'\g<1>0\g<3>'
}
~~~

A first step is to map the target character to a sentinel.  It would be
easy to extend the main function to map a generic regular expression
pattern to that same sentinel.

The two sentinels underscore and at-sign are used here, but some rare
unicode codepoint in the astral plane—or even a private-use
codepoint—could just as well be used instead if collision with the
initial string were a concern.

{:language="python"}
~~~
def let_count(c, s):
    # The first lines only convert single character to sentinel, 
    # but could be generalized to any regex pattern 
    # Remove everything that isn't the target character
    s = re.sub(fr'[^{c}]', '', s)
    # Convert the target to the underscore sentinel
    s = re.sub(fr'{c}', '_', s)

    # Loop indefinitely since do not know how many digits needed
    while True:
        # Ten underscores become an @ sign
        s = re.sub(r'__________', '@', s)
        for k, v in counter.items():
            # Replace trailing underscores with a digit
            new = re.sub(k, v, s)
            # Some pattern matched, so exit the loop
            if new != s:
                s = new
                break
        # If we have only digits, we are done
        if re.match(r'^[0-9]*$', s):
            return s
        # Convert from "unprocessed" to "todo" sentinels
        s = re.sub('@', '_', s)
~~~

</markdown>
</recipe>
