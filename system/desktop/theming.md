### about

consistent look between `gtk2`, `gtk3`, `qt4`, and `qt5`.  
all that is needed are some packages. the the following is set up in `public_extra/`:  

|toolkit|where|what|
|---|---|---|
|gtk2|fish start_sway|`GTK2_RC_FILES=/usr/share/themes/Adwaita/gtk-2.0/gtkrc`|
|gtk3|fish start_sway|`GTK_THEME=Adwaita`|
|qt4|Trolltech.conf (can't configure with var like the rest)|`[Qt] style=adwaita`|
|qt5|fish start_sway|`QT_STYLE_OVERRIDE=adwaita`|

### packages

  - gnome-themes-extra (for adwaita, gtk2)
  - gtk3 (for adwaita, gtk3)
  - adwaita-qt4 (for adwaita, qt4)
  - adwaita-qt (for adwaita, qt5)
