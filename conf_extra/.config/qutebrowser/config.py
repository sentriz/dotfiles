padding = {
    "top": 4,
    "bottom": 4,
    "left": 4,
    "right": 4,
}

palette = {
    "background": "#282a36",
    "background-alt": "#282a36",
    "background-attention": "#181920",
    "border": "#282a36",
    "current-line": "#44475a",
    "selection": "#44475a",
    "foreground": "#f8f8f2",
    "foreground-alt": "#e0e0e0",
    "foreground-attention": "#ffffff",
    "comment": "#6272a4",
    "cyan": "#8be9fd",
    "green": "#50fa7b",
    "orange": "#ffb86c",
    "pink": "#ff79c6",
    "purple": "#bd93f9",
    "red": "#ff5555",
    "yellow": "#f1fa8c",
}

c.auto_save.session = True
c.backend = "webengine"
c.content.default_encoding = "utf-8"
c.content.geolocation = False
c.spellcheck.languages = ["en-GB"]
c.tabs.background = True

# bindings
config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind("<Ctrl-w>", "fake-key <Ctrl-backspace>", mode="insert")
config.bind(",m", "spawn mpv {url}")
config.bind(",M", "hint links spawn mpv {hint-url}")

# appearence
c.statusbar.padding = padding
c.statusbar.widgets = ["keypress", "url", "scroll", "progress"]
c.tabs.favicons.scale = 1
c.tabs.indicator.width = 1
c.tabs.padding = padding
c.tabs.show = "multiple"
c.tabs.title.format = "{current_title}"
c.tabs.title.format_pinned = ""
c.tabs.max_width = 200

# theme
c.colors.completion.category.bg = palette["background"]
c.colors.completion.category.border.bottom = palette["border"]
c.colors.completion.category.border.top = palette["border"]
c.colors.completion.category.fg = palette["foreground"]
c.colors.completion.even.bg = palette["background"]
c.colors.completion.fg = palette["foreground"]
c.colors.completion.item.selected.bg = palette["selection"]
c.colors.completion.item.selected.border.bottom = palette["selection"]
c.colors.completion.item.selected.border.top = palette["selection"]
c.colors.completion.item.selected.fg = palette["foreground"]
c.colors.completion.match.fg = palette["orange"]
c.colors.completion.odd.bg = palette["background-alt"]
c.colors.completion.scrollbar.bg = palette["background"]
c.colors.completion.scrollbar.fg = palette["foreground"]
c.colors.downloads.bar.bg = palette["background"]
c.colors.downloads.error.bg = palette["background"]
c.colors.downloads.error.fg = palette["red"]
c.colors.downloads.stop.bg = palette["background"]
c.colors.downloads.system.bg = "none"
c.colors.hints.bg = palette["background"]
c.colors.hints.fg = palette["purple"]
c.colors.hints.match.fg = palette["foreground-alt"]
c.colors.keyhint.bg = palette["background"]
c.colors.keyhint.fg = palette["purple"]
c.colors.keyhint.suffix.fg = palette["selection"]
c.colors.messages.error.bg = palette["background"]
c.colors.messages.error.border = palette["background-alt"]
c.colors.messages.error.fg = palette["red"]
c.colors.messages.info.bg = palette["background"]
c.colors.messages.info.border = palette["background-alt"]
c.colors.messages.info.fg = palette["comment"]
c.colors.messages.warning.bg = palette["background"]
c.colors.messages.warning.border = palette["background-alt"]
c.colors.messages.warning.fg = palette["red"]
c.colors.prompts.bg = palette["background"]
c.colors.prompts.border = "1px solid " + palette["background-alt"]
c.colors.prompts.fg = palette["cyan"]
c.colors.prompts.selected.bg = palette["selection"]
c.colors.statusbar.caret.bg = palette["background"]
c.colors.statusbar.caret.fg = palette["orange"]
c.colors.statusbar.caret.selection.bg = palette["background"]
c.colors.statusbar.caret.selection.fg = palette["orange"]
c.colors.statusbar.command.bg = palette["background"]
c.colors.statusbar.command.fg = palette["pink"]
c.colors.statusbar.command.private.bg = palette["background"]
c.colors.statusbar.command.private.fg = palette["foreground-alt"]
c.colors.statusbar.insert.bg = palette["background-attention"]
c.colors.statusbar.insert.fg = palette["foreground-attention"]
c.colors.statusbar.normal.bg = palette["background"]
c.colors.statusbar.normal.fg = palette["foreground"]
c.colors.statusbar.passthrough.bg = palette["background"]
c.colors.statusbar.passthrough.fg = palette["orange"]
c.colors.statusbar.private.bg = palette["background-alt"]
c.colors.statusbar.private.fg = palette["foreground-alt"]
c.colors.statusbar.progress.bg = palette["background"]
c.colors.statusbar.url.error.fg = palette["red"]
c.colors.statusbar.url.fg = palette["foreground"]
c.colors.statusbar.url.hover.fg = palette["cyan"]
c.colors.statusbar.url.success.http.fg = palette["green"]
c.colors.statusbar.url.success.https.fg = palette["green"]
c.colors.statusbar.url.warn.fg = palette["yellow"]
c.colors.tabs.bar.bg = palette["selection"]
c.colors.tabs.even.bg = palette["selection"]
c.colors.tabs.even.fg = palette["foreground"]
c.colors.tabs.indicator.error = palette["red"]
c.colors.tabs.indicator.start = palette["orange"]
c.colors.tabs.indicator.stop = palette["green"]
c.colors.tabs.indicator.system = "none"
c.colors.tabs.odd.bg = palette["selection"]
c.colors.tabs.odd.fg = palette["foreground"]
c.colors.tabs.selected.even.bg = palette["background"]
c.colors.tabs.selected.even.fg = palette["foreground"]
c.colors.tabs.selected.odd.bg = palette["background"]
c.colors.tabs.selected.odd.fg = palette["foreground"]
c.fonts.default_family = ["Source Code Pro"]
c.hints.border = "1px solid " + palette["background-alt"]
