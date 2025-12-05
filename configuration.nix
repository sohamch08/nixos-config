# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "turing"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.soham = {
    isNormalUser = true;
    description = "Soham";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      eza
      arandr
      kdePackages.kate
      thunderbird
      vscode
      spotify
      brave
      telegram-desktop
      zoom-us
      pass
      bitwarden
      fzf
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.starship.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  fonts.packages = (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)) ++ [
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-color-emoji
    pkgs.liberation_ttf
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.mplus-outline-fonts.githubRelease
    pkgs.dina-font
    pkgs.proggyfonts
  ];
  environment.systemPackages = with pkgs; [
    # vim
    wget
    git
    # neovim
    emacs
    ripgrep
    coreutils
    fd
    clang
    unzip
    xclip
    lynx
    notmuch
    isync
    msmtp
    abook
    urlscan
    emacsPackages.pdf-tools
    cmake
    tree
    neomutt
    python3
    alacritty
    texliveFull
    openssl
    lbdb
    bat
    btop
    gnumake
    libtool
    gnupg
    fastfetch
    pfetch
    pandoc
    shfmt
    mpv
    lsof
    starship
    mu
    killall
    age
    kdePackages.kdeconnect-kde
  ] ++ [(pkgs.neovim.override {
    withClipboard = true;
  })]

  # programs.msmtp = {
  #   enable = true;
  #   setSendmail = true; # set the system sendmail to msmtp's
  #   accounts = {
  #     default = {
  #       host = "tifr.res.in";
  #       port = 25;
  #       auth = true;
  #       tls = true;
  #       tls_starttls = true;
  #       from = "soham.chatterjee@tifr.res.in";
  #       user = "soham.chatterjee@tifr.res.in";
  #       logfile = "~/.config/msmtp/msmtp.log";
  #     };
  #   };
  # };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 5432 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      # AllowUsers = [ "myUser" ];
    };
  };

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
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
