### about

some of my scripts make use of libnotify-id's `notify-send` id and replace system. so we need the patched version. mako is like a dunst for wayland  
it is started by sway using some of the variables defined there. so we need to delete the service that starts it automatically

### packages

  - (aur) libnotify-id
  - mako

### commands

    $ rm /usr/share/dbus-1/services/fr.emersion.mako.service
