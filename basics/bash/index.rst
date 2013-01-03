****
Bash
****
.. toctree::
    :glob:
    
    *

.. highlight:: bash

``man bash`` - Read it! It's worth your time.

.bashrc
=======
``$HOME/.bashrc`` is executed when Bash starts. Add stuff you want to keep for every session (like Completion_ or Silence_). Don't want to restart Bash? Then `source <Sourcing>`_ it with run ``source ~/.bashrc``.

Sourcing
========
*man* says "Read and execute commands from filename in the current shell environment and return the exit status of the last command executed from filename.". The following lines are equivalent::

    source some_file
    . some_file

Completion
==========
These line activate Bash completion::

    if [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi

You may want to :ref:`install <wajig>` *bash-completion* and *python-optcomplete*.

Silence
=======
Disable beep::

    setterm -blength 0

You also can make music with beeps. See :download:`simpsons.sh`.

Bash and Python
===============
... go well together::

    python << EOF
    print 'hello world'
    EOF

See also :doc:`/python/index`!

Quoting
=======
.. literalinclude:: quoting.sh
    :language: bash
    :linenos:

Simply copy and paste it to your running Bash session and see what happens.

Absolute Path of Script
=======================
.. literalinclude:: abspath.sh
    :language: bash
    :linenos:

Simply copy and paste it to your running Bash session and see what happens.

Links
=====
Advanced Bash Scripting Guide:
    http://tldp.org/LDP/abs/html/index.html

