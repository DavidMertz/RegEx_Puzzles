import re

messages = {
    "valid_1a": "_/^^^\_/^|___|^\____|^^\__/",
    "valid_1b": "LuHHHdLuHFLLLFHdLLLLFHHdLLu",
    "valid_2a": "____/^^^^^^",
    "valid_2b": "LLLLuHHHHHH",
    "invalid_1a": "_^/^^^/__\_",
    "invalid_1b": "LHuHHHuLLdL",
    "invalid_2a": "|\/|",
    "invalid_2b": "FduF",
    "invalid_3a": "__/^^|__X__/",
    "invalid_3b": "LLuHHFLLXLLu",
    "invalid_4a": "|_^|__",
    "invalid_4b": "FLHFLL",
}

patA =  (r'^(((?=__|_/|_\||\^\^|\^\\|\^\||/\^|\\_|\|\^|\|_)'
         r'|(?=.$))[_\^/\\\|])+$')
patB =  r'^(((?=LL|Lu|LF|HH|Hd|HF|uH|dL|FH|FL)|(?=.$))[LHudF])+$'

for k, v in messages.items():
    if k.endswith('b'):
        match = re.search(patB, v)
    else:
        match = re.search(patA, v)
    print(k, v, 
          "MATCH" if (match and match.group() == v) else "FAIL") 
