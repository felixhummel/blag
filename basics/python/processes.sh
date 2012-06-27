#!/bin/bash

# environment variables
# =====================

var="hello world"


# STDIN, STDOUT
# =============

# echo takes a string and puts it on STDOUT
echo $var

# we can redirect STDIN to a file
echo $var 1> /tmp/some_file

# cat takes a file as first argument and writes it to STDOUT
cat /tmp/some_file

# to be brutally honest cat concatenates files and writes them to STDOUT
echo "part 2" > /tmp/some_other_file
cat /tmp/some_file /tmp/some_other_file

# cat can also take STDIN and write it to STDOUT
echo $var | cat

# to concatenate STDIN with a file:
echo $var | cat - /tmp/some_other_file


# STDERR
# ======

# let's redirect STDIN to STDERR
echo $var 1>&2

# we can read it, but if we redirect STDOUT to a file it remains empty
write_stuff_to_STDERR() {  # this is a function -- see ``man bash``
    echo "stuff" 1>&2
}
write_stuff_to_STDERR 1> /tmp/where_is_my_message
cat /tmp/where_is_my_message

# so to get to the message we redirect STDERR to a file
write_stuff_to_STDERR 2> /tmp/there_it_is
cat /tmp/there_it_is

# we can also redirect everything to a file
# that's basically everything you can read on your console
write_stuff() {
    echo "INFO" 2>&1  # to STDOUT
    echo "ERROR" 1>&2  # to STDERR
}
write_stuff > /tmp/everything
write_stuff 1> /tmp/just_stdout
write_stuff 2> /tmp/just_stderr
cat /tmp/everything
cat /tmp/just_stdout
cat /tmp/just_stderr

# if the output of a process is irrelevant
# we redirect to /dev/null (the bottomless bucket)
write_stuff 1> /dev/null  # don't care about your info
write_stuff 2> /dev/null  # don't care about your errors


# Return Codes
# ============

# on success processes return a 0
echo ''  # this will definitely succeed
echo $?

# else they return something > 0
# good tools document this in their man pages
this_command_will_probably_not_be_found 2> /dev/null
echo $?

# return codes are useful for chaining processes
this_command_will_probably_not_be_found 2> /dev/null && echo 'success'
echo 'I work!' && echo 'success'
