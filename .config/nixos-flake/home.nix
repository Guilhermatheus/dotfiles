{ config, pkgs, ... }:

let
	dotfiles = "${config.home.homeDirectory}/dotfiles/.config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = { qtile = "qtile"; alacritty = "alacritty"; zsh = "zsh"; rofi = "rofi"; };
in
{


	home.username = "gamma";
	home.homeDirectory = "/home/gamma";
	home.stateVersion = "25.11";


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
				init.defaultBranch = "main";
				alias = {
					commit = "commit -m";
					push = "push -u";
					undo = "reset HEAD~";
					unstage = "reset HEAD --";
					last = "log -1 HEAD";
					update = "\"!f() { message=\"$1\"; shift; if [ -z \"$1\" ]; then git add -u; else git add \"$@\"; fi; git commit -m \"$message\"; }; f\"";
					files = "ls-tree -r main --name-only";
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
