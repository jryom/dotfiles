.PHONY: default install dotbot brew brew-personal gh mise pnpm pip misc fisher virtualfish fish-globals system-preferences gatekeeper shell

default: install

install: homebrew gatekeeper system-preferences mise brew pip fish-globals dotbot fisher virtualfish pnpm misc gh

brew:
	brew bundle install --file="$(CURDIR)/configs/brewfile" --force

brew-personal:
	brew bundle install --file="$(CURDIR)/configs/brewfile_personal" --force

dotbot:
	@fish -i -c 'sudo dotbot --config-file "$(CURDIR)/configs/dotbot.yaml" --base-directory "$(CURDIR)" --quiet; \
	set dotfiles_private "$$HOME/Documents/dotfiles-private"; \
	brctl download "$$dotfiles_private"; \
	sudo dotbot --config-file "$$dotfiles_private/configs/dotbot.yaml" --base-directory "$$dotfiles_private" --quiet'

fisher:
	@fish -i -c 'fisher update'

fish-globals:
	@fish -i -c $(CURDIR)/configs/fish_globals.fish
	@fish -i -c 'vf addplugins auto_activation'

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

misc:
	echo y | "$$(brew --prefix)"/opt/fzf/install --no-bash --no-zsh

mise:
	mkdir -p "$$HOME/.config/mise"
	ln -f "$(CURDIR)/home/config/mise/config.toml" "$$HOME/.config/mise/config.toml"
	brew install mise
	mise install --yes

pip:
	@fish -i -c 'pip install --upgrade --requirement "$(CURDIR)/configs/requirements.txt"'

pnpm:
	@fish -i -c 'pnpm add --global (cat "$(CURDIR)/configs/global_node_modules")'

shell:
	cat /etc/shells | grep $$(which fish) &>/dev/null || echo $$(which fish) | sudo tee -a /etc/shells
	cat /etc/shells | grep $$(which bash) &>/dev/null || echo $$(which bash) | sudo tee -a /etc/shells
	cat /etc/shells | grep $$(which dash) &>/dev/null || echo $$(which dash) | sudo tee -a /etc/shells
	chsh -s $$(which dash)

system-preferences:
	"$(CURDIR)/home/config/scripts/set-macos-defaults.sh"
