import re
from time import time

"""
| U+25A0     | Black Square    | ■
| U+25AA     | Black Sm Square | ▪
| U+25CB     | White Circle    | ○
| U+25C9     | Fisheye         | ◉
| U+25A1     | White Square    | □
| U+25AB     | White Sm Square | ▫
| U+25B2     | Black Up Triang | ▲
| U+25CF     | Black Circle    | ●
| U+2404     | End Transmit    | ␄
"""

def shapify(s):
    s = s.replace('a', '■')
    s = s.replace('b', '▲')
    s = s.replace('c', '○')
    s = s.replace('d', '◉')
    s = s.replace('e', '□')
    s = s.replace('f', '▫')
    s = s.replace('g', '▪')
    s = s.replace('h', '●')
    s = s.replace('@', '␄')
    return s

#_pat = r"(^(([abcde]+) ?([feghb]+) ?)+)@"
_pat = r"(^(?=^[abcdefgh ]+@)(([abcde]+) ?([feghb]+) ?)+)@"
pat = shapify(_pat)

print("Regex:", pat, '\n')

messages = {"Structure 1/2/1/2":  "abdfagf@",
            "Structure 1 2 1 2":  "abd f a gf@",
            "Missing terminator": "abdfagf",
            "Structure 1 1 2 1":  "bbb aaa fff ccc@"}
            
for desc, mess in messages.items():
    mess = shapify(mess) 
    status = "Valid" if re.search(pat, mess) else "Invalid"
    print(f"{desc:<18s} | Message '{mess}' is {status}")

print()

long = {"Quick match":     "abcdefeghddfgghheebbccdaaabbeedb@",
        "Quick failure":   "abcdabfghhaaabbdddaeeeffghhhfaaa@",
        "Failure":         "beebbeebbbeeeeeeeebbebebebX",
        "Slow failure":    "beebbbeebbbeeeeeeeebbebebebX",
        "Exponential":     "bbbbbbeebbbeeeeeeeebbebebebbX",
        "One more symbol": "bbbbebeebbebeeeeeeeebbebebebb",
        "Ambiguous quick": "bbbbebeebbebeeeeeeeebbebebebb@",
       }

for desc, mess in long.items():
    mess = shapify(mess)
    start = time()
    status = "Valid" if re.search(pat, mess) else "Invalid"
    print(f"{desc:<15s} | '{mess}' is {status}")
    print(" "*15, f"|  Checked in {time()-start:0.2f} seconds")


