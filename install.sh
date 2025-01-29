
#!/bin/bash

# Define color variables for output formatting
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
RESET="\033[0m"

# List of dependencies for dotfiles symlinks
DEPENDENCIES=("cava" "fish" "lazygit" "fastfetch" "neofetch" "rofi" "tmux" "hyprlock" "hypridle" "jet-brainsmono")

# Function to print section headers in a formatted way
print_header() {
  echo -e "\n${CYAN}==============================${RESET}"
  echo -e "${CYAN}$1${RESET}"
  echo -e "${CYAN}==============================${RESET}\n"
}

# Install AUR helper (yay)
install_aur_helper() {
  print_header "Installing AUR helper (yay)"
  git clone https://aur.archlinux.org/yay-git.git /tmp/yay-git \
    && cd /tmp/yay-git \
    && makepkg -si \
    && cd .. \
    && rm -rf /tmp/yay-git/
}

# Install dependencies for HyprPanel
install_hyprpanel() {
  print_header "Installing HyprPanel dependencies"
  yay -S aylurs-gtk-shell-git wireplumber libgtop bluez bluez-utils \
    networkmanager dart-sass wl-clipboard upower gvfs ags-hyprpanel-git \
    brightnessctl pywal swww matugen btop hyprsunset-git hyprpicker-git \
    gpu-screen-recorder power-profiles-daemon pacman-contrib grimblast hypridle-git
}

# Setup Notepad if configuration is available
install_notepad() {
  print_header "Setting up Notepad"
  if [[ -d "notepad/.config/notepad" ]]; then
    sudo cp ~/dotfiles/notepad/notepad.desktop /usr/share/applications/
    echo -e "${GREEN}Notepad setup completed.${RESET}"
  else
    echo -e "${YELLOW}Notepad config not found. Skipping.${RESET}"
  fi
}

# Install common applications
install_apps() {
  print_header "Installing common applications"
  yay -S stow cava fish lazygit fastfetch neofetch rofi tmux htop hyprlock-git \
    ttf-jetbrainsmono libreoffice-dev-bin
}

# Install Hyprland ecosystem packages
install_ecosys() {
  print_header "Installing Hyprland ecosystem packages"
  yay -S hyprland-git hyprgraphics-git aquamarine-git hyprpicker-git \
    xdg-desktop-portal-hyprland-git hyprlock-git hyprland-qtutils-git \
    hyprlang-git hyprutils-git hypridle-git hyprsunset-git hyprpolkitagent-git \
    hyprland-qt-support-git hyprcursor-git hyprwayland-scanner-git hyprsysteminfo-git 
}

# Install Yazi and its dependencies
install_yazi() {
  print_header "Installing Yazi and dependencies"
  sudo pacman -S yazi ffmpeg p7zip jq poppler fd ripgrep fzf zoxide imagemagick
}

# Set up Tmux Plugin Manager
setup_tmux() {
  print_header "Setting up Tmux Plugin Manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Create symlinks for dotfiles
create_symlinks() {
  print_header "Creating symlinks for dotfiles"
  cd ~/dotfiles/ || { echo -e "${RED}Dotfiles directory not found! Exiting.${RESET}"; exit 1; }
  for a in "${DEPENDENCIES[@]}"; do
    rm -rf ~/.config/"$a" && stow "$a"
  done
}

# Install GRUB theme
install_grub_theme() {
  print_header "Installing GRUB theme"
  cd ~/dotfiles/grub_theme || { echo -e "${RED}GRUB theme directory not found! Skipping.${RESET}"; return; }
  ./install.sh
}

# Main function to call all the setup functions
main() {
  install_aur_helper
  install_notepad
  install_hyprpanel
  install_apps
  install_yazi
  setup_tmux
  create_symlinks
  install_grub_theme

  echo -e "\n${GREEN}Setup completed successfully!${RESET}\n"
}

# Call the main function to start the setup
main
