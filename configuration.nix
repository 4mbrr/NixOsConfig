# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  #services.xserver.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

/*
# KDE ######################################
  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.enable = true;
  services.displayManager.sddm = {
  enable = true;
  theme = "catppuccin-mocha";
  # package = pkgs.kdePackages.sddm;
};
  services.desktopManager.plasma6.enable = true;

  #wayland-only fix for sddm
  services.displayManager.sddm.wayland.enable = true;
##################################################
*/

#GNOME########################################
services = {
	xserver.enable = true;
  xserver.displayManager.gdm.enable = true;
  xserver.desktopManager.gnome.enable = true;
  #xsever.layout = "us";
  #xsever.xkbVariant = "";
	};

environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
  gedit # text editor
]) ++ (with pkgs.gnome; [
  cheese # webcam tool
  gnome-music
  gnome-terminal
  epiphany # web browser
  geary # email reader
  evince # document viewer
  gnome-characters
  totem # video player
  tali # poker game
  iagno # go game
  hitori # sudoku game
  atomix # puzzle game
]);
##############################################

  # Configure keymap in X11
  #services.xserver = {
  #  layout = "us";
  #  xkbVariant = "";
  #};

  # Enable CUPS to print documents.
   #services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amber = {
    isNormalUser = true;
    description = "Amber";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Enable automatic login for the user.
  #services.xserver.displayManager.autoLogin.enable = false;
  #services.xserver.displayManager.autoLogin = false;
  #services.xserver.displayManager.autoLogin.user = "amber";


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  unzip
  wget
  git
  curl
  home-manager
  # applications
  ungoogled-chromium
  vscode
  foot
  obsidian
  discord
  spotify
  neovim
  gimp-with-plugins
  # inkscape-with-extensions
  # protonup-qt
  lutris
  #parsec-bin
  #godot_4
  runelite
  syncthing
  syncthingtray
  #rclone
  #rclone-browser
  gh
  # Programming
  postgresql
  # rustup
  android-tools #Supernote Sideloading
  #zulu  #Omnivore
  #gradle #Omnivore
  # theming and customization
  #spicetify-cli
  #catppuccin-sddm
  ];

  #programs.steam.enable = true;
  #programs.firefox.enable = true;
  #programs.kdeconnect.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?


}
