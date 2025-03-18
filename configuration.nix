{ config, pkgs, ... }:

{
    imports =
        [ 
            ./hardware-configuration.nix
        ];

  # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; 
    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";

    #services.xserver.enable = true;
    #services.xserver.libinput.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;

    services = {
        xserver.enable = true;
        xserver.displayManager.gdm.enable = true;
        xserver.desktopManager.gnome.enable = true;
        syncthing.enable = true;
    };

    environment.gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
        gedit
    ]);

  # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.amber = {
        isNormalUser = true;
        description = "Amber";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
      };


      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
      unzip
      wget
      git
      git-credential-manager
      curl
      tamsyn
      kitty
      wpgtk
      flatpak
      # applications
      river
      ungoogled-chromium
      vscode
      foot
      ghostty
      tmux
      mpv
      vlc
      obsidian
      discord
      spotify
      syncthing
      neovim
      gimp-with-plugins
      anki
      impression
      menulibre #menu editor
      lutris
      syncthing
      gh
      android-tools #Supernote Sideloading
      libreoffice-qt6-fresh
      hunspell #spellcheck
      themechanger
      ];

      programs.steam.enable = true;
      programs.kdeconnect.enable = true;

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
