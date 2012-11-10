#############
Did you know?
#############
Well... at least I did not.

The size of an instance of the smallest new-style user defined class is 32 bytes::

    class X(object):
        pass

    x=X()
    x.__sizeof__()
