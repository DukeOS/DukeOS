#!/bin/bash
# DukeOS Complete Build Script
# Script para construir o DukeOS ISO dentro da VM

echo "=== DukeOS Build Script ==="
echo "Preparando ambiente para build..."

# Atualizar sistema
pacman -Sy --noconfirm

# Instalar pacotes necessários
pacman -S --noconfirm base-devel git archiso sudo wget curl vim

# Criar diretório de trabalho
mkdir -p /home/duke/dukeos-build
cd /home/duke/dukeos-build

# Criar estrutura do ArchISO
mkdir -p releng/airootfs/etc/skel
mkdir -p releng/airootfs/etc/systemd/system
mkdir -p releng/airootfs/usr/local/bin
mkdir -p releng/airootfs/etc/pacman.d
mkdir -p releng/airootfs/etc/sway
mkdir -p releng/airootfs/etc/waybar
mkdir -p releng/airootfs/etc/wofi
mkdir -p releng/airootfs/etc/alacritty

# Criar arquivo de configuração do ArchISO
cat > releng/profiledef.sh << 'EOF'
#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="dukeos"
iso_label="DukeOS-$(date +%Y%m%d-%H%M)"
iso_publisher="DukeOS <https://github.com/DukeOS>"
iso_application="DukeOS Linux Distribution"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.usb')
arch=('x86_64')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/etc/sudoers.d"]="0:0:750"
  ["/etc/sudoers.d/g_wheel"]="0:0:440"
  ["/root"]="0:0:750"
  ["/root/.gnupg"]="0:0:700"
  ["/etc/polkit-1/rules.d"]="0:0:750"
  ["/etc/polkit-1/rules.d/49-nopasswd-calamares.rules"]="0:0:440"
)
EOF

# Criar pacman.conf customizado
cp /etc/pacman.conf releng/airootfs/etc/

# Criar lista de pacotes base
cat > releng/packages.x86_64 << 'EOF'
# Base system
base
base-devel
linux
linux-firmware
linux-headers
sudo
wget
curl
vim
nano
bash-completion

# Desktop environment
sway
waybar
wofi
alacritty
bemenu
grim
slurp
swappy
mako
polkit
xdg-desktop-portal
xdg-desktop-portal-wlr

# Development tools
git
github-cli
vim
neovim
code
docker
docker-compose
nodejs
npm
yarn
python
python-pip
jdk-openjdk
maven
gradle
go
rust
cargo
clang

# System utilities
networkmanager
neofetch
htop
tree
jq
ripgrep
fd
exa
bat
duf

# Fonts and themes
ttf-jetbrains-mono-nerd
ttf-fira-code
ttf-dejavu
noto-fonts
noto-fonts-emoji
papirus-icon-theme

# Additional tools
firefox
gimp
vlc
libreoffice-fresh
EOF

# Criar script de configuração do sistema
cat > releng/airootfs/root/customize_airootfs.sh << 'EOF'
#!/bin/bash
set -e -u

# Configurar timezone
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

# Configurar locale
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

# Configurar hostname
echo "dukeos" > /etc/hostname
cat > /etc/hosts << 'HOSTS'
127.0.0.1	localhost
::1		localhost
127.0.1.1	dukeos.localdomain	dukeos
HOSTS

# Habilitar serviços
systemctl enable NetworkManager.service
systemctl enable docker.service

# Criar usuário
useradd -m -G wheel -s /bin/bash duke
echo "duke:duke" | chpasswd
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Instalar Oh My Zsh para root
git clone https://github.com/ohmyzsh/ohmyzsh.git /root/.oh-my-zsh
cp /root/.oh-my-zsh/templates/zshrc.zsh-template /root/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="duke"/' /root/.zshrc

# Configurar Sway
cp /etc/sway/config /etc/sway/config.dukeos
sed -i 's/Mod1/Mod4/' /etc/sway/config.dukeos
EOF

chmod +x releng/airootfs/root/customize_airootfs.sh

# Criar script de build final
cat > build-dukeos.sh << 'EOF'
#!/bin/bash
cd /home/duke/dukeos-build
sudo mkarchiso -v -w /tmp/archiso-tmp releng/
EOF

chmod +x build-dukeos.sh

echo "=== Configuração concluída ==="
echo "Para construir o DukeOS ISO, execute:"
echo "cd /home/duke/dukeos-build"
echo "./build-dukeos.sh"
echo ""
echo "O ISO será gerado em: /tmp/archiso-tmp/out/"
