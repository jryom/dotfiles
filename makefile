.PHONY: default install dotbot brew brew-personal gh mise pnpm pip misc fisher virtualfish fish-globals system-preferences gatekeeper shell

default: install

install: homebrew gatekeeper system-preferences mise brew pip fish-globals dotbot fisher virtualfish pnpm misc gh

brew:
	brew bundle install --file="$(CURDIR)/configs/brewfile" --force --no-lock

brew-personal:
	brew bundle install --file="$(CURDIR)/configs/brewfile_personal" --force --no-lock

dotbot:
	@fish -i -c 'sudo dotbot --config-file "$(CURDIR)/configs/dotbot.yaml" --base-directory "$(CURDIR)" --quiet; \
	set dotfiles_private "$$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/dotfiles-private"; \
	brctl download "$$dotfiles_private"; \
	sudo dotbot --config-file "$$dotfiles_private/configs/dotbot.yaml" --base-directory "$$dotfiles_private" --quiet'

fisher:
	@fish -i -c 'fisher update'

fish-globals:
	@fish -i -c $(CURDIR)/configs/fish_globals.fish

gatekeeper:
	if spctl --status >/dev/null; then sudo spctl --master-disable; fi

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
	sudo bash -c "echo '$$(whoami) ALL=(root) NOPASSWD: sha256:$$(shasum -a 256 $$(which yabai) | cut -d " " -f 1) $$(which yabai) --load-sa'  > /private/etc/sudoers.d/yabai"
	-yabai --start-service
	-skhd --start-service

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
	defaults write -g AppleSpacesSwitchOnActivate -bool false
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	defaults write NSGlobalDomain InitialKeyRepeat -int 15
	defaults write NSGlobalDomain KeyRepeat -int 2
	defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
	defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
	defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
	defaults write com.apple.LaunchServices LSQuarantine -bool false
	defaults write com.apple.TextEdit RichText -bool false
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock autohide-delay -float 0
	defaults write com.apple.dock autohide-time-modifier -float 0.2
	defaults write com.apple.dock mru-spaces -bool false
	defaults write com.apple.dock show-recents -bool false
	defaults write com.apple.dock static-only -bool true
	defaults write com.apple.dock tilesize -int 48
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool "false"
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
	defaults write com.apple.finder FXRemoveOldTrashItems -bool true
	defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
	defaults write com.apple.finder ShowPathbar -bool true
	defaults write com.apple.finder ShowStatusBar -bool true
	defaults write com.apple.finder _FXSortFoldersFirst -bool YES
	defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes
	defaults write com.apple.menuextra.clock "DateFormat" -string "HH:mm"
	killall Dock
