### packages

  - ttf-emojione

### files
`~/.config/fontconfig/conf.d/50-emojione-color.conf`

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias binding="strong">
        <family>emoji</family>
        <default><family>Emoji One</family></default>
      </alias>
      <alias binding="strong">
        <family>Apple Color Emoji</family>
        <prefer><family>Emoji One</family></prefer>
      </alias>
      <alias binding="strong">
        <family>Segoe UI Emoji</family>
        <prefer><family>Emoji One</family></prefer>
      </alias>
      <alias binding="strong">
        <family>Noto Color Emoji</family>
        <prefer><family>Emoji One</family></prefer>
      </alias>
      <selectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>Symbola</string>
            </patelt>
          </pattern>
        </rejectfont>
      </selectfont>
    </fontconfig>

### commands

    $ fc-cache -f -v
    
### see also
  - [terminal](https://github.com/sentriz/dotfiles/blob/master/system/terminal.md)
