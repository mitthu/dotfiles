-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")

---+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Vicious Widgets                                                       |

-- {{{ Battery state
-- Text widget
batwidget_text = wibox.widget.textbox()
vicious.register(batwidget_text, vicious.widgets.bat, " | $1: $2% ", 61, "BAT0")
-- Progress bar
batwidget = awful.widget.progressbar()
batwidget:set_width(8)
batwidget:set_height(10)
batwidget:set_vertical(true)
batwidget:set_background_color("#494B4F")
batwidget:set_border_color(nil)
batwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 0, 10 },
    stops = { { 0, "#AECF96" }, { 0.5, "#88A175" }, { 1, "#FF5656" }}})
vicious.register(batwidget, vicious.widgets.bat, "$2", 61, "BAT0")

-- {{{ Memory
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "䷀ $1%", 13)

-- {{{ CPU
cpuwidget = awful.widget.graph()
cpuwidget:set_width(50)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 50, 0 },
    stops = { { 0, "#FF5656" }, { 0.5, "#88A175" }, { 1, "#AECF96" }}})
vicious.cache(vicious.widgets.cpu)
vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 3)

-- {{{ Volume
volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume,
  function(widget, args)
    local label = { ["♫"] = "O", ["♩"] = "M" }
    return " | ♫: " .. args[1] .. "%, " .. label[args[2]] .. " | "
  end, 2, "Master")

-- Vicious Widgets                                                       |
---+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- Load Debian menu entries
require("debian.menu")

-- Plugins
local tyrannical = require("tyrannical")
require("eminent")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xfce4-terminal"
editor = os.getenv("EDITOR") or "editor"
home = os.getenv("HOME")
editor_cmd = terminal .. " -e " .. editor

-- Startup Applications
-- Kill old instances on awesome config reload
awful.util.spawn_with_shell("killall nm-applet; nm-applet", false)
awful.util.spawn_with_shell("killall xscreensaver; xscreensaver -nosplash", false)
awful.util.spawn(home.."/.dropbox-dist/dropboxd", false)

-- Start terminal and start/attach to a tmux session
--awful.util.spawn(terminal .. ' -e="' .. os.getenv("HOME") .. '/.me/bin_hidden/start_tmux"')
--awful.util.spawn("google-chrome-stable chrome-extension://enfaahabcinohafeakbliimmoholjeip/pingpong/apps/shell/index.html#__platform=CHROME-EXTENSION&finger-print=a5cb13be-49d5-4f25-8aef-7150b225b882")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
all_screens      = {1, 2}
primary_screen   = 1
secondary_screen = screen.count()>1 and 2 or 1 -- Setup on screen 2 if there is more than 1 screen, else on screen 1
tyrannical.tags_disable = {
    {
        name        = "Term",                 -- Call the tag "Term"
      --icon        = "/usr/share/pixmaps/xfce4-terminal.xpm", -- Use this icon for the tag
        init        = true,                   -- Load the tag on startup
        exclusive   = false,                  -- Refuse any other type of clients (by classes)
        fallback    = true,
        screen      = primary_screen,         -- create this tag on screen 3 and screen 2
        layout      = awful.layout.suit.tile, -- use the tile layout
	  --class       = { "Terminal", "xfce4-terminal", "gnome-terminal", "xterm" }
    } ,
    {
        name        = "Firefox",
        init        = true,
        exclusive   = false,
      --icon        = "/usr/share/pixmaps/firefox.png", -- Use this icon for the tag (uncomment with a real path)
        screen      = secondary_screen,
        layout      = awful.layout.suit.max,       -- Use the max layout
      --exec_once   = {"firefox"},
        class = {
            "Opera"         , "Firefox"        , "Rekonq"    , "Dillo"        , "Arora",
            "Chromium"      , "nightly"        , "minefield"    }
    } ,
    {
        name        = "Chrome",
        init        = true,
        exclusive   = false,
      --icon        = "/usr/share/icons/hicolor/16x16/apps/google-chrome.png", -- Use this icon for the tag (uncomment with a real path)
        screen      = secondary_screen,
        layout      = awful.layout.suit.tile,      -- Use the max layout
        instance    = {"google-chrome-stable", "chrome"},
        class = {
            "Go.to", "Google-chrome-stable", "Google-chrome", "chrome"    }
    } ,
    {
        name = "Mail",
        init        = false,
        exclusive   = false,
        screen      = primary_screen,
        layout      = awful.layout.suit.tile,
      --exec_once   = {"thunderbird"}, --When the tag is accessed for the first time, execute this command
        class  = {
            "Thunderbird", "Evolution"
        }
    } ,
    {
        name = "Files",
        init        = true,
        exclusive   = false,
        screen      = primary_screen,
        layout      = awful.layout.suit.max,
        exec_once   = {"dolphin"}, --When the tag is accessed for the first time, execute this command
        class  = {
            "Thunar", "Konqueror", "Dolphin", "ark", "Nautilus","emelfm"
        }
    } ,
    {
        name = "Music",
        init        = false,
        exclusive   = false,
        screen      = primary_screen,
        layout      = awful.layout.suit.tile,
        class  = {
            "Music", "Rhythmbox", "Amarok",
        }
    } ,
    {
        name        = "Doc",
        init        = false, -- This tag wont be created at startup, but will be when one of the
                             -- client in the "class" section will start. It will be created on
                             -- the client startup screen
        exclusive   = false,
        screen      = primary_screen,
        layout      = awful.layout.suit.max,
        class       = {
            "Assistant"     , "Okular"         , "Evince"    , "EPDFviewer"   , "xpdf",
            "Xpdf"          ,                                        }
    } ,
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
    "ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"               ,
    "feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color"    ,
    "kcolorchooser" , "plasmoidviewer" , "Xephyr"    , "kruler"       , "plasmaengineexplorer",
}

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
    "MPlayer"      , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
    "xine"         , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
    "yakuake"      , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
    "New Form"     , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer" 
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
    "Xephyr"       , "ksnapshot"       , "kruler"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
    "kcalc"
}

tyrannical.settings.block_children_focus_stealing = true --Block popups ()
tyrannical.settings.group_children = true --Force popups/dialogs to have the same tags as the parent client

-- Default Config
tags = {
	names = {"1", "2", "3", "4", "5", 6, 7, 8, 9 },
	layout = layouts[2]
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
---}}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    --right_layout:add(cpuwidget)
    right_layout:add(memwidget)
    right_layout:add(batwidget_text)
    --right_layout:add(batwidget)
    right_layout:add(volumewidget)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local float_change_dimesions = 200

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- My Customizations
    --++++++++++++++++++
    -- Window Resize
    awful.key({ modkey, "Mod1"    }, "Right",  function () awful.tag.incmwfact( 0.01)    end),
    awful.key({ modkey, "Mod1"    }, "Left",   function () awful.tag.incmwfact(-0.01)    end),
    awful.key({ modkey, "Mod1"    }, "Down",   function () awful.client.incwfact( 0.01)  end),
    awful.key({ modkey, "Mod1"    }, "Up",     function () awful.client.incwfact(-0.01)  end),

    -- Floaters (Floating Windows)
    -- ===========================
    -- Movement (Mod + Ctrl + Arrow Keys)
   awful.key({ modkey, "Control" }, "Down",  function () awful.client.moveresize(  0,  float_change_dimesions,   0,   0) end),
   awful.key({ modkey, "Control" }, "Up",    function () awful.client.moveresize(  0, -float_change_dimesions,   0,   0) end),
   awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize(-float_change_dimesions,   0,   0,   0) end),
   awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize( float_change_dimesions,   0,   0,   0) end),

   -- Resize (Mod + Shift + Arrow Keys/Page Up/Page Down)
   awful.key({ modkey, "Shift" }, "Next",  function () awful.client.moveresize( float_change_dimesions,  float_change_dimesions, -2*float_change_dimesions, -2*float_change_dimesions) end),
   awful.key({ modkey, "Shift" }, "Prior", function () awful.client.moveresize(-float_change_dimesions, -float_change_dimesions,  2*float_change_dimesions,  2*float_change_dimesions) end),
   awful.key({ modkey, "Shift" }, "Down",  function () awful.client.moveresize(  0,   0,   0,  float_change_dimesions) end),
   awful.key({ modkey, "Shift" }, "Up",    function () awful.client.moveresize(  0,   0,   0, -float_change_dimesions) end),
   awful.key({ modkey, "Shift" }, "Left",  function () awful.client.moveresize(  0,   0, -float_change_dimesions,   0) end),
   awful.key({ modkey, "Shift" }, "Right", function () awful.client.moveresize(  0,   0,  float_change_dimesions,   0) end),

    -- Event based
    --------------
    -- Volumn control
    awful.key({ }, "XF86AudioRaiseVolume", function ()
       awful.util.spawn("amixer -D pulse sset Master 8%+", false) end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
       awful.util.spawn("amixer -D pulse sset Master 8%-", false) end),
    awful.key({ }, "XF86AudioMute", function ()
       awful.util.spawn("amixer -D pulse sset Master toggle", false) end),

    -- Brightness control
    awful.key({ }, "XF86MonBrightnessDown", function ()
       awful.util.spawn("xbacklight -dec 40", false) end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
       awful.util.spawn("xbacklight -inc 40", false) end),

    -- Running programs
    awful.key({ modkey,           }, "z", function() awful.util.spawn("xscreensaver-command -lock") end),
    awful.key({ modkey, "Shift"   }, "z", function() awful.util.spawn("xtrlock") end),
    awful.key({ modkey, "Shift"   }, "s", function() awful.util.spawn("sudo pm-suspend") end),
    awful.key({ modkey, "Control"   }, "c", function() awful.util.spawn("google-chrome --disable-gpu") end),

    -- Misc
    -- ====
    -- Toggle status bar (Mod + b)
    awful.key({ modkey }, "b", function () mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),

    -- Tag Management
    awful.key({ modkey, "Shift" }, "d", function () awful.tag.delete() end),
    awful.key({ modkey, "Shift" }, "r",
             function ()
                awful.prompt.run({ prompt = "Rename tag: " },
                                 mypromptbox[mouse.screen].widget,
                                 function(new_name)
                                    if not new_name or #new_name == 0 then
                                       return
                                    else
                                       local screen = mouse.screen
                                       local tag = awful.tag.selected(screen)
                                       if tag then
                                          tag.name = new_name
                                       end
                                    end
                                 end)
             end),
    awful.key({ modkey, "Shift" }, "a",
        function ()
                  awful.prompt.run({ prompt = "New tag name: " },
                    mypromptbox[mouse.screen].widget,
                    function(new_name)
                        if not new_name or #new_name == 0 then
                            return
                        else
                            props = {selected = true}
                            if tyrannical.tags_by_name[new_name] then
                               props = tyrannical.tags_by_name[new_name]
                            end
                            t = awful.tag.add(new_name, props)
                            awful.tag.viewonly(t)
                        end
                    end
                    )
        end)
)

-- Source: http://awesome.naquadah.org/wiki/FullScreens
-- Date: 12-Sept-2014
function fullscreens(c)
    awful.client.floating.toggle(c)
    if awful.client.floating.get(c) then
        local clientX = screen[1].workarea.x
        local clientY = screen[1].workarea.y
        local clientWidth = 0
        -- look at http://www.rpm.org/api/4.4.2.2/llimits_8h-source.html
        local clientHeight = 2147483640
        for s = 1, screen.count() do
            clientHeight = math.min(clientHeight, screen[s].workarea.height)
            clientWidth = clientWidth + screen[s].workarea.width
        end
        local t = c:geometry({x = clientX, y = clientY, width = clientWidth, height = clientHeight})
    else
        --apply the rules to this client so he can return to the right tag if there is a rule for that.
        awful.rules.apply(c)
    end
    -- focus our client
    client.focus = c
end

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "f",      fullscreens),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { }, properties = { }, callback = awful.client.setslave },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    --c:connect_signal("mouse::enter", function(c)
    --    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
    --        and awful.client.focus.filter(c) then
    --        client.focus = c
    --    end
    --end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
