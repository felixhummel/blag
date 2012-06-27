QBzr Colors for KDE4 Obsidian Coast Theme
=========================================
The "Obsidian Coast" is a rather dark theme for KDE4. To make QBzr's qdiff useful for this theme, changing its colors is vital.

.. highlight:: bash

You need to have a working internet connection and Bazaar installed. To get, install and configure the newest qbzr::

    bzrhome=$HOME/.bazaar
    cd $bzrhome
    mkdir -p plugins
    cd plugins
    bzr co lp:qbzr
    cd $bzrhome
                          
    # sample config
    echo "\
    [DEFAULT]
    browse_window_size = 780x580
    browse_window_maximized = True
    diff_window_size = 780x580
    diff_window_maximized = True
    log_window_size = 710x580
    log_window_maximized = True
    cat_window_size = 780x580
    cat_window_maximized = True
    config_window_size = 763x457
    config_window_maximized = True
    diff_show_intergroup_colors = True

    [QDIFF COLORS]
    # see qbzr/lib/diffview.py
    interline_changes_background = 0, 10, 0
    replace_fill = 0, 10, 0
    replace_bound = 0, 80, 0
    delete_fill = 40, 0, 0
    delete_bound = 80, 0, 0
    insert_fill = 0, 30, 0
    insert_bound = 0, 80, 0
    blank_fill = 0, 0, 30
    blank_bound = 0, 0, 80
    [EXTDIFF]
    " > $bzrhome/qbzr.conf

Try it::

    # change to a branch of yours
    bzr qdiff -r1..2
