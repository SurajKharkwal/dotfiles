#!/bin/bash

DEPENDENCIES=("cava" "fish" "lazygit" "fastfetch" "neofetch" "rofi" "tmux" "hyprlock" "hypridle" "jet-brainsmono")

# Install AUR helper
install_aur_helper() {
  echo "Installing AUR helper (yay)..."
  git clone https://aur.archlinux.org/yay-git.git /tmp/yay-git && cd /tmp/yay-git && makepkg -si && cd .. && rm -rf /tmp/yay-git/
}

# Install HyprPanel dependencies
install_hyprpanel() {
  echo "Installing HyprPanel dependencies..."
  yay -S aylurs-gtk-shell-git wireplumber libgtop bluez bluez-utils networkmanager dart-sass wl-clipboard upower gvfs ags-hyprpanel-git brightnessctl pywal swww matugen btop hyprsunset hyprpicker gpu-screen-recorder power-profiles-daemon pacman-contrib grimblast
}

# Install Notepad application
install_notepad() {
  echo "Setting up Notepad..."
  if [[ -d "notepad/.config/notepad" ]]; then
    sudo cp ~/dotfiles/notepad/notepad.desktop /usr/share/applications/
  else
    echo "Notepad config not found. Skipping."
  fi
}

# Install common apps
install_apps() {
  echo "Installing common applications..."
  yay -S stow cava fish lazygit fastfetch neofetch rofi tmux htop hyprlock ttf-jetbrainsmono
}

# Install Yazi and dependencies
install_yazi() {
  echo "Installing Yazi and dependencies..."
  sudo pacman -S yazi ffmpeg p7zip jq poppler fd ripgrep fzf zoxide imagemagick
}

# Setup Tmux Plugin Manager
setup_tmux() {
  echo "Setting up Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Create symlinks for dotfiles
create_symlinks() {
  echo "Creating symlinks for dotfiles..."
  cd ~/dotfiles/ || { echo "Dotfiles directory not found!"; exit 1; }
  for a in "${DEPENDENCIES[@]}"; do
    rm -rf ~/.config/"$a" && stow "$a"
  done
}

# Run GRUB theme installer
install_grub_theme() {
  echo "Installing GRUB theme..."
  cd ~/dotfiles/grub_theme || { echo "GRUB theme directory not found!"; return; }
  ./install.sh
}

# Main function calls
install_aur_helper
install_notepad
install_hyprpanel
install_apps
install_yazi
setup_tmux
create_symlinks
install_grub_theme

echo "Setup completed successfully!"
