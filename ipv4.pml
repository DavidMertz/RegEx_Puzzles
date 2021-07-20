<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.ipv4">
	<title>
		Testing an IPv4 Address
	</title>
	<markdown>
	
"Internet protocol version 4" addresses are very prevalent in almost
everythingwe do with computers.  "Under the hood" (so to speak), an IPv4
address is just a 32-bit unsigned integer.  However, it is universal to
write them in a human-memorable way as so-called dotted-quads.  In that
format, each byte of the address is represented as a decimal number
between 0 and 255 (the range of an integer byte), and the four bytes are
separated by periods.

Some particular address ranges have special or reserved meanings, but
they remain IPv4 addresses, and should be matched for this puzzle.  Can
you write a regular expression to test if a string is a valid IPv4
address?  Some examples:

* Valid: 192.168.20.1
* Invalid: 292.168.10.1
* Invalid: 5.138.0.21.23
* Invalid: 192.AA.20.1

The first of these is a good address; it happens to be a range reserved
for internal addresses with an organization (usually one particular
router), and hence exists in many local networks.  The others fail for
various reasons. The first invalid addess contains numbers outside the
the permitted integer range in one quad.  The second invalid address has
5 dotted elements rather than 4.  The third invalid address contains
characters other than decimal digits in one of the quads.

[aside important Before You Turn the Page]
<p>
    Always think about whether regexen are powerful enough for a problem.
</p>
[/aside]


<pagebreak />

It would be very easy to match naive *dotted quads* that simply
consisted of four numbers with up to three digits, separated by dots.
You might express that as:

{:language="python"}
~~~
pat = r'^(\d{1-3}){3}\.\d{1-3}$'
~~~

This code will indeed match every IPv4 address. But it will also match
many things that are invalid, such as `992.0.100.13`.  Matching
three-digit numbers that  begin with 3-9 are definitely wrong.  We can
try to fix that oversight by allowing only acceptable hundreds digits:

{:language="python"}
~~~
pat = r'^([12]?\d{1-2}){3}\.[12]?\d{1-2}$'
~~~

This has far fewer false positives.  It says "maybe start with a '1' or
a '2', then follow that by one or two more digits" (repeating that for
dotted quads).  So far, so good: `992.0.100.13` is ruled out.  But we
still might accept `271.10.199.3` which has an invalid first quad.

To fix the pattern we have to *bite the bullet* and list all and only
quads we can allow.  That is, if a quad starts with a '25' and has
three digits, the next digit can only be 0-5.  And if it starts with
a '2' it definitely cannot have a digit more than 5 next.

{:language="python"}
~~~
pat = (
    '^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}'
      '(25[0-5]|2[0-4]\d|[01]?\d\d?)$'
)
~~~

The pattern is a bit of a mouthful, but when we see how it is built up,
the pattern becomes quite  clear and elegant.  All the stuff after the
number quantifier, `{3}` is just a repetition of the earlier subpattern.
This is simply because we match three numbers that are followed by a
period, but the final number must not be followed by anything.

The main subpattern is just an alternation of options.  Maybe the quad
looks like `25[0-5]`.  Or maybe it looks like `2[0-4]\d`.  These
describe all the valid numbers in the 200+ range.  For the rest, we get
a little clever.

If the quad isn't three digits beginning with a '2', it can either be
three-digits beginning with 1 or 0.  Conventionally, leading zeros or
dropped, but that is not required.  However, two-digit or one-digit
numbers are also common; any such two- or one-digit numbers are
permitted.  So we make the initial `[01]` optional, and also make the
final digit optional with `\d?`.  This gives all and only the remaining
permissible quads.

	</markdown>
</recipe>
