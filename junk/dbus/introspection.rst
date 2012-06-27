Dbus Introspection on KDE 4
===========================
::

    qdbus  # lists services
    qdbus <service>  # lists service's paths
    qdbus <service> <path>  # lists interfaces for service at path
    qdbus <service> <path> <interface>  # call method (remove "()" at the end)
    qdbus <service> <path> <interface> <args> # call method (remove "()" at the end) with args
