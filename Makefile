all:
	echo "wtf it didn't work"

install: fuzzy symlink_clean symlink fuzzy vim_install vim_update tmux_install bin_folder
	bash --login

symlink:
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_profile ~/.bash_profile
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/tmux.conf ~/.tmux.conf
	mkdir -p ~/.ssh
	ln -sf `pwd`/ssh_config ~/.ssh/config
	ln -sf `pwd`/Brewfile ~/Brewfile
	ln -sf `pwd`/zshrc ~/.zshrc
	ln -sf `pwd`/dot.osx/skhdrc ~/.skhdrc
	ln -sf `pwd`/dot.osx/yabairc ~/.yabairc

vscode_setup: symlink_vscode vscode_repeat_key_fix

symlink_vscode:
	ln -sf `pwd`/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
	ln -sf `pwd`/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
	ln -sf `pwd`/vscode/code-snippets.code-snippets ~/Library/Application\ Support/Code/User/snippets/code-snippets.code-snippets

vscode_repeat_key_fix:
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
	defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
	defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false    # For VS Codium
	defaults delete -g ApplePressAndHoldEnabled                                      # If necessary, reset global default


symlink_clean:
	rm -f ~/.vimrc ~/.gitconfig  ~/.bashrc ~/.bash_aliases ~/.bash_profile ~/.inputrc ~/.tmux.conf ~/Brewfile ~/.zshrc ~/.skhdrc ~/.yabairc

zsh:
	# TODO Download dependencies

vim:
	# TODO all dependencies, potentially compile yourself?

vim_install:
	./vim_install.sh

vim_update:
	./vim_update.sh

fzf:
	./fzf_setup.sh

packages:
	sudo apt-get install silversearcher-ag # for fast searching
	sudo apt-get install vim-nox # for python binding vim, for vim-plug (plugin manager)
	sudo apt-get install tmux # keep my sessions alive
	sudo apt-get install curl # vim install
	sudo apt-get install tree # nice tool for showing tree of dir

packages.linux:
	# server related

packages.linux.x:
	echo # x related

packages.mac:
	brew bundle install

tmux_install:
	git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

bin_folder:
	mkdir -p ~/bin
	# Don't overwrite anything
	for x in bin/*; do \
		if [ ! -f ~/$$x  ]; then\
			ln -s `pwd`/$$x ~/$$x;\
		fi; \
	done

