{ config, pkgs, ... }: {

	imports = [ ./hardware-configuration.nix ];


	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;


	networking.hostName = "nixos";
	networking.networkmanager.enable = true;


	time.timeZone = "America/Sao_Paulo";


	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "pt_BR.UTF-8";
		LC_IDENTIFICATION = "pt_BR.UTF-8";
		LC_MEASUREMENT = "pt_BR.UTF-8";
		LC_MONETARY = "pt_BR.UTF-8";
		LC_NAME = "pt_BR.UTF-8";
		LC_NUMERIC = "pt_BR.UTF-8";
		LC_PAPER = "pt_BR.UTF-8";
		LC_TELEPHONE = "pt_BR.UTF-8";
		LC_TIME = "pt_BR.UTF-8";
	};


	services.xserver = {
		enable = true;

		autoRepeatDelay = 200;
		autoRepeatInterval = 35;

		xkb = {
			layout = "br";
			variant = "nodeadkeys";
		};

		windowManager.qtile.enable = true;
	};
	#services.displayManager.lemurs.enable = true;
	services.displayManager.sddm.enable = true;

	console.useXkbConfig = true;


	users.users.gamma = {
		isNormalUser = true;
		description = "gamma";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};


	environment.systemPackages = with pkgs; [

		alacritty
		pcmanfm
		kdePackages.kate kdePackages.konsole
		libreoffice
		librewolf
		discord
		godot
		rofi

		btop eza

	];

	programs = {
		zsh.enable = true;
		bat.enable = true;
		git.enable = true;

		nano.enable = false;
		neovim.enable = true;

		obs-studio.enable = true;
	};

	security = {
		sudo.enable = false;
		doas = {
			enable = true;
			extraRules = [{
				users = [ "gamma" ];
				keepEnv = true;
				persist = true;
			}];
		};
		protectKernelImage = true;
	};

	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	services.openssh = {
		enable = true;
		ports = [ 5432 ];
		settings = {
			PasswordAuthentication = false;
			KbdInteractiveAuthentication = false;
			PermitRootLogin = "no";
			AllowUsers = [ "gamma" ];
		};
	};


	services.zerotierone.enable = true;


	fonts = {
		packages = with pkgs; [ openmoji-color terminus_font ];

		fontconfig = {
			hinting.autohint = true;
			defaultFonts = {
				emoji = [ "OpenMoji Color" ];
			};
		};
	};


	environment.defaultPackages = [ ];

	environment.variables = {
		EDITOR = "kate -b";
		TERMINAL = "alacritty";
		ZDOTDIR = "";
	};


	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.11";

}
