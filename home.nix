{ config, pkgs, lib, options, ... }:

{
  lib.mkForce = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "amber";
  home.homeDirectory = lib.mkForce "/home/amber";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hyprland
    pkgs.wofi
    pkgs.yt-dlp
    pkgs.youtube-tui
    pkgs.pywal
    pkgs.wl-clipboard
    pkgs.protonvpn-gui
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
     (pkgs.writeShellScriptBin "vgrab" ''
      yt-dlp -o "%(title)s.%(ext)s" -f "bv*[height<=1080]+ba/b[height<=1920]" -P "~/Downloads" $1
     '')
  ];


gtk = {
 enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
};

qt = {
  enable = true;
  platformTheme.name = "gtk";
  style = {
    name = "gtk2";
    package = pkgs.libsForQt5.breeze-qt5;
 };
};

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

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
    
    ".config/foot/foot.ini".source = ./foot/foot.ini;
    ".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
    ".config/nvim/init.lua".source = ./nvim/init.lua;

  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/amber/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "code";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  #programs.home-manager.path = "$HOME/dotfiles";

  programs.git = {
    enable = true;
    userName  = "Amber";
    userEmail = "uhjk5476@gmail.com";
    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
  

  
}
