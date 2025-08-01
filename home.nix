{ config, pkgs, lib, options, inputs, ... }:

{
  home.username = "amber";
  home.homeDirectory = "/home/amber";
  home.stateVersion = "23.11"; # Please read the comment before changing.



  home.packages = with pkgs; [
#    hyprland
    wofi
    yt-dlp
    youtube-tui
    pywal
    wl-clipboard
    protonvpn-gui
    (writeShellScriptBin "vgrab" ''
      yt-dlp -o "%(title)s.%(ext)s" -f "bv*[height<=1080]+ba/b[height<=1920]" -P "~/Downloads" $1
     '')
  ];


#    gtk = {
#     enable = true;
#        theme = {
#          name = "rose-pine";
#          package = pkgs.rose-pine-gtk-theme;
#        };
#    };
#
#    qt = {
#        enable = true;
#        platformTheme.name = "gtk2";
#        style = {
#        name = "rose-pine";
#        package = pkgs.rose-pine-gtk-theme;
#        };
#    };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  home.file = {
    ".config/foot/foot.ini".source = ./foot/foot.ini;
    ".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
    ".config/nvim/init.lua".source = ./nvim/init.lua;
    ".config/ghostty/config".source = ./ghostty/config;
    ".config/nvim/lua/plugins/rose-pine.lua".source = ./nvim/lua/plugins/rose-pine.lua;
    ".config/tmux/tmux.conf".source = ./tmux/tmux.conf;
    ".config/nvim/lua/config/lazy.lua".source = ./nvim/lua/config/lazy.lua;
    ".config/nvim/lua/plugins/vim-tmux-navigator.lua".source = ./nvim/lua/plugins/vim-tmux-navigator.lua;
    ".config/nvim/lua/plugins/telescope.lua".source = ./nvim/lua/plugins/telescope.lua;
    ".config/nvim/lua/plugins/lsp.lua".source = ./nvim/lua/plugins/lsp.lua;
    "/usr/share/wayland-sessions/hyprland.desktop".source = ./desktopentry/hyprland.desktop;
    ".config/quickshell/testbar/shell.qml".source = ./quickshell/testbar/shell.qml;
    ".config/waybar/config".source = ./waybar/config;
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
        EDITOR = "nvim";
    };

  # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    programs.git = {
        enable = true;
        userName  = "Amber";
        userEmail = "uhjk5476@gmail.com";
  };

}
