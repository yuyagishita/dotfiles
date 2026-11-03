-- Hyprland config (hyprland.conf から移植。0.57 で .conf は廃止)
-- https://wiki.hypr.land/configuring/

----------------
--- MONITORS ---
----------------

local outputPrimary   = "DP-2"
local outputSecondary = "eDP-1"

-- 4kモニター
hl.monitor({ output = outputPrimary, mode = "3840x2160@60", position = "0x0", scale = 1.5 })

-- Thinkpad X13 モニター (4kモニターが1.5の場合)
hl.monitor({ output = outputSecondary, mode = "2560x1600@60", position = "2560x440", scale = 1.6 })

-------------------
--- MY PROGRAMS ---
-------------------

local terminal    = "wezterm"
local fileManager = "dolphin"
local menu        = "~/.config/hypr/scripts/launch-fuzzel.sh"

-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpanel & hyprpaper")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("firefox", { workspace = "1 silent" })
    hl.exec_cmd("nm-applet &")

    -- screensharing
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist -max-items 200 store")  -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist -max-items 200 store") -- Stores only image data
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

---------------------
--- LOOK AND FEEL ---
---------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        force_split    = 2,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.workspace_rule({ workspace = "1", monitor = outputPrimary })
hl.workspace_rule({ workspace = "2", monitor = outputSecondary })

-------------
--- INPUT ---
-------------

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "ctrl:nocaps",
        kb_rules     = "",
        repeat_delay = 300,
        repeat_rate  = 50,
        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-------------------
--- KEYBINDINGS ---
-------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + e", hl.dsp.exit())
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T",         hl.dsp.layout("toggle")) -- dwindle
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd("hyprlock"))

-- Move focus / window with mainMod + arrow keys or hjkl
local directions = {
    { "left",  "left" },
    { "right", "right" },
    { "up",    "up" },
    { "down",  "down" },
    { "h",     "left" },
    { "l",     "right" },
    { "k",     "up" },
    { "j",     "down" },
}
for _, d in ipairs(directions) do
    hl.bind(mainMod .. " + " .. d[1],         hl.dsp.focus({ direction = d[2] }))
    hl.bind(mainMod .. " + SHIFT + " .. d[1], hl.dsp.window.move({ direction = d[2] }))
end
-- モニタの 50% x 50% にリサイズ (0.57 の resize は % 指定を受け付けない)
hl.bind(mainMod .. " + space", function()
    local m = hl.get_active_monitor()
    hl.dispatch(hl.dsp.window.resize({
        x = math.floor(m.width / m.scale / 2),
        y = math.floor(m.height / m.scale / 2),
    }))
end)

-- Group
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.move({ direction = "left",  group_aware = true }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.move({ direction = "right", group_aware = true }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.move({ direction = "up",    group_aware = true }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.move({ direction = "down",  group_aware = true }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + d",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + d", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272",         hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",         hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"))
-- HHKB
hl.bind("Scroll_Lock", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("PAUSE",       hl.dsp.exec_cmd("brightnessctl set +5%"))

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Screenshots
-- [fullscreen, copy(clipboard) & save]
hl.bind(mainMod .. " + SHIFT + a", hl.dsp.exec_cmd([[SCREENSHOT_FILE=~/Pictures/screenshot/$(date "+%Y%m%d-%H%M%S")'_grim_full.png' && grimshot --notify save output ~/Pictures/screenshot/$(date "+%Y%m%d-%H%M%S")'_grim_full.png' && wl-copy < $SCREENSHOT_FILE]]))
-- [slurp, copy & save]
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd([[SCREENSHOT_FILE=~/Pictures/screenshot/$(date "+%Y%m%d-%H%M%S")'_grim_area.png' && grimshot --notify save area $SCREENSHOT_FILE && wl-copy < $SCREENSHOT_FILE]]))

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

hl.window_rule({
    name  = "idle-inhibit-fullscreen",
    match = { class = ".*" },

    idle_inhibit = "fullscreen",
})

-- Ignore maximize requests from apps.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        fullscreen = false,
    },

    no_focus = true,
})
