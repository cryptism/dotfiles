# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  system.autoUpgrade.enable = true;

  networking.hostName = "darkpaths"; # Define your hostname.
  networking.hostId = "28974539";
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "uk";
     defaultLocale = "en_GB.UTF-8";
  };

  services.mingetty.greetingLine = ''DON'T BE AFRAID TO LET YOUR BODY DIE\n\n\r\r\t${config.system.nixosVersion} (\m) - \l'';

  environment.systemPackages = with pkgs; [
     wget
     iptables nmap tcpdump
     tree
     zsh
     xcompmgr
     xfontsel
     xlsfonts
     udevil
     vim
     git
     binutils

     (haskellPackages.ghcWithHoogle (self: with self; [
       cabal-install
       ghc-mod
       xmonad xmonad-contrib xmonad-extras
       xmobar
     ]))

     # Applications
     emacs
     vlc
     chromium
     nodejs
     vscode
     xscreensaver
     rxvt_unicode-with-plugins urxvt_tabbedex
     sakura
     hyper
     corebird
  ];

  nixpkgs.config.allowUnfree = true;


  fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
          source-sans-pro
          source-serif-pro
          fira
          fira-code
          fira-mono
          hasklig
          inconsolata
          ubuntu_font_family
          unifont
	  font-awesome-ttf
          liberation_ttf
          freefont_ttf
          source-code-pro          
      ];
  };

  virtualisation.docker.enable = true;

  services.openssh.enable = true;
  programs.ssh.startAgent = true;
  security.sudo.wheelNeedsPassword = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "gb";
    xkbOptions = "eurosign:e";
    desktopManager = { 
     xterm.enable = false;
     default = "none";
    };
    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
      default = "xmonad";
    };
    config = ''
      Section "Extensions"
           Option "Composite" "enable"
      EndSection
    '';
    displayManager.slim = {
      enable = true;
      defaultUser = "joe";
    };
  };

  users.extraUsers = {
    joe = {
      isNormalUser = true;
      home = "/home/joe";
      extraGroups = ["wheel" "video" "docker"];
      shell = "${pkgs.zsh}/bin/zsh";
    };
  };
}
