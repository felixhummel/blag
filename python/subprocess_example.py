#!/usr/bin/python
"""
Example about process communication
"""
import os
import sys

from subprocess import call, Popen, PIPE

def get_return_code():
    cmd = ['echo', '""']
    retcode = call(cmd)
    print
    print 'get_return_code'
    print '==============='
    print retcode

def get_stdout():
    cmd = ['ls', '.']
    p = Popen(cmd, stdout=PIPE)
    res = p.communicate()[0]
    print
    print 'get_stdout'
    print '=========='
    print res

def run_in_shell():
    cmd = "echo 'Shell makes life easy, but is not too powerful.' | cat -"
    p = Popen(cmd, shell=True, stdout=PIPE)
    res = p.communicate()[0]
    print
    print 'run_in_shell'
    print '============'
    print res

def get_stderr():
    cmd = ['cat', 'some_filename_that_cannot_be_found']
    p = Popen(cmd, stderr=PIPE)
    res = p.communicate()[1]
    print
    print 'get_stderr'
    print '=========='
    print res

def get_everything():
    cmd = "echo 'first part works' | cat - but_this_file_cannot_be_found"
    p = Popen(cmd, shell=True, stdout=PIPE, stderr=PIPE)
    out, err = p.communicate()
    retcode = p.returncode
    print
    print 'get_stdout_and_stderr'
    print '============'
    print 'STDOUT: %s'%out
    print 'STDERR: %s'%err
    print 'returncode: %s'%retcode

if __name__ == '__main__':
    get_return_code()
    get_stdout()
    run_in_shell()
    get_stderr()
    get_everything()
