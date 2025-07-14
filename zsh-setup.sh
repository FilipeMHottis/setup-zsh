set -e

echo "🌀 Bem-vindo à instalação interativa do Oh My Zsh com seus plugins favoritos!"
echo "Este script irá:"
echo "  1. Instalar Zsh e Oh My Zsh"
echo "  2. Adicionar plugins e tema Powerlevel10k"
echo "  3. Configurar seu .zshrc"
echo ""

read -p "⚠️ Deseja continuar? (s/n): " confirm
[[ $confirm != [sS] ]] && echo "❌ Instalação cancelada." && exit 0

# Utilitário de confirmação
confirm_step() {
  read -p "🔧 Deseja instalar $1? (s/n): " resp
  [[ $resp == [sS] ]]
}

# Atualização do apt ignorando erros de repositórios inválidos
echo "🔄 Atualizando pacotes (ignorar repositórios problemáticos)..."
sudo apt-get update 2>&1 | grep -v "NO_PUBKEY\|Skipping acquire\|not signed" || true

# 1. Zsh
echo "📦 Instalando Zsh..."
sudo apt-get install -y zsh

# 2. Oh My Zsh
if command -v curl >/dev/null 2>&1 || command -v wget >/dev/null 2>&1; then
  if confirm_step "Oh My Zsh"; then
    echo ""
    echo "ℹ️  OBSERVAÇÃO IMPORTANTE:"
    echo "Durante a instalação do Oh My Zsh, o terminal pode mudar automaticamente para o Zsh."
    echo "Se isso acontecer, você pode sair com Ctrl+D para voltar e continuar o setup normalmente."
    echo ""

    if command -v curl >/dev/null 2>&1; then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
      sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
  else
    echo "⏩ Pulando instalação do Oh My Zsh."
  fi
else
  echo "❌ curl ou wget não encontrados. Instale um deles para continuar."
  exit 1
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# 3. Fonte Powerline
if confirm_step "as fontes Powerline (para ícones no tema Powerlevel10k)"; then
  echo "🔤 Instalando fontes Powerline..."
  sudo apt-get install -y fonts-powerline
fi

# 4. Plugins
declare -A plugins
plugins=(
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
  ["fzf"]="https://github.com/junegunn/fzf.git"
  ["k"]="https://github.com/supercrabtree/k"
)

for name in "${!plugins[@]}"; do
  if confirm_step "o plugin $name"; then
    echo "⬇️ Instalando $name..."
    if [[ $name == "fzf" ]]; then
      git clone --depth 1 "${plugins[$name]}" ~/.fzf
      ~/.fzf/install --all
    else
      git clone "${plugins[$name]}" "$ZSH_CUSTOM/plugins/$name"
    fi
  else
    echo "⏩ Pulando $name."
  fi
done

# 5. Tema Powerlevel10k
if confirm_step "o tema Powerlevel10k"; then
  echo "🎨 Instalando tema Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
  echo "✅ Tema instalado."
  use_theme=true
else
  echo "⏩ Pulando Powerlevel10k."
  use_theme=false
fi

# 6. Atualizar .zshrc
echo "📝 Configurando ~/.zshrc..."

if [[ "$use_theme" = true ]]; then
  sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc || echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
fi

# Gerar lista de plugins escolhidos
selected_plugins=(git)
for name in "${!plugins[@]}"; do
  plugin_dir="$ZSH_CUSTOM/plugins/$name"
  [[ -d "$plugin_dir" || "$name" == "fzf" ]] && selected_plugins+=("$name")
done

plugin_line="plugins=(${selected_plugins[*]})"
sed -i "s/^plugins=(.*)/$plugin_line/" ~/.zshrc || echo "$plugin_line" >> ~/.zshrc

echo "✅ .zshrc atualizado com:"
echo "    Tema: powerlevel10k"
echo "    Plugins: ${selected_plugins[*]}"

# 7. Mudar shell padrão
if confirm_step "usar o Zsh como shell padrão agora"; then
  echo "⚙️ Alterando shell padrão para Zsh..."
  chsh -s "$(which zsh)"
  echo "✅ Shell alterado! Reinicie o terminal ou digite: zsh"
else
  echo "ℹ️ Shell padrão não alterado. Você pode usar o Zsh manualmente com: zsh"
fi

echo ""
echo "🎉 Tudo pronto, Lipe! Seu Zsh está turbinado. Bons comandos! ⚡"
