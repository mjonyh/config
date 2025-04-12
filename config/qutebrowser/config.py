# Qutebrowser configuration file
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Don't load settings configured via autoconfig.yml
config.load_autoconfig(False)

# === General Settings ===
c.auto_save.session = True
c.completion.height = "30%"
c.completion.web_history.max_items = 5000
c.confirm_quit = ["downloads"]
c.scrolling.smooth = True
c.tabs.show = "always"
c.tabs.position = "top"
c.tabs.title.format = "{index}: {current_title}"
c.tabs.select_on_remove = "last-used"
c.downloads.location.directory = "~/Downloads"
c.downloads.position = "bottom"

# === Privacy & Security ===
c.content.cookies.accept = "no-3rdparty"
c.content.cookies.store = True
c.content.site_specific_quirks.enabled = True
c.content.canvas_reading = True
c.content.webgl = True
c.content.geolocation = False
c.content.notifications.enabled = False
c.content.private_browsing = False
c.content.default_encoding = "utf-8"

# Specific sites might need special cookie settings
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

# === Media Settings ===
c.content.autoplay = False
c.content.mute = False

# === Appearance ===
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "smart"
c.colors.webpage.darkmode.policy.page = "smart"
c.colors.webpage.preferred_color_scheme = "dark"

# Set color scheme
c.colors.webpage.bg = "#1e1e2e"  # Catppuccin mocha background
# Font settings
c.fonts.default_family = ["Hack Nerd Font", "DejaVu Sans Mono", "monospace"]
c.fonts.default_size = "11pt"
c.fonts.web.family.standard = "Hack Nerd Font"
c.fonts.web.family.fixed = "Hack Nerd Font Mono"
c.fonts.web.size.default = 16
c.fonts.web.size.default_fixed = 14

# === Content Settings ===
c.content.javascript.enabled = True
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Images
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

# === URL Settings ===
c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "g": "https://www.google.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "gh": "https://github.com/search?q={}",
    "w": "https://en.wikipedia.org/wiki/Special:Search?search={}",
    "r": "https://old.reddit.com/r/{}",
    "aur": "https://aur.archlinux.org/packages?K={}",
    "arch": "https://wiki.archlinux.org/index.php?search={}"
}

# === User Agent Settings ===
# Set user agent for specific sites
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:131.0) Gecko/20100101 Firefox/131.0', 'https://accounts.google.com/*')

# === Hardware Acceleration ===
c.qt.force_platform = "wayland"
c.qt.highdpi = True
c.qt.process_model = "process-per-site-instance"
c.scrolling.bar = "overlay"

# === Custom Key Bindings ===
# Media playback with mpv
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('Y', 'hint links yank')
config.bind('Z', 'hint links download')

# Tab navigation
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('<Alt-1>', 'tab-focus 1')
config.bind('<Alt-2>', 'tab-focus 2')
config.bind('<Alt-3>', 'tab-focus 3')
config.bind('<Alt-4>', 'tab-focus 4')
config.bind('<Alt-5>', 'tab-focus 5')
config.bind('<Alt-6>', 'tab-focus 6')
config.bind('<Alt-7>', 'tab-focus 7')
config.bind('<Alt-8>', 'tab-focus 8')
config.bind('<Alt-9>', 'tab-focus 9')

# Zoom controls
config.bind('<Ctrl++>', 'zoom-in')
config.bind('<Ctrl+->', 'zoom-out')
config.bind('<Ctrl+0>', 'zoom 100')

# History navigation
config.bind('<Ctrl+h>', 'back')
config.bind('<Ctrl+l>', 'forward')

# Quick open bookmark/quickmark
config.bind('b', 'set-cmd-text -s :bookmark-load')
config.bind('B', 'set-cmd-text -s :bookmark-load -t')
config.bind('m', 'set-cmd-text -s :quickmark-load')
config.bind('M', 'set-cmd-text -s :quickmark-load -t')

# Clipboard operations
config.bind('yy', 'yank url')
config.bind('yt', 'yank title')
config.bind('yp', 'yank pretty-url')

# === Local Content Access ===
config.set('content.local_content_can_access_remote_urls', True, 'file:///home/mjonyh/.local/share/qutebrowser/userscripts/*')
config.set('content.local_content_can_access_file_urls', False, 'file:///home/mjonyh/.local/share/qutebrowser/userscripts/*')

# === Ad Blocking ===
c.content.blocking.enabled = True
c.content.blocking.method = "auto"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
]

# === Spellcheck ===
c.spellcheck.languages = ["en-US"]

# === PDF.js ===
# Use PDF.js to display PDFs in the browser
c.content.pdfjs = True