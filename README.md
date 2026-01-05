# ⚡ Meu Setup de Oh My Zsh

Este é um script interativo para configurar o **Oh My Zsh** com tudo que eu gosto: plugins úteis, tema bonito, e tudo funcionando rapidinho! Ideal para deixar seu terminal mais produtivo, inteligente e estiloso 😎

---

## 🚀 O que esse script faz?

- Instala o **Zsh** (caso ainda não esteja instalado)
- Instala o **Oh My Zsh**
- Instala o tema **Powerlevel10k**
- Instala plugins:
  - `zsh-syntax-highlighting`
  - `zsh-autosuggestions`
  - `fzf`
  - `k` (atalhos de terminal)
- Configura automaticamente o `.zshrc`
- Pergunta se você quer mudar o shell padrão para o Zsh

---

## 💻 Requisitos

- Sistema baseado em Debian/Ubuntu
- `curl` ou `wget`
- Acesso sudo
- Git

---

## 🛠️ Como usar

```bash
git clone git@github.com:FilipeMHottis/setup-zsh.git
cd setup-zsh
chmod +x zsh-setup.sh.sh
./zsh-setup.sh.sh
```
### ➕ Após a instalação, execute o Zsh para finalizar as configurações:
```bash
zsh
```

Durante a instalação do Oh My Zsh, o script original pode abrir automaticamente um novo terminal com o Zsh.
Isso é normal! Quando isso acontecer:
#### 👉 Basta pressionar Ctrl + D para sair do terminal temporário e voltar ao script normalmente.
Nada será perdido. O script continuará de onde parou ✅



## ✨ Resultado esperado
Após a instalação, seu terminal estará com:

- Tema Powerlevel10k ativado
- Plugins úteis já funcionando
- Shell padrão alterado para o Zsh (se você permitir)

## 🧼 Dica final
Se quiser personalizar ainda mais, edite seu ~/.zshrc depois da instalação.

## 📸 Preview (opcional)
Se quiser, adicione aqui uma captura de tela do seu terminal com o tema e plugins funcionando.

## 👤 Autor
Feito com 💙 por Lipe Deux
