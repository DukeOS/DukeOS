# Guia de Construção do DukeOS

Este documento descreve o passo a passo técnico para criar uma imagem `.iso` instalável do DukeOS a partir de um sistema Arch Linux base.

## Pré-requisitos

* Um sistema Arch Linux já instalado e funcional (pode ser uma máquina virtual).
* Acesso à internet.
* Pelo menos 30GB de espaço em disco livre.
* Conhecimento básico de linha de comando Linux.

## Passo 1: Preparando o Ambiente de Construção

Primeiro, vamos instalar as ferramentas necessárias para criar a imagem da distro.

```bash
sudo pacman -Syu --noconfirm archiso git
```

## Passo 2: Clonando o Repositório e Preparando os Arquivos

Vamos copiar a configuração padrão do ArchISO para o nosso projeto e organizá-lo.

```bash
# Clone o repositório do DukeOS
git clone [https://github.com/DukeOS/DukeOS.git](https://github.com/DukeOS/DukeOS.git)
cd DukeOS

# Copie o perfil de construção padrão do ArchISO
cp -r /usr/share/archiso/configs/releng/ .
mv releng dukeos-profile
```

Agora, a estrutura do seu projeto deve ser:

```
DukeOS/
└── dukeos-profile/
    ├── airootfs/
    ├── efiboot/
    ├── isolinux/
    ├── pacman.conf
    ├── build.sh
    └── ...
```

## Passo 3: Customizando a Lista de Pacotes

O arquivo `packages.x86_64` dentro de `dukeos-profile/` define todos os pacotes que serão incluídos na imagem live e na instalação final.

**Edite o arquivo `dukeos-profile/packages.x86_64` e adicione os pacotes do DukeOS.** A lista deve conter:

```
# Base System
base
base-devel
linux
linux-firmware
grub
efibootmgr
os-prober

# Window Manager e Wayland
sway
swaybg
waybar
wofi
mako # Notification daemon
grim # Screenshots
slurp # Screen selection

# Terminal e Shell
alacritty
kitty
zsh
oh-my-zsh-git # do AUR, precisará configurar um repo customizado ou buildar

# Ferramentas de Desenvolvimento
git
vscode # ou code
docker
docker-compose
asdf-vm # do AUR
dbeaver
insomnia
maven
gradle

# Fontes e Temas
ttf-jetbrains-mono-nerd
papirus-icon-theme
noto-fonts
noto-fonts-emoji

# Utilitários
neofetch
htop
stow
curl
wget
unzip
thunar # Gerenciador de arquivos leve
```

**Nota sobre o AUR:** Pacotes como `oh-my-zsh-git` e `asdf-vm` vêm do AUR. Para incluí-los na ISO, a abordagem mais limpa é criar um repositório local customizado e adicioná-lo ao `pacman.conf` do perfil.

## Passo 4: Configurando o Sistema (airootfs)

A pasta `dukeos-profile/airootfs/` representa o sistema de arquivos raiz (`/`) da imagem live. Tudo que você colocar aqui será copiado para o sistema final.

É aqui que colocamos nossos "dotfiles" e scripts de configuração.

1.  **Crie a estrutura de diretórios para os dotfiles:**
    ```bash
    mkdir -p dukeos-profile/airootfs/etc/skel/.config/
    ```
    O diretório `/etc/skel` é um template. Quando um novo usuário é criado, os arquivos daqui são copiados para a sua pasta home.

2.  **Adicione os arquivos de configuração:**
    * `dukeos-profile/airootfs/etc/skel/.config/sway/config`
    * `dukeos-profile/airootfs/etc/skel/.config/waybar/config.jsonc` e `style.css`
    * `dukeos-profile/airootfs/etc/skel/.config/alacritty/alacritty.yml`
    * `dukeos-profile/airootfs/etc/skel/.zshrc` (uma versão já configurada com Oh My Zsh)

3.  **Crie um script de setup:**
    Crie um script em `dukeos-profile/airootfs/root/customize_airootfs.sh`. Este script será executado durante a construção da imagem para configurar o sistema.

    Exemplo de `customize_airootfs.sh`:
    ```bash
    #!/bin/bash

    # Configura o Zsh como shell padrão para o usuário root e novos usuários
    chsh -s /bin/zsh root
    sed -i 's#/bin/bash#/bin/zsh#' /etc/default/useradd

    # Habilita serviços essenciais
    systemctl enable docker.service
    ```
    Não se esqueça de torná-lo executável: `chmod +x dukeos-profile/airootfs/root/customize_airootfs.sh`.

## Passo 5: Construindo a Imagem ISO

Com tudo configurado, agora é a hora da mágica.

Navegue para a pasta do seu projeto (`DukeOS/`) e execute o script de construção do `archiso`.

```bash
# Este comando deve ser executado como root
sudo ./dukeos-profile/build.sh -v
```

O processo vai baixar todos os pacotes, aplicar suas customizações e, se tudo der certo, gerar um arquivo `.iso` na pasta `out/`.

O arquivo será algo como `out/archlinux-2025.09.04-x86_64.iso`. Você pode renomeá-lo para `DukeOS-0.1-alpha.iso`.

## Passo 6: Testando

Use um software de virtualização como o VirtualBox ou QEMU para iniciar a ISO recém-criada e testar o ambiente live.

```bash
# Exemplo com QEMU
qemu-system-x86_64 \
    -m 4G \
    -enable-kvm \
    -boot d \
    -cdrom out/DukeOS-0.1-alpha.iso
```

O próximo grande passo será integrar o **Calamares** para ter um instalador gráfico amigável. 

Isso será adicionado a este guia em uma próxima etapa.
