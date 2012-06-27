#!/usr/bin/python
"""
Example about basic process manipulation
"""
import os
import sys

def read_stdin():
    res = 'Your STDIN contains: '
    for line in sys.stdin:
        res = res + line
    print res

def write_to_stdout():
    print "Writing to STDOUT is easy."
    sys.stdout.write('One way or another...\n')

def write_to_stderr():
    sys.stderr.write('Writing to STDERR is easy too.\n')

def return_code():
    sys.exit(8)

if __name__ == '__main__':
    read_stdin()
    write_to_stdout()
    write_to_stderr()
    return_code()
