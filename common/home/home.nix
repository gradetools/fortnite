{ config, pkgs, self, user, ... }:
{
  home = {
    username = "devin";
    homeDirectory = "/home/devin";
    stateVersion = "23.05";
  };

  programs = {
    home-manager = {
      enable = true;
    };
    zsh = {
      enable = true;
      initExtra = "autoload -Uz vcs_info\nprecmd() { vcs_info }\nzstyle ':vcs_info:git:*' formats '%b '\nsetopt PROMPT_SUBST\nPROMPT='%B%F{green}%n@%m%f%b %B%F{blue}%~%f%b %B%F{red}$vcs_info_msg_0_%f%b> '";
      history = {
        path = "/home/devin/histfile";
      };
      shellAliases = {
        grep = "grep --color";
        ip = "ip --color";
        l = "ls -lah --color";
        ls = "ls -lah --color";
        vim = "nvim";
      };
    };
    waybar = {
      enable = true;
      systemd = {
        enable = true;
      };
      settings = {
        mainBar = {
          layer = "top";
	  position = "top";
	  height = 40;
	  margin-top = 5;
	  margin-left = 5;
	  margin-right = 5;
	  modules-left = [ "image" "hyprland/workspaces" "tray" ];
	  modules-center = [ "clock" "custom/weather" "mpris" ];
	  modules-right = [ "hyprland/language" "custom/notification" "wireplumber" "battery" "network" "custom/power" ];
	  "hyprland/language" = {
	    format = "{}";
	  };
	  "mpris" = {
	    format = "{player_icon} {title} - {artist}";
	    format-paused = "{status_icon} {title} - {artist}";
	    player-icons = {
	      "default" = " ";
	    };
	    status-icons = {
	      "paused" = "⏸";
	    };
          };
	  "image" = {
	    path = "/home/devin/.config/waybar/images/nixos_dark.svg";
	  };
	  "custom/weather" = {
	    format = " {}";
	    tooltip = "true";
	    interval = 3600;
	    exec = "/home/devin/.config/waybar/scripts/waybar-wttr.py";
	    return-type = "json";
	  };
	  "hyprland/workspaces" = {
	    disable-scroll = "true";
	    all-outputs = "true";
	    on-click = "activate";
	    format = "{}";
	  };
	  "tray" = {
	    icon-size = 13;
	    spacing = 10;
	  };
	  "battery" = {
	    bat = "BAT0";
	    interval = 1;
	    states = {
	      "warning" = 20;
	      "critical" = 10;
	    };
	    format = "{icon} {capacity}%";
	    format-icons = [ "󰁻" "󰁽" "󰁿" "󰂁" "󰁹" ];
	  };
	  "clock" = {
	    format = "{:   %I:%M %p     %Y-%m-%d}";
	    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	  };
	  "network" = {
	    format-wifi = "󰤨  {essid} ({signalStrength}%)";
	    tooltip-format-wifi = "{ifname} via {gwaddr}";
	    format-ethernet = "󰈀   Connected";
	    tooltip-format = "{ifname} via {gwaddr}";
	    format-linked = "{ifname} (No IP)";
	    format-disconnected = "⚠  Disconnected";
	    format-alt = "{ifname}: {ipaddr}/{cidr}";
	  };
          "wireplumber" = {
	    format = "{icon}  {volume}%";
	    tooltip = "true";
	    tooltip-format = "{volume}";
	    format-muted = "  Muted";
	    on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
	    format-icons = [ "" "" ""];
	  };
	  "custom/power" = {
	    format = "󰩈";
	    on-click = "wlogout";
	  };
        };
      };
      style = ''
        @define-color bg0   #211a17;
        @define-color bg1   #362f2b;
        @define-color tip   #221e1b;
        @define-color accent #e79cbf;
        @define-color text #ffffff;
        * {
            border: none;
            border-radius: 0;
            font-family: Torus SemiBold;
            font-weight: bold;
            font-size: 14px;
            min-height: 0px;
          }

        #waybar {
          padding: 20px;
          padding-left: 10px;
          padding-right: 10px;
          border-radius: 10px;
          background-color: rgba(30,33,40,0.7);
        }

        #window {
          background: transparent;
          color: #cdd6f4;
          margin-top: 6px;
          padding-left: 10px;
          padding-right: 10px;
          border-radius: 10px;
        }

	#workspaces button {
          padding: 5px;
          color: #ffffff;
          margin: 3px;
          border-radius: 10px;
	}

	#workspaces button.active {
          background: @accent;
          color: @bg0;
         }

	 #workspaces button:hover {
           background: @bg0;
           color: @bg1;
         }

	 #tooltip {
           background: @tip;
           border-radius: 10px;
           border: 3px solid @bg1;
         }

	 #language, #clock, #battery, #wireplumber, #network, #tray, #custom-weather, #custom-notification, #workspaces, #mpris {
           background: @bg1;
           padding: 0px 10px;
           margin: 7px 0px;
           border-radius: 5px;
         }

	 #image, #custom-power {
           background: @accent;
           color: @bg1;
           padding-left: 10px;
           padding-right: 10px;
           margin: 7px 0px;
           border-radius: 5px;
           font-size: 18px;
         }

	 #tray {
	   margin-left: 5px;
	   padding-left: 10px;
	   padding-right: 10px;
	   transition: none;
         }

	 #workspaces {
           background: @bg1;
           padding-right: 5px;
           padding-left: 5px;
           margin-left: 5px;
         }

	 #clock {
           color: @text;
           border-radius: 5px;
           margin-left: 5px;
         }

	 #mpris {
           color: @text;
           border-radius: 5px;
           margin-left: 5px;
         }

	 #custom-weather {
           color: @text;
           border-radius: 5px;
           margin-left: 5px;
         }

	 #image {
           margin-left: 7px;
         }

	 #custom-power {
           margin-right: 7px;
         }

	 #network {
           color: @text;
           margin-right: 5px;
         }

	 #language, #workspaces, #custom-notification, #wireplumber, #battery, #mpris {
           color: @text;
           margin-right: 5px;
         }
      '';
    };
  };
}
