GNU Screen
==========
Basically a window manager for the console. See http://www.gnu.org/software/screen/.

My Favorite Commands
--------------------
List existing sessions::

    screen -ls

Create session named MYSESSION::

    screen -S MYSESSION

Reattach to session MYSESSION::

    screen -r MYSESSION

If you got disconnected, detach and reattach to session MYSESSION::

    screen -dr MYSESSION

Shortcuts in a screen session
-----------------------------
detach:

    *C-a, d* (read *Ctrl* and *a* together, then *d*)
