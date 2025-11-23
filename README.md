# DukeOS: O Linux para Desenvolvedores

**Instale e comece a codar.**

DukeOS é uma distribuição Linux baseada em Arch, criada por desenvolvedores, para desenvolvedores.

## 🎯 Nossa Missão

Eliminar a dor de cabeça da configuração inicial de um ambiente de desenvolvimento, oferecendo um sistema operacional completo e pronto para a produtividade desde o primeiro boot.

## 💭 A Filosofia

Quantas horas você já perdeu instalando JDKs, configurando IDEs, ajustando o terminal e caçando pacotes?

DukeOS nasceu dessa frustração. Nós acreditamos que seu foco deve estar no código, não na configuração.

- **Tudo Incluído:** As ferramentas mais essenciais para desenvolvimento (Java, Python, Go, Rust, Node.js, Docker) já vêm pré-instaladas e gerenciadas via `asdf-vm`.
- **Pronto para a Produtividade:** Um ambiente de desktop minimalista e focado, baseado em um Tiling Window Manager (Sway/Hyprland) e Wayland, sem distrações.
- **Visual Impecável:** Inspirado na limpeza do Pop!_OS e na robustez do Red Hat, com um tema consistente, Waybar nativo e o poderoso Oh My Zsh.
- **Base Sólida:** Construído sobre a flexibilidade e o poder do Arch Linux, garantindo acesso aos pacotes mais recentes através dos repositórios oficiais e do AUR.

## 🧰 O que já vem na caixa?

### Linguagens de Programação
- **Java** (OpenJDK) - Gerenciado pelo asdf-vm
- **Python** - Gerenciado pelo asdf-vm
- **Go** - Gerenciado pelo asdf-vm
- **Rust** - Gerenciado pelo asdf-vm
- **Ruby** - Gerenciado pelo asdf-vm
- **Node.js** - Gerenciado pelo asdf-vm

### IDEs e Editores
- **VS Code** - Editor de código leve e poderoso
- **JetBrains Toolbox** - Gerenciador de IDEs JetBrains (IntelliJ IDEA, PyCharm, etc.)

### Terminal e Shell
- **Alacritty** - Terminal rápido e leve
- **Kitty** - Terminal com GPU acceleration
- **Zsh** com **Oh My Zsh** - Shell aprimorado com plugins e temas
- **JetBrains Mono Nerd Font** - Fonte monoespaçada com ícones

### Containers e DevOps
- **Docker** ou **Podman** - Plataforma de containers
- **Docker Compose** - Orquestração de containers multi-serviço

### Ferramentas Essenciais
- **Git** - Controle de versão
- **Maven** - Gerenciador de dependências Java
- **Gradle** - Ferramenta de build Java
- **DBeaver** - Cliente de banco de dados universal
- **Insomnia** - Cliente REST/GraphQL
- **htop** - Monitor de sistema
- **neovim** - Editor de texto modal

### Ambiente Gráfico
- **Sway** ou **Hyprland** - Tiling Window Manager para Wayland
- **Waybar** - Barra de status para Wayland
- **Wofi** - Lançador de aplicativos
- **mako** - Notificador leve

## 🚀 Como Começar

### Baixar a ISO

1. Acesse a página de [releases](https://github.com/clubedojava/dukeos/releases)
2. Baixe a ISO mais recente
3. Grave em um pendrive usando ferramentas como:
   - [balenaEtcher](https://www.balena.io/etcher/) (Windows/Mac/Linux)
   - [Ventoy](https://www.ventoy.net/) (Multi-boot)
   - `dd` (Linux avançado)

### Instalação

1. Boot a partir da ISO
2. Execute o instalador Calamares
3. Siga o assistente de instalação
4. Reinicie e aproveite seu novo ambiente!

### Primeiros Passos

Após a instalação, você terá acesso imediato a:

```bash
# Verificar versões das linguagens
java --version
python --version
node --version
go version
rustc --version

# Gerenciar versões com asdf
asdf list
asdf list all java
asdf install java latest

# Acessar IDEs
# VS Code: code
# JetBrains Toolbox: jetbrains-toolbox
```

## 🛠️ Como Contribuir

Este é um projeto open-source movido pela comunidade.

### Fase Atual
Estamos na fase inicial de desenvolvimento. A melhor forma de ajudar é:

1. **Seguir nosso guia de construção** ([BUILD.md](BUILD.md)) para criar uma ISO local
2. **Testar** em uma máquina virtual ou hardware físico
3. **Reportar bugs** abrindo Issues
4. **Contribuir código** através de Pull Requests

### Áreas de Contribuição
- **Scripts de instalação** - Automatizar configurações
- **Temas e aparência** - Melhorar a experiência visual
- **Documentação** - Guias e tutoriais
- **Testes** - Validação em diferentes hardwares
- **Pacotes** - Adicionar novas ferramentas essenciais

## 📋 Roadmap

### Fase Alpha (Atual)
- [x] Estrutura base do projeto
- [x] Lista de pacotes essenciais
- [x] Configuração do ambiente gráfico
- [ ] Primeira ISO Alfa para testes
- [ ] Script de instalação automatizado

### Fase Beta
- [ ] Customização do instalador Calamares
- [ ] Otimização de performance
- [ ] Testes em hardware real
- [ ] Documentação para usuário final

### Fase Release
- [ ] Instalador gráfico finalizado
- [ ] Suporte a múltiplos idiomas
- [ ] Atualizações automáticas
- [ ] Suporte oficial à comunidade

## 📚 Documentação

- [BUILD.md](BUILD.md) - Guia de construção da ISO
- [PACKAGES.md](PACKAGES.md) - Lista completa de pacotes
- [CONFIG.md](CONFIG.md) - Configurações do sistema
- [CONTRIBUTING.md](CONTRIBUTING.md) - Diretrizes de contribuição

## 🤝 Comunidade

- **Discord**: [Clube do Java](https://discord.gg/clubedojava)
- **GitHub**: [github.com/clubedojava/dukeos](https://github.com/clubedojava/dukeos)
- **Website**: [dukeos.org](https://dukeos.org) (em construção)

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

---

Feito com ❤️, café e código.

![Clube do Java](https://github.com/clubedojava.png)