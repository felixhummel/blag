#!/usr/bin/python
# encoding: utf-8
"""
What is this script's parent directory?

There are several ways to determine the directory. This not about the current working directory - os.getcwd().
"""
import sys, os, string

def with_sys_argv():
	return os.path.dirname(sys.argv[0])

def walkingPATH():
	for d in (string.split(os.getenv('PATH'), os.pathsep)):
		if os.path.exists(d + os.sep + os.path.basename(sys.argv[0])):
			return d

def sys_path0():
	return sys.path[0]

def withDirName():
	os.path.dirname(__file__)

def printStuff(function):
	print("--- %s"%function.__name__)
	print(function())

if __name__ == '__main__':
    functions = [with_sys_argv, walkingPATH, sys_path0, withDirName]
    for f in functions:
        printStuff(f)
