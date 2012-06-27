" ft-plugin for reStructured Text.
" Create and replace headings for sphinx files
"
" Last Change:	2009-03-15
" Maintainer:	Felix Hummel <vim@felixhummel.de>
" This work is licensed under the Creative Commons Attribution-Share Alike 3.0 Germany License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/de/ or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.
" Attribute work to name: Felix Hummel
" Attribute work to URL: http://felixhummel.de

map <F1> :python sphinx_heading(1)<CR>
map <F2> :python sphinx_heading(2)<CR>
map <F3> :python sphinx_heading(3)<CR>
map <F4> :python sphinx_heading(4)<CR>
map <F5> :python sphinx_heading(5)<CR>
map <F6> :python sphinx_heading(6)<CR>

python << EOF
import vim
levels = {1: '#',
          2: '*',
          3: '=',
          4: '-',
          5: '^',
          6: '"'}

reverse_levels = {}
for num,char in levels.iteritems():
    reverse_levels[char] = num

class LineInfo(object):
    """just a simple container to get heading level"""
    def __init__(self):
        buf = vim.current.buffer
        lineno = vim.current.window.cursor[0]
        index = lineno - 1  # cursor starts at 1, python lists start at 0
        current = buf[index]
        try:
            previous = buf[index-1]
        except IndexError:
            previous = None
        try:
            next = buf[index+1]
        except IndexError:
            next = None

        # check for existing heading
        has_all_the_same_char = lambda line: all([c == line[0] for c in line])
        if not next\
            or len(next) < 1\
            or len(current) < len(next):
            # next line is empty or shorter than current line
            self.level = None
        elif has_all_the_same_char(next):
            # line is underlined
            if previous\
                and has_all_the_same_char(previous)\
                and next == previous:  # XXX: we could allow differently long lines here, but why?
                # we have an over- and underlined heading here
                self.level = reverse_levels[next[0]]
            else:
                # it's not overlined
                self.level = reverse_levels[next[0]]
        else:
            self.level = None

def sphinx_heading(level):
    buf = vim.current.buffer
    i,j = vim.current.window.cursor
    i = i - 1
    x = LineInfo()
    # remove old heading
    if x.level in [1,2]:
        # delete underline first
        # if we deleted overline first, index would change
        buf[i+1:i+2] = []  
        buf[i-1:i] = []
    elif x.level in [3,4,5,6]:
        buf[i+1:i+2] = []
    # create heading
    i = vim.current.window.cursor[0] - 1  # re-get the current index
    heading_line = levels[level] * len(buf[i])
    if level in [1,2]:
        buf[i:i+1] = [heading_line, buf[i], heading_line]
        vim.current.window.cursor = (i + 2, j)
    elif level in [3,4,5,6]:
        buf[i:i+1] = [buf[i], heading_line]
EOF
