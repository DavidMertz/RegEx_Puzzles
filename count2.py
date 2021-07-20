import re

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

def let_count(c, s):
    # Remove everything that isn't the target character
    s = re.sub(fr'[^{c}]', '', s)
    # Convert the target to the underscore sentinel
    s = re.sub(fr'{c}', '_', s)
    while True:
        # Ten underscores become an @ sign, for each leading digit
        s = re.sub(r'__________', '@', s)
        for k, v in counter.items():
            # Replace trailing underscores with a digit
            new = re.sub(k, v, s)
            if new != s:
                s = new
                break
        # If we've reduced string to only digits, we are done
        if re.match(r'^[0-9]*$', s):
            return s
        s = re.sub('@', '_', s)



mRNA = '''
GGGAAATAAGAGAGAAAAGAAGAGTAAGAAGAAATATAAGACCCCGGCGCCGCCACCATGTTCGTGTTC
CTGGTGCTGCTGCCCCTGGTGAGCAGCCAGTGCGTGAACCTGACCACCCGGACCCAGCTGCCACCAGCC
TACACCAACAGCTTCACCCGGGGCGTCTACTACCCCGACAAGGTGTTCCGGAGCAGCGTCCTGCACAGC
ACCCAGGACCTGTTCCTGCCCTTCTTCAGCAACGTGACCTGGTTCCACGCCATCCACGTGAGCGGCACC
AACGGCACCAAGCGGTTCGACAACCCCGTGCTGCCCTTCAACGACGGCGTGTACTTCGCCAGCACCGAG
AAGAGCAACATCATCCGGGGCTGGATCTTCGGCACCACCCTGGACAGCAAGACCCAGAGCCTGCTGATC
GTGAATAACGCCACCAACGTGGTGATCAAGGTGTGCGAGTT
'''
print(let_count('G', mRNA),
      let_count('C', mRNA),
      let_count('T', mRNA),
      let_count('A', mRNA))

