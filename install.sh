#!/bin/sh

export HOMEBREW_NO_EMOJI=1

if test ! $(which brew)
then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew install mas
brew install git
brew install wget
brew install uptimed
brew tap caskroom/cask

function mas_install () {
    mas list | grep -i "$1" > /dev/null

    if [ "$?" == 0 ]; then
        echo "==> $1 est déjà installée"
    else
        mas search "$1" | { read app_ident app_name ; mas install $app_ident ; }
    fi
}

# Applications App Store

mas_install "1Password"
mas_install "Amphetamine"
mas_install "Bitcoin Ticker"
mas_install "Datum"
mas_install "Kaleidoscope"
mas_install "Keynote"
mas_install "MacTracker"
mas_install "Numbers"
mas_install "Pages"
mas_install "Pixelmator"
mas_install "Pocket"
mas_install "Radium"
mas_install "Reeder"
mas_install "Transmit"
mas_install "Tweetbot"

# Autres applications

brew cask install atom
brew cask install capture-one
brew cask install cleanmymac
brew cask install docker
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install istat-menus5
brew cask install iterm2
brew cask install kitematic
brew cask install molotov
brew cask install multifirefox
brew cask install mysqlworkbench
brew cask install onyx
brew cask install paw
brew cask install phpstorm
brew cask install sequel-pro
brew cask install slack
brew cask install sourcetree
brew cask install spotify
brew cask install sublime-text
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc
brew cask install wireshark

# Composer

curl -LsS https://getcomposer.org/installer -o composer-installer.php
php composer-installer.php
rm composer-installer.php
mv composer.phar /usr/local/bin/composer

osascript -e 'tell application "System Preferences" to quit'

# Paramètres généraux

# Coin actif haut droit : éteindre l'écran
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 10
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0
# Etendre automatiquement la boîte de dialogue "save"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Par défaut, ne pas proposer l'enregistrement sur iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Ne pas lancer l'app Photo quand un périphérique compatible est connecté
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
# Pas de pop-up clavier style iOS
sudo defaults write -g ApplePressAndHoldEnabled -bool false
# Répétition touches
sudo defaults write NSGlobalDomain KeyRepeat -int 1
# Délai avant répétition des touches
sudo defaults write NSGlobalDomain InitialKeyRepeat -int 0
# Alertes sonores quand on modifie le volume
sudo defaults write com.apple.systemsound com.apple.sound.beep.volume -float 0
# Réglages Trackpad : toucher pour cliquer
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Finder

# Afficher la bibliothèque
chflags nohidden ~/Library
# Afficher le dossier /Volumes
sudo chflags nohidden /Volumes
# Afficher la barre latérale
defaults write com.apple.finder ShowStatusBar -bool true
# Afficher fichiers en mode liste
defaults write com.apple.finder FXPreferredViewStyle -string “Nlsv”
# Ne pas afficher la barre du chemin d'accès
defaults write com.apple.finder ShowPathbar -bool false
# Afficher la barre d'état
defaults write com.apple.finder ShowStatusBar -bool true
# Afficher toutes les extensions
sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Afficher le dossier home par défaut
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Recherche dans le dossier en cours par défaut
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Coup d'œîl : sélection de texte
defaults write com.apple.finder QLEnableTextSelection -bool true
# Pas de création de fichiers .DS_STORE
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Afficher les dossiers en premier
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Redémarrage Finder
killall Finder

# Dock

# Désactiver l'agrandissement
defaults write com.apple.dock magnification -bool false
# Taille des icônes
defaults write com.apple.dock tilesize -int 50
# Masquage automatique
defaults write com.apple.dock autohide -bool true
# Redémarrage Dock
killall Dock

# Safari

# Menu développeur
defaults write com.apple.safari IncludeDevelopMenu -int 1
# Barre d'état
defaults write com.apple.safari ShowOverlayStatusBar -int 1
# Afficher l'URL complète
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1
# DNT
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1
# Masquer barre des favoris
defaults write com.apple.Safari ShowFavoritesBar -bool false
# Redémarrage Safari
killall Safari

# Misc

# Désactiver sons au démarrage
sudo nvram SystemAudioVolume=" "

# Cleanup

brew cleanup

rm -f -r /Library/Caches/Homebrew/*
