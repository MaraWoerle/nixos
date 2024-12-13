{ config, pkgs, lib, osConfig, ... }:

let
  modifier = config.wayland.windowManager.sway.config.modifier;
in

{
  config = lib.mkIf osConfig.programs.sway.enable {
    wayland.windowManager.sway = {
      enable = true;
      # package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
      extraOptions = [ "--unsupported-gpu" ];
      xwayland = true;
      
      checkConfig = false;
      config = {
        modifier = "Mod1";
        terminal = "kitty";

        input = {
          "*" = {
            xkb_layout = "de";
            xkb_numlock = "enabled";
            accel_profile = "flat";
            pointer_accel = "-0.1";
          };
        };

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
          # { command = "dex --autostart --environment i3"; }
          # { command = "nm-applet"; }
          # { command = "xset s off"; }
          { command = "xset -dpms"; }
          # { command = "xrandr --output HDMI-0 --mode 1920x1080 --rate 60.00 --primary --output DP-2 --mode 1920x1080 --rate 60.00 --left-of HDMI-0 --output DP-0 --mode 1920x1080 --rate 60.00 --right-of HDMI-0"; }
          # { command = "swaybg -i $(find /home/mara/Documents/Syncthing/Desktop-Backgrounds/. -type f | shuf -n1) -m fill"; }
          { command = "xidlehook --not-when-fullscreen --not-when-audio --timer 300 'brightnessctl set 50%' 'brightnessctl set 100%' --timer 60 'brightnessctl set 100%; betterlockscreen -l dim' '' --timer 60 'brightnessctl set 50%' 'brightnessctl set 100%'"; }
          { command = "betterlockscreen -u ~/Documents/Syncthing/Desktop-Backgrounds"; }
          { command = "xss-lock betterlockscreen -l dim"; }
          # { command = "i3-auto-layout"; }
          { command = "wpaperd -d"; }
          # Themes
          { command = "gsetting set org.gnome.desktop.interface gtk-theme 'rose-pine-moon'"; }
          { command = "gsetting set org.gnome.desktop.interface icon-theme 'Vivid-Dark-Icons'"; }
          { command = "gsetting set org.gnome.desktop.interface cursor-theme 'Sweet-cursors'"; }
        ];

        keybindings = let
          wofiCmd = "wofi -O alphabetical -S";
        in {
          # App launch menu
          "${modifier}+d" = "exec ${wofiCmd} drun";
          "${modifier}+s" = "exec cat ~/.ssh/config | grep 'Host ' | cut -d ' ' -f 2 | sort | ${wofiCmd} dmenu | xargs kitty kitten ssh";
          # "${modifier}+f" = "exec export FILE=~; while [ $(ls -a $FILE | grep -c '') -ne 1 ]; do NEW_FILE=$(ls -a $FILE | ${wofiCmd} dmenu); if [ '$NEW_FILE' == '' ]; then exit 1; fi; FILE=$FILE/$NEW_FILE; done; xdg-open $FILE";
          "${modifier}+Shift+Return" = "exec ${wofiCmd} run";
          "${modifier}+space" = "exec ${wofiCmd} run";
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
          "${modifier}+Escape" = "exit";
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

        output = {
          HDMI-A-1 = {
            mode = "1920x1080";
            pos = "1920 0";
            scale = "1";
          };
          DP-1 = {
            mode = "1920x1080";
            pos = "3840 0";
          };
          DP-2 = {
            # bg = "/home/mara/Documents/Syncthing/Desktop-Backgrounds/alena-aenami-lights.jpg fill";
            mode = "1920x1080";
            pos = "0 0";
          };
        };
      };
    };

    programs = {
      # Application Launcher
      wofi = {
        enable = true;
        style = ''
          window {
              margin: 0px;
              background-color: #232136;
              border-radius: 0px;
              border: 2px solid #eb6f92;
              color: #e0def4;
              font-family: 'Monofur Nerd Font';
              font-size: 16px;
          }

          #input {
              margin: 5px;
              border-radius: 0px;
              border: none;
              border-radius: 0px;;
              color: #eb6f92;
              background-color: #393552;
              
          }

          #inner-box {
              margin: 5px;
              border: none;
              background-color: #393552;
              color: #232136;
              border-radius: 0px;
          }

          #outer-box {
              margin: 15px;
              border: none;
              background-color: #232136;
          }

          #scroll {
              margin: 0px;
              border: none;
          }

          #text {
              margin: 5px;
              border: none;
              color: #e0def4;
          } 

          #entry:selected {
              background-color: #eb6f92;
              color: #232136;
              border-radius: 0px;;
              outline: none;
          }

          #entry:selected * {
              background-color: #eb6f92;
              color: #232136;
              border-radius: 0px;;
              outline: none;
          }

        '';
      };

      # Wallpaper
      wpaperd = {
        enable = true;
        settings = {
          default = {
            path = "/home/mara/Documents/Syncthing/Desktop-Backgrounds";
            duration = "30m";
            mode = "center";
          };
        };
      };
    };

    services = {
      mako = {
        enable = true;
        anchor = "top-right";
        borderRadius = 3;
        borderSize = 3;
        font = "Hack Nerd Font 10";
        defaultTimeout = 3000;
        # Theme
        backgroundColor = "#393552";
        borderColor = "#eb6f92";
        progressColor = "over #3e8fb0";
        textColor = "#e0def4";
      };
    };
  };
}
