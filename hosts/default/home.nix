{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "eagle";
  home.homeDirectory = "/home/eagle";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
	pkgs.fastfetchMinimal
	pkgs.bat
	pkgs.nixfmt-tree
	pkgs.swaybg
	pkgs.ripgrep
	pkgs.fzf
	pkgs.fd
	
	pkgs.gnomeExtensions.vitals
	
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  programs.wezterm = {
  	enable = true;
  	extraConfig = "
    -- Pull in the wezterm API
    local wezterm = require('wezterm')
    
    -- This will hold the configuration.
    local config = wezterm.config_builder()
    
    -- This is where you actually apply your config choices
    
    -- my coolnight colorscheme
    config.color_scheme = 's3r0 modified (terminal.sexy)'
    -- config.color_scheme = 'SeaShells'
    
    config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
    config.font_size = 12
    
    config.default_prog = { 'zsh' }
    
     config.window_background_opacity = 0.975
    
    config.enable_scroll_bar = true
    
    config.window_frame = {
      -- The font used in the tab bar.
      -- Roboto Bold is the default; this font is bundled
      -- with wezterm.
      -- Whatever font is selected here, it will have the
      -- main font setting appended to it to pick up any
      -- fallback fonts you may have used there.
      font = wezterm.font { family = 'Roboto', weight = 'Bold' },
    
      -- The size of the font in the tab bar.
      -- Default to 10.0 on Windows but 12.0 on other systems
      font_size = 12.0,
    
      -- The overall background color of the tab bar when
      -- the window is focused
      active_titlebar_bg = '#333333',
    
      -- The overall background color of the tab bar when
      -- the window is not focused
      inactive_titlebar_bg = '#333333',
    }
    
    config.colors = {
      tab_bar = {
        -- The color of the inactive tab bar edge/divider
        inactive_tab_edge = '#575757',
      },
    }
    
    -- and finally, return the configuration to wezterm
    return config
    
  	";
  };
  
  programs.zoxide.enable = true;
  programs.zsh =  {
    enable = true;
	enableCompletion = true;
	autosuggestion.enable = true;
	syntaxHighlighting.enable = true;
 	shellAliases = {
	   ll = "ls -l";
	   update = "sudo nixos-rebuild switch";
	   cat = "bat";
	};
	history.size = 10000;
	oh-my-zsh = {
		enable = true;
		plugins = ["git"];
		theme = "eastwood";
	};
  };

  
  home.shell.enableShellIntegration = true;

  #Gnome Extensions
  dconf = {
    enable = true;
    settings = {
    	"org/gnome/shell" = {
    	  disable-user-extensions = false;
    	  disabled-extensions = "disabled";
    	  enabled-extensions = [
			"Vitals@CoreCoding.com"
    	  ];
    	};
    	"org/gnome/shell/extensions/vitals" = {
    		  hot-sensors = ["_processor_usage_" "_memory_usage_"];
    		  position-in-panel = 2;
    		  use-higher-precision = false;
    		  alphabetize = true;
    		  hide-zeros = false;
    		  show-voltage = false;
    		  show-network = false;
    		  show-storage = false;
    		  show-battery = false;
    		  menu-centered = true;
    		  icon-style = 1;
    		  
    		  
    	};
    	"org/gnome/settings-daemon/plugins/media-keys" = {
    	  next = [ "<Shift><Control>n" ];
    	  previous = [ "<Shift><Control>p" ];
    	  play = [ "<Shift><Control>space" ];
    	  custom-keybindings = [
    	    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    	   ];
    	};
    	"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    		  name = "Wezterm";
    		  command = "wezterm";
    		  binding = "<Super>Return";
    	};
    };
  };
  
  home.sessionVariables = {
    EDITOR = "micro";
	GSK_RENDERER = "cairo";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
