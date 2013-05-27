Profiling
=========
- profile and visualize: https://code.google.com/p/jrfonseca/wiki/Gprof2Dot#python_profile
    I prefer xdot::

        wajig install xdot
        gprof2dot.py -f pstats output.pstats > out.dot
        xdot out.dot

- http://docs.python.org/2/library/profile.html
