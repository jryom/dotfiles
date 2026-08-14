.PHONY: default install dotbot brew brew-personal brew-update gh gh-update mise mise-update pnpm pnpm-update misc fisher fish-globals system-preferences gatekeeper shell uv uv-update podman

default: install

install: homebrew gatekeeper system-preferences mise brew podman uv dotbot fish-globals fisher pnpm misc gh

brew:
	brew bundle install --file="$(CURDIR)/configs/brewfile" --force

brew-personal:
	brew bundle install --file="$(CURDIR)/configs/brewfile_personal" --force

dotbot:
	@fish -i -c 'sudo dotbot --config-file "$(CURDIR)/configs/dotbot.yaml" --base-directory "$(CURDIR)" --quiet; and \
	set dotfiles_private "$$HOME/Documents/dotfiles-private"; and \
	brctl download "$$dotfiles_private"; and \
	sudo dotbot --config-file "$$dotfiles_private/configs/dotbot.yaml" --base-directory "$$dotfiles_private" --quiet'

fisher:
	@fish -i -c 'fisher update'

mise-update:
	mise upgrade --yes
	mise prune --yes

pnpm-update:
	pnpm update --global --latest --yes

brew-update:
	brew upgrade

gh-update:
	gh extension upgrade --all

fish-globals:
	@fish -i -c 'source "$(CURDIR)/configs/fish_globals.fish"'

gatekeeper:
	if spctl --status >/dev/null; then sudo spctl --master-disable || exit 0; fi

gh:
	while IFS= read -r line; do \
		echo $$line; \
		gh extension install --force "$$line"; \
	done < "$(CURDIR)/configs/gh_extensions"

homebrew:
	if ! command -v brew >/dev/null; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	export PATH="/opt/homebrew/bin:$$PATH"

podman:
	sudo "$$(brew --prefix)"/Cellar/podman/$$(brew info podman --json | jq -r '.[0].installed[0].version')/bin/podman-mac-helper install
	ln -sf "$$(which podman)" "$$(brew --prefix)"/bin/docker
	podman machine init 2>/dev/null || true
	podman machine start 2>/dev/null || true

misc:
	echo y | "$$(brew --prefix)"/opt/fzf/install --no-bash --no-zsh

mise:
	mkdir -p "$$HOME/.config/mise"
	ln -f "$(CURDIR)/home/config/mise/config.toml" "$$HOME/.config/mise/config.toml"
	brew install mise
	mise install --yes

pnpm:
	@fish -i -c 'pnpm add --global --allow-build=opencode-ai --allow-build=node-pty (cat "$(CURDIR)/configs/global_node_modules")'

uv:
	xargs -L1 uv tool install --force < "$(CURDIR)/configs/uv_tools"

uv-update:
	uv tool upgrade --all

shell:
	cat /etc/shells | grep $$(which fish) &>/dev/null || echo $$(which fish) | sudo tee -a /etc/shells
	cat /etc/shells | grep $$(which bash) &>/dev/null || echo $$(which bash) | sudo tee -a /etc/shells
	cat /etc/shells | grep $$(which dash) &>/dev/null || echo $$(which dash) | sudo tee -a /etc/shells
	chsh -s $$(which dash)

system-preferences:
	"$(CURDIR)/home/config/scripts/set-macos-defaults.sh"
