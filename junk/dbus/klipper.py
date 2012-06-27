#!/usr/bin/python
# vim: set fileencoding=utf-8 :
import dbus
try:
    bus = dbus.SessionBus()
except:
    print "Could not connect to dbus."
    sys.exit(1)

app_name = 'org.kde.klipper'
path = '/klipper'
dbus_interface='org.kde.klipper.klipper'
try:
    klipper = dbus.Interface(bus.get_object(app_name, path),
                            dbus_interface=dbus_interface)
except:
    print "Could not connect to %s."%app_name
    sys.exit(1)

print dir(klipper)
