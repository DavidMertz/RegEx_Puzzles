#!/usr/bin/env python
from glob import glob

for line in open('book.md'):
    if line.startswith('## file='):
        puzzle_name = line.split('"')[1] + '.pml'
        puzzle = open(puzzle_name).read()
        title = puzzle.split('<title>')[1].split('</title>')[0].strip()
        print(f'## {title}')
        body = puzzle.split('<markdown>')[1].split('</markdown>')[0]
        body = body.replace('{:language="python"}', '')
        body = body.replace('~~~', '```')
        aside = '[aside important Before You Turn the Page]'
        body = body.replace(aside, '')
        body = body.replace('[/aside]', '')
        body = body.replace('<pagebreak />', '\\newpage')
        body = body.replace('<p>', '<hr/><p><b>')
        body = body.replace('</p>', '</b></p><hr/>')
        print(body)
    else:
        print(line, end='')
