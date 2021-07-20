<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">

<recipe id="rcp.fasta">
	<title>
		The Human Genome
	</title>
	
	<markdown>

Genomics commonly uses a format called FASTA to represent genetic
sequences.  This puzzle uses a subset of the overall format.  Let's
provide just a few quick tips.  The letters 'A', 'C', 'G', 'T' represent
nucleotide bases in DNA.  FASTA may also contains the symbol 'N' for
"unknown nucleotide" and '-' for "gap of indeterminate length."

As well, in biological organisms, spans of DNA are terminated by
"telomeres" which are special sequences which indicate that the read
mechanism should stop transcription and form a protein.  Telomeres are
often repeated as much as thousands of times at the ends of sequences.
In a gross simplification for this puzzle, let's suppose that three or
more repetitions of a telomere indicate the end of a sequence for a
protein. In vertebrates, the telomere used is 'TTAGGG'.

In this puzzle, we will ignore the marking of the start of a
protein-encoding region, and just assume that all of our strings begin a
potential protein encoding.

You would like to create a regular expression that represents a
"specific protein encoding" from a (simplified) FASTA fragment.  In
particular, we need to know exactly which nucleotides are present, and
gaps or unknown nucleotides will prevent a match.  Moreover, even the
telomere repetitions at the end are not permitted (for this puzzle) to
have gaps or unknowns.

For this puzzle, assume that all the FASTA symbols are on a single line.
Normally as published they have a fixed width less than 80 characters;
but newlines are simply ignored.  Examples of matches and failures:

{:language="python"}
~~~
>>> from textwrap import wrap
>>> print('\n'.join(wrap(valid, 60)))
CATGGCTTTGGGACAACTCGGGGCTGCATGGACGGTGAATAAAATCTTTCCCGGTTGCTG
CCCTGAATAATCAAGGTCACAGACCAGTTAGAATGGTTTAGTGTGGAAAGCGGGAAACGA
AAAGCCTCTCTGAATCCTGCGCACCGAGATTCTCCCAAGGCAAGGCGAGGGGCTGTATTG
CAGGGTTCAACTGCAGCGTCGCAACTCAAATGCAGCATTCCTAATGCACACATGACACCC
AAAATATAACAGACATATTACTCATGGAGGGTGAGGGTGAGGGTGAGGGTTAGGGTTAGG
GTTTAGGGTTAGGGTTAGGGGTTAGGGGTTAGGGTTAGGGTTAGGGTTAGGG

>>> coding = re.search(pat, valid).group()
>>> print('\n'.join(wrap(coding, 60)))
CATGGCTTTGGGACAACTCGGGGCTGCATGGACGGTGAATAAAATCTTTCCCGGTTGCTG
CCCTGAATAATCAAGGTCACAGACCAGTTAGAATGGTTTAGTGTGGAAAGCGGGAAACGA
AAAGCCTCTCTGAATCCTGCGCACCGAGATTCTCCCAAGGCAAGGCGAGGGGCTGTATTG
CAGGGTTCAACTGCAGCGTCGCAACTCAAATGCAGCATTCCTAATGCACACATGACACCC
AAAATATAACAGACATATTACTCATGGAGGGTGAGGGTGAGGGTGAGGG
~~~

The telomeres at the end are ignored.  In contrast, it we use a
non-specifi symbol, we will not match.

{:language="python"}
~~~
>>> print('\n'.join(wrap(bad_telomere, 60)))
CATGGCTTTGGGACAACTCGGGGCTGCATGGACGGTGAATAAAATCTTTCCCGGTTGCTG
CCCTGAATAATCAAGGTCACAGACCAGTTAGAATGGTTTAGTGTGGAAAGCGGGAAACGA
AAAGCCTCTCTGAATCCTGCGCACCGAGATTCTCCCAAGGCAAGGCGAGGGGCTGTATTG
CAGGGTTCAACTGCAGCGTCGCAACTCAAATGCAGCATTCCTAATGCACACATGACACCC
AAAATATAACAGACATATTACTCATGGAGGGTGAGGGTGAGGGTGAGGGTTAGGGTTAGG
GTTTAGGGTTAGGGTTAGGGGTTAGGGGTTAGGGTTAGGGTTAGGGTTTAGG
>>> re.search(pat, bad_telomere) or "No Match"
'No Match'

>>> print('\n'.join(wrap(unknown_nucleotide, 60)))
CATGGCTTTGGGACAACTCGGGGCTGCATGGACGGTGAATAAAATCTTTCCCGGTTGCTG
CCCTGAATAATCAAGGTCACAGACCAGTTAGAATGGTTTAGTGTGGAAAGCGGGAAACGA
AAAGCCTCNCTGAATCCTGCGCACCGAGATTCTCCCAAGGCAAGGCGAGGGGCTGTATTG
CAGGGTTCAACTGCAGCGTCGCAACTCAAATGCAGCATTCCTAATGCACACATGACACCC
AAAATATAACAGACATATTACTCATGGAGGGTGAGGGTGAGGGTGAGGGTTAGGGTTAGG
GTTTAGGGTTAGGGTTAGGGGTTAGGGGTTAGGGTTAGGGTTAGGGTTAGGG
>>> re.search(pat, unknown_nucleotide) or "No Match"
'No Match'
~~~

In the one mismatch, the first several, but not all trailing bases are
valid telomeres.  In the second mismatch, the 'N' symbol is used.  Both
of these are valid FASTA encoding, but not the sequences specified for
puzzle.

[aside important Before You Turn the Page]
<p>
    Remember the central dogma of molecular biology.
</p>
[/aside]

<pagebreak />

There are a few key aspect to keep in mind in designing your regular
expression.  You want to make sure that your pattern begins at the start
of the candidate sequence.  Otherwise, you could easily match only a
valid tail of it.

From there, any sequence of 'C', 'A', 'T', and 'G' symbols is permitted.
However, you definitely want to be non-greedy in matching them since no
telomeres should be included.  The telomere may be repeated any number
of times, but at least three.  Moreover, repeated telomeres must
continue until the end of the candidate sequence, so we must match `$`
*inside* the lookahead pattern.

{:language="python"}
~~~
pat = r'^([CATG]+?)(?=(TTAGGG){3,}$)'
~~~

	</markdown>
</recipe>
