export PATH := ${HOME}/.cargo/bin:/bin:/usr/local/bin:/usr/local/sbin
export GOPATH := ${HOME}

yay: ## Install yay
	sudo pacman -S --needed --noconfirm yay

install: ## Install arch linux packages using yay
	cat ${PWD}/pkglist.txt | xargs -L 1 yay -S --needed --noconfirm

cli-tools: ## Add cli tools to local bin
	ln -vsf ${PWD}/commands/* ${HOME}/.local/bin/

init: ## Initial deploy dotfiles
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/.zsh_history ${HOME}/.zsh_history
	ln -vsf ${PWD}/.myclirc ${HOME}/.myclirc
	ln -vsf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
	ln -vsf ${PWD}/.gitconfig ${HOME}/.gitconfig
	ln -vsf ${PWD}/.pyrc ${HOME}/.pyrc
	ln -vsf ${PWD}/.noderc ${HOME}/.noderc
	ln -vsf ${PWD}/config/* ${HOME}/.config/

i3wm: ## config i3
	ln -vsf ${PWD}/i3wm/* ${HOME}/.config/
	yay -S --needed --noconfirm corrupter-bin \
		flameshot insomnia-git i3wsr i3status-rust

wayland:
	sudo ln -vsf ${PWD}/waylan/* /usr/local/bin/

swaywm: ## config sway
	ln -vsf ${PWD}/swaywm/* ${HOME}/.config/
	yay -S --needed --noconfirm sworkstyle \
		nwg-dock waybar eww-git clipman

zsh: ## install oh my zsh
	yay -S --needed --noconfirm oh-my-zsh-git zh-autosuggestions \
		zsh-completions zsh-history-substring-search \
		zsh-sintax-highlighting
	chsh -s $(which zsh)

code: ## Install and configure VScode
	yay -S --needed --noconfirm visual-studio-code-bin
	mkdir -p ${HOME}/.config/Code/
	ln -vsf ${PWD}/Code/* ${HOME}/.config/Code/
	bash ${PWD}/Code/my_vscode_extensions.sh
	sudo npm install -g vsce
	cd ${PWD}/Code/miramare/ && vsce package .
	code --install-extension ${PWD}/Code/miramare/miramare-0.0.2.vsix

rustinstall: ## Install rust and rust language server
	sudo pacman -S rustup
	rustup default stable
	rustup component add rls rust-analysis rust-src

docker: ## Docker initial setup
	sudo pacman -S docker
	sudo usermod -aG docker ${USER}

maria-db: ## Mariadb initial setup
	sudo ln -vsf ${PWD}/etc/sysctl.d/40-max-user-watches.conf /etc/sysctl.d/40-max-user-watches.conf
	sudo pacman -S --noconfirm mariadb mariadb-clients mycli
	sudo ln -vsf ${PWD}/etc/my.cnf /etc/my.cnf
	sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
	sudo systemctl start mariadb.service
	sudo mysql -u root < ${PWD}/mariadb/init.sql
	mysql_secure_installation
	mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql

testpath: ## Echo PATH
	PATH=$$PATH
	@echo $$PATH
	GOPATH=$$GOPATH
	@echo $$GOPATH

allinstall: yay install init cli-tools zsh

nextinstall: rustinstall maria-db mongodb docker docker-compose

.PHONY: allinstall nextinstall ideinstall

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
