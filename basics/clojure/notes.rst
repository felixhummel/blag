*************
Clojure Notes
*************
.. highlight:: clojure

REPL
====
Test::

    '((()))

Print last exception::

    (.printStackTrace *e)

`(do` returns last sequence

Add cool stuff::

    (use 'clojure.contrib.repl-utils)
    (source +)

Show contents of a lib::

    (ns-publics 'clojure.contrib.repl-utils)

Using the help (p. 52)::

    (find-doc #"\?$")

Evil Macro Stuff
================
Symbols and Vars
----------------
At the REPL, `q` is not defined, but the symbol `'q` exists of course::

    user=> q
    java.lang.Exception: Unable to resolve symbol: q in this context (NO_SOURCE_FILE:0)
    user=> 'q
    q
    user=> (type 'q)
    clojure.lang.Symbol

Now with `q` defined::

    user=> (def q "hi")
    #'user/q

Evaluating `q` returns its value::

    user=> q
    "hi"
    user=> (type q)
    java.lang.String

Quoting `q` returns its symbol::

    user=> (quote q)
    q
    user=> 'q
    q
    user=> (type 'q)
    clojure.lang.Symbol

Get the var of `q`::

    user=> (var q)
    #'user/q
    user=> #'q
    #'user/q
    user=> (type #'q)
    clojure.lang.Var
    user=> (var-get #'q)
    "hi"

I don't know how to directly get the value of the quoted symbol `'q`, but getting it indirectly looks like this::

    user=> (def foo 'q)
    #'user/foo
    user=> foo
    q
    user=> (var-get (resolve foo))
    "hi"

Metadata
--------
With `q` still defined::

    user=> (def q "hi")
    #'user/q
    user=> (meta q)    
    nil

Namespaces
----------
Switching is nice and easy::

    user=> (ns foo)
    nil
    foo=> (def x "x in foo")
    #'foo/x
    foo=> x
    "x in foo"
    foo=> (ns bar)
    nil
    bar=> x
    java.lang.Exception: Unable to resolve symbol: x in this context (NO_SOURCE_FILE:0)
    bar=> foo/x  
    "x in foo"

Aliasing works too::

    bar=> ; foo/x is too much to type ;)
    bar=> (alias 'f 'foo)  
    nil
    bar=> f/x
    "x in foo"

