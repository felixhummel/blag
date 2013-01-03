Readline
========
Inspired by Doug Hellman's `great article <http://www.doughellmann.com/PyMOTW/cmd/index.html>`__ I played with readline a bit. I will use `cmd <http://www.doughellmann.com/PyMOTW/cmd/index.html>`__ for my purposes, but here's the code for future reference:

.. code-block:: python

    stuff = ['foo/bar', 'foo/baz', 'qux']

    import logging
    LOG_FILENAME = '/tmp/completer.log'
    logging.basicConfig(filename=LOG_FILENAME,
                        level=logging.DEBUG,
                        )

    class SimpleCompleter(object):

        def __init__(self, options):
            self.options = sorted(options)
            return

        def complete(self, text, state):
            response = None
            logging.debug('STATE: %s', state)
            origline = readline.get_line_buffer()
            begin = readline.get_begidx()
            end = readline.get_endidx()
            being_completed = origline[begin:end]
            logging.debug('origline=%s', repr(origline))
            logging.debug('begin=%s', begin)
            logging.debug('end=%s', end)
            logging.debug('being_completed=%s', being_completed)
            if state == 0:


                if end == 0:
                    self.matches = self.options
                else:
                    self.matches = [
                            s[begin:] # only the remaining characters
                            for s in self.options
                            if s.startswith(origline) # should begin with complete line input
                            ]
                    # bash-like: if remaining string was found, append a space, ending completion
                    if len(self.matches) == 1:
                        response = self.matches[state] + ' '
                        return response
                    logging.debug('options starting with %s: %s', origline, repr(self.matches))

            try:
                response = self.matches[state]
            except IndexError:
                response = None
            return response

    readline.set_completer(SimpleCompleter(stuff).complete)
    readline.parse_and_bind('tab: complete')

    thing = raw_input('> ')

    print 'result: ', thing

