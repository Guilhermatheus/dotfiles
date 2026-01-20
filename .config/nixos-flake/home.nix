{ config, pkgs, ... }:

let
	dotfiles = "${config.home.homeDirectory}/dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		alacritty = "alacritty";
		katerc = "katerc";
		"kate.shortcuts" = "kate.shortcuts";
		"mimeapps.list" = "mimeapps.list";
		nvim = "nvim";
		qtile = "qtile";
		rofi = "rofi";
		zsh = "zsh";
	};
in
{


	home.username = "gamma";
	home.homeDirectory = "/home/gamma";
	home.stateVersion = "25.11";


	xdg.configFile = builtins.mapAttrs (name: subpath: {
		source = create_symlink "${dotfiles}/${subpath}";
		recursive = true;
	}) configs;


	programs = {

		git = {
			enable = true;
			settings = {
				user.Name = "Guilhermatheus";
				user.Email = "guilhermatheusdp@gmail.com";
				init.defaultBranch = "main";
				alias = {
					commit = "commit -m";
					files = "ls-tree -r main --name-only";
					last = "log -1 HEAD";
					push = "push -u";
					undo = "reset HEAD~";
					unstage = "reset HEAD --";
					update = "!f() { message=\"$1\"; shift; if [ -z \"$1\" ]; then git add -u; else git add \"$@\"; fi; git commit -m \"$message\"; }; f";
				};
			};
		};

# 		zsh = {
# 			enable = true;
# 			shellAliases.rebuild = "doas nixos-rebuild switch";
# 			};
# 		};

		fastfetch.enable = true;

	};
}
