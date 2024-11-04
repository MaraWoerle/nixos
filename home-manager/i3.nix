{ config, pkgs, lib, osConfig, ... }:

let
  modifier = config.xsession.windowManager.i3.config.modifier;
in

{
  config = lib.mkIf osConfig.services.xserver.windowManager.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod1";
        gaps = {
          inner = 5;
          outer = 0;
        };
        colors = {
          background = "#856cd9";
          focused = {
            background = "#5c4a94";
            border = "#182030";
            childBorder = "#856cd9";
            indicator = "#856cd9";
            text = "#856cd9";
          };
          unfocused = {
            background = "#5c4a94";
            border = "#5c4a94";
            childBorder = "#5c4a94";
            indicator = "#5c4a94";
            text = "#5c4a94";
          };
          focusedInactive = {
            background = "#5c4a94";
            border = "#5c4a94";
            childBorder = "#5c4a94";
            indicator = "#5c4a94";
            text = "#5c4a94";
          };
        };
        window = {
          border = 3;
          titlebar = false;
        };
        bars = [
          {
            position = "top";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
            fonts = {
              names = [ "Hack Nerd Font" ];
              size = 10.0;
            };
            colors = {
              background = "#182030";
              statusline = "#c5ccd4";
              separator = "#856cd9";
            };
            workspaceButtons = false;
          }
        ];
        startup = [
          { command = "dex --autostart --environment i3"; }
          { command = "nm-applet"; }
          { command = "xset s off"; }
          { command = "xset -dpms"; }
          { command = "xrandr --output HDMI-0 --mode 1920x1080 --rate 60.00 --primary --output DP-2 --mode 1920x1080 --rate 60.00 --left-of HDMI-0 --output DP-0 --mode 1920x1080 --rate 60.00 --right-of HDMI-0"; }
          { command = "feh --randomize --bg-scale ~/Documents/Syncthing/Desktop-Backgrounds"; }
          { command = "xidlehook --not-when-fullscreen --not-when-audio --timer 300 'brightnessctl set 50%' 'brightnessctl set 100%' --timer 60 'brightnessctl set 100%; betterlockscreen -l dim' '' --timer 60 'brightnessctl set 50%' 'brightnessctl set 100%'"; }
          { command = "betterlockscreen -u ~/Documents/Syncthing/Desktop-Backgrounds"; }
          { command = "xss-lock betterlockscreen -l dim"; }
          { command = "numlockx on"; }
          { command = "i3-auto-layout"; }
        ];
        keybindings = {
          # App launch menu
          "${modifier}+d" = "exec rofi -show drun";
          "${modifier}+s" = "exec rofi -show ssh";
          "${modifier}+f" = "exec rofi -show filebrowser";
          "${modifier}+Shift+Return" = "exec rofi -show combi";
          "${modifier}+space" = "exec rofi -show combi";
          # Multimedia
          "XF86AudioRaiseVolume" = "exec --no-startup-id amixer -q sset Master 5%+ unmute";
          "XF86AudioLowerVolume" = "exec --no-startup-id amixer -q sset Master 5%- unmute";
          "XF86AudioMute" = "exec --no-startup-id amixer -q sset Master toggle";
          "XF86AudioMicMute" = "exec --no-startup-id amixer -q sset Capture toggle";
          # Media player controls
          "XF86AudioPlay" = "exec playerctl -p spotify play-pause";
          "XF86AudioPause" = "exec playerctl -p spotify play-pause";
          "XF86AudioNext" = "exec playerctl -p spotify next";
          "XF86AudioPrev" = "exec playerctl -p spotify previous";
          "Ctrl+XF86AudioPlay" = "exec playerctl -p firefox play-pause";
          "Ctrl+XF86AudioPause" = "exec playerctl -p firefox play-pause";
          "Ctrl+XF86AudioNext" = "exec playerctl -p firefox next";
          "Ctrl+XF86AudioPrev" = "exec playerctl -p firefox previous";
          # Brightness control
          "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +5%";
          "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 5%--autostart";
          # Screenshots
          "Print" = "exec flameshot full";
          "Shift+Print" = "exec flameshot gui";
          "Mod4+Shift+s" = "exec flameshot gui";
          # Random Background
          "${modifier}+Shift+b" = "exec feh --randomize --bg-scale ~/Documents/Syncthing/Desktop-Backgrounds";
          # Fullscreen
          "${modifier}+Shift+f" = "fullscreen toggle";
          # start Terminal
          "${modifier}+Return" = "exec kitty";
          # Kill Window
          "${modifier}+Shift+q" = "kill";
          # File Explorer
          "${modifier}+a" = "exec nemo";
          # Keyindicator
          "--release Caps_Lock" = "exec pkill -SIGRTMIN+11 i3blocks";
          # Shadowrealm
          "${modifier}+Shift+s" = "move scratchpad";
          "${modifier}+Shift+w" = "scratchpad show";
          # change focus
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";
          # move focused window
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";
          # split in horizontal orientation
          "${modifier}+h" = "split h";
          # split in vertical orientation
          "${modifier}+v" = "split v";
          # toggle tiling / floating
          "${modifier}+Shift+space" = "floating toggle";
          # Lock Screen
          "${modifier}+Shift+l" = "exec --no-startup-id betterlockscreen -l dim";
          "Mod4+l" = "exec --no-startup-id betterlockscreen -l dim";
          # Reload Config
          "${modifier}+Shift+c" = "reload";
          # Restart i3
          "${modifier}+Shift+r" = "restart";
          # Shutdown
          "${modifier}+Shift+Escape" = "exec shutdown -h now";
          "${modifier}+Ctrl+Escape" = "exec reboot";
          # Resize
          "${modifier}+r" = "mode resize";
        };
        modes = {
          resize = {
            "Shift+Up" = "resize grow width 10 px or 10 ppt";
            "Down" = "resize shrink height 10 px or 10 ppt";
            "Up" = "resize grow height 10 px or 10 ppt";
            "Shift+Down" = "resize shrink width 10 px or 10 ppt";
            "Return" = "mode default";
            "Escape" = "mode default";
            "${modifier}+r" = "mode default";
          };
        };
      };
    };
  };
}
