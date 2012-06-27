***
Vim
***
Notes about my editor of choice.

.. toctree::

    django_completion

.. highlight:: vim

Sphinx ftplugin
===============
I am very proud of my first vim plugin: :download:`sphinx.vim`

For now, only creating and changing headings is mapped on the F1-F6 keys. More will follow.

Wrapping a Python Function in a Vim function
============================================
Normally the following snippet would suffice::

    fun! Vimfun()
        python pyfun()
    endfun

But if you want to pass parameters, you'll need something like this (please correct me if I'm wrong).

.. literalinclude:: call_pyfunc_with_args.vim
    :language: vim
    :encoding: utf-8

Ugly Whitespace
===============
To show all whitespace at line end::

    :match Error /\s\+$/

To remove it::

    :%s/\s\+$//

Folding
=======
See also: ``:help usr_28``. Set folding for XML (in ``.vimrc``)::

    " XML syntax folding
    let g:xml_syntax_folding=1
    au FileType xml setlocal foldmethod=syntax
    
Shortcuts (from `nion's blog`_ on 2009-03-23):

== ==============================================
zf create folder
zd delete folder under cursor
zD delete folder recursive
zE delete all folders in file
zo open folder under curso
zO open folder recursive
zc close folder under cursor
zC same as zc recursive
za open folder if closed, close folder if opened
== ==============================================

.. _nion's blog: http://nion.modprobe.de/blog/archives/448-Folding-in-VIM.html

Templates
=========
Want easy templates? See http://www.vim.org/scripts/script.php?script_id=2540!

File Explorer
=============
`NERDTree <http://www.vim.org/scripts/script.php?script_id=1658>`__ is the answer. Wanted it on the right, so I added a one-liner to my .vimrc::

    let g:NERDTreeWinPos="right"

Beautiful.

Links
=====
- `Python and vim - Two great tastes that go great together <http://www.tummy.com/Community/Presentations/vimpython-20070225/vim.html>`_

