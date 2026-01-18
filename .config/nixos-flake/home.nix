{ config, pkgs, ... }:

let
	dotfiles = "${config.home.homeDirectory}/dotfiles/.config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = { qtile = "qtile"; };
in
{
	home.username = "gamma";
	home.homeDirectory = "/home/gamma";
	home.stateVersion = "25.11";


	home.packages = with pkgs; [ eza bat ];


	xdg.configFile = builtins.mapAttrs (name: subpath: {
		source = create_symlink "${dotfiles}/${subpath}";
		recursive = true;
	}) configs;

	xdg.configFile."katerc" = {
		source = create_symlink "${dotfiles}/katerc";
		recursive = true;
	};

	xdg.configFile."katekeys" = {
		source = create_symlink "${dotfiles}/katekeys.shortcut";
		recursive = true;
	};


	programs = {

		git = {
			enable = true;
			settings = {
				user.Name = "Guilhermatheus";
				user.Email = "guilhermatheusdp@gmail.com";
				init = { defaultBranch = "main"; };
			};
		};

		zsh = {
			enable = true;
			shellAliases = {
				q = "exit";
				rm = "rm -riv";
				cp = "cp -iv";
				mkdir = "mkdir -vp";
				cat = "bat";
				ls = "eza -a";
				tree = "eza --tree";
				ln = "ln -s";
				rebuild = "doas nixos-rebuild switch";
			};

			initContent = ''
				function cd {
				builtin cd "$@" && exa -a
				}
			'';
		};

		alacritty = {
			enable = true;
			theme = "moonfly";
			settings = {
				font = {
					normal = {
						family = "Terminus";
						style = "bold";
					};
					size = 12;
				};
			};
		};

		rofi = {
			enable = true;
			theme = "Monokai";
			font = "Terminus 12";
		};

		fastfetch.enable = true;

	};
}
