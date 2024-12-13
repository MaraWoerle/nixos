{ config, pkgs, lib, osConfig, ... }:

let
  modifier = config.wayland.windowManager.sway.config.modifier;
  wofiCmd = "wofi -O alphabetical -S";
  lockCommand = "swaylock -i /home/mara/Documents/Syncthing/Desktop-Backgrounds/louis-coyle-inspired-lakeside.png";
  scrnCmd = "grimblast copysave area";
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
          { command = "xset -dpms"; }
          { command = "xidlehook --not-when-fullscreen --not-when-audio --timer 300 'brightnessctl set 50%' 'brightnessctl set 100%' --timer 60 'brightnessctl set 100%; ${lockCommand}' '' --timer 60 'brightnessctl set 50%' 'brightnessctl set 100%'"; }
          { command = "wpaperd -d"; }
        ];

        keybindings = {
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
          "Shift+Print" = "exec ${scrnCmd}";
          "Mod4+Shift+s" = "exec ${scrnCmd}";
          # Fullscreen
          "${modifier}+Shift+f" = "fullscreen toggle";
          # start Terminal
          "${modifier}+Return" = "exec kitty";
          # Kill Window
          "${modifier}+Shift+q" = "kill";
          # File Explorer
          "${modifier}+a" = "exec nemo";
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
          "${modifier}+Shift+l" = "exec --no-startup-id ${lockCommand}";
          "Mod4+l" = "exec --no-startup-id ${lockCommand}";
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

      # Lockscreen
      swaylock = {
        enable = true;
        settings = {
          # Background color
          color="#232136";

          # Layout text colors
          layout-bg-color="#00000000";
          layout-border-color="#00000000";
          layout-text-color="#e0def4";

          # Text color
          text-color="#3e8fb0";
          text-clear-color="#9ccfd8";
          text-caps-lock-color="#f6c177";
          text-ver-color="#c4a7e7";
          text-wrong-color="#eb6f92";

          # Highlight segments
          bs-hl-color="#23213666";
          key-hl-color="#3e8fb0";
          caps-lock-bs-hl-color="#23213666";
          caps-lock-key-hl-color="#f6c177";

          # Highlight segments separator
          separator-color="#00000000";

          # Inside of the indicator
          inside-color="#3e8fb055";
          inside-clear-color="#9ccfd855";
          inside-caps-lock-color="#f6c17755";
          inside-ver-color="#c4a7e755";
          inside-wrong-color="#eb6f9255";

          # Line between the inside and ring
          line-color="#3e8fb011";
          line-clear-color="#9ccfd811";
          line-caps-lock-color="#f6c17711";
          line-ver-color="#c4a7e711";
          line-wrong-color="#eb6f9211";

          # Indicator ring
          ring-color="#3e8fb0aa";
          ring-clear-color="#9ccfd8aa";
          ring-caps-lock-color="#f6c177aa";
          ring-ver-color="#c4a7e7aa";
          ring-wrong-color="#eb6f92aa";
        };
      };
    };

    services = {
      # Notification Manager
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

      # Lock Manager
      screen-locker = {
        enable = true;
        lockCmd = lockCommand;
      };
    };
  };
}
