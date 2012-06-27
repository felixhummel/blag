*******************
String Manipulation
*******************
.. highlight:: bash

Split String
============
::

    s='hello:world:!'
    IFS=":"
    array=($s)

    echo ${array[1]}  # world

    for x in ${array[*]}; do
        echo $x
    done

Sources:

- http://forum.fachinformatiker.de/linux-unix/102871-bash-script-split-string-array-seperator.html
- http://www.linuxjournal.com/content/bash-arrays

