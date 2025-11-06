{ config, lib, pkgs, ... }:

{
  home.username = "soham";
  home.homeDirectory = "/home/soham";
  home.stateVersion = "25.05";
  programs.starship = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "sohamch08";
    userEmail = "sohamchatterjee999@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.neovim = {
    enable = true;
    extraConfig = "set relativenumber\n set clipboard=unnamedplus";
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "eza -Al --sort=name --group-directories-first --icons --git --git-repos";
      lt = "eza -a --icons --tree --group-directories-first --sort=name --git";
      llt = "eza -al --icons --tree --group-directories-first --sort=name --git";
      hms = "home-manager switch -b backup --flake $HOME/nix-dotfiles/; source $HOME/.bashrc";
      nrs = "sudo nixos-rebuild switch --flake $HOME/nix-dotfiles/";
    };
    # initExtra = "eval '$(starship init bash)'";
  };
  programs.notmuch = {
    enable = true;
    extraConfig = {
      database.path = "/home/soham/.local/share/email/tifr";
      user = {
        name = "Soham Chatterjee";
	primary_email = "soham.chatterjee@tifr.res.in";
      };
    };
    new.tags = [
        "unread"
	"inbox"
	"tifr"
    ];
    search.excludeTags = [
      "deleted"
      "spam"
      "trash"
    ];
  };
  # programs.mbsync.enable = true;
  programs.msmtp.enable = true;
	#  accounts.email = {
	#    maildirBasePath = "/home/soham/.local/share/email";
	#    accounts.tifr = {
	#      primary = true;
	#      address = "soham.chatterjee@tifr.res.in";
	#      userName = "soham.chatterjee@tifr.res.in";
	#      realName = "Soham Chatterjee";
	#      passwordCommand = "cat /home/soham/mailpass.txt";
	#      signature = {
	#        text = "
	#   ---
	#   Soham Chatterjee
	# ";
	# showSignature = "append";
	#      };
	#      folders = {
	#        inbox = "INBOX";
	# sent = "Sent";
	# trash = "Trash";
	# drafts = "Drafts";
	#      };
	#      imap = {
	#        host = "tifr.res.in";
	# port = 993;
	# tls = {
	#   enable = true;
	#   certificatesFile = "/etc/ssl/certs/ca-certificates.crt";
	# };
	#      };
	#      smtp = {
	#        host = "tifr.res.in";
	# port = "25";
	# tls = {
	#   enable = true;
	#   useStartTls = true;
	#   certificatesFile = "/etc/ssl/certs/ca-certificates.crt";
	# };
	#      };
	#      mbsync.enable = true;
	#      msmtp.enable = true;
	#    };
	#  };
  # programs.neomutt = {
  #   enable = true;
  #   extraConfig = {
  #     folder = "imaps://soham.chatterjee@tifr.res.in@tifr.res.in:993";
  #     smtp_url = "smtp://soham.chatterjee@tifr.res.in@tifr.res.in:25";
  #     from = "soham.chatterjee@tifr.res.in";
  #     realname = "Soham Chatterjee";
  #     spoolfile = "+INBOX";
  #     record = "+Sent";
  #     trash = "+Trash";
  #     postponed = "+Drafts";
  #
  #     # IMAP settings to prevent errors
  #     imap_passive = "yes";
  #     imap_check_subscribed = "no";
  #
  #     # Define mailboxes directly in settings
  #     mailboxes = "+INBOX +Sent +Trash +Drafts +Junk";
  #   };
  #   # Sorting - NEWEST FIRST (latest emails at top)
  #   sort = "date-received";
  # };
  nixpkgs.config = {
    # This allows all unfree packages for this Home Manager configuration
    allowUnfree = true;
  };
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
     pkgs.hello
     # pkgs.eza
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
  #  /etc/profiles/per-user/soham/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    PATH = "$HOME/.emacs.d/bin/:$PATH";
    DOOMDIR = "$HOME/.config/doom";
    DOOMLOCALDIR = "$HOME/.emacs.d/.local";
    NOTMUCH_CONFIG = "/home/soham/.config/notmuch/default/config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
