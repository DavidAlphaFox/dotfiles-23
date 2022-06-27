export PATH := ${HOME}/.cargo/bin:/bin:/usr/local/bin:/usr/local/sbin
export GOPATH := ${HOME}


.DEFAULT_GOAL := help
.PHONY: allinstall nextinstall

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

yay: ## Install yay
	sudo pacman -S --needed --noconfirm yay

install: ## Install arch linux packages using yay
	cat ${PWD}/pkglist.txt | xargs -L 1 yay -S --needed --noconfirm

cli-tools: ## Add cli tools to local bin
	ln -vsf ${PWD}/commands/* ${HOME}/.local/bin/

init: ## Initial deploy dotfiles
	for item in zshrc zshfunc zimrc myclirc tmux.conf gtkrc-2.0 noderc pyrc tridactylrc; do
		ln -vsf {${PWD},${HOME}}/.$$item
	done
	# ln -vsf ${PWD}/config/* ${HOME}/.config/

wayland:
	sudo ln -vsf ${PWD}/$@/* /usr/local/bin/
	ln -vsf ${PWD}/etc/greetd /etc/
	yay -S --needed --noconfirm greetd-tuigreet

newm: ## config i3
	yay -S --needed --noconfirm $@-git waybar

swaywm: ## config sway
	ln -vsf ${PWD}/$@/* ${HOME}/.config/
	yay -S --needed --noconfirm sworkstyle \
		waybar eww-git clipman gestures

zsh: ## install oh my zsh
	yay -S --needed --noconfirm zh-autosuggestions \
		zsh-completions zsh-history-substring-search \
		zsh-sintax-highlighting zsh-fast-sintax-highlighting
	chsh -s $(which zsh)

Code: ## Install and configure VScode
	mkdir -p ${HOME}/.config/$@/
	ln -vsf ${PWD}/$@/* ${HOME}/.config/$@/
	yay -S --needed --noconfirm visual-studio-code-bin
	bash ${PWD}/$@/my_vscode_extensions.sh
	sudo npm install -g vsce
	cd ${PWD}/$@/miramare/ && vsce package .
	code --install-extension ${PWD}/$@/miramare/miramare-0.0.2.vsix

dnscrypt-proxy:
	ln -vsf ${PWD}/etc/$@/* /etc/$@/
	ln -vsf ${PWD}/etc/resolv.conf /etc/
	yay -S --needed --noconfirm $@

nftables:
	ln -vsf ${PWD}/etc/$@.conf /etc/
	ln -vsf ${PWD}/etc/$@-docker.conf /etc/
	yay -S --needed --noconfirm $@

docker: ## Docker initial setup
	sudo pacman -S $@-compose
	sudo usermod -aG $@ ${USER}

docker_image: docker
	docker build -t dotfiles ${PWD}

test: docker_image ## Test this Makefile with docker
	docker run -it --name make$@ -d dotfiles:latest /bin/bash
	for target in install init; do
		docker exec -it make$@ sh -c "cd ${PWD}; make $${target}"

testpath: ## Echo PATH
	PATH=$$PATH
	@echo $$PATH
	GOPATH=$$GOPATH
	@echo $$GOPATH

allinstall: yay install init cli-tools zsh

nextinstall: docker
