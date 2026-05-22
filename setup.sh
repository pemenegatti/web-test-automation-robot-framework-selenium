#!/bin/bash

# Detecta o shell atual pelo processo pai, não pela variável $SHELL
CURRENT_SHELL=$(ps -p $PPID -o comm= 2>/dev/null | tr -d '-')

case "$CURRENT_SHELL" in
    bash)
        RC_FILE="$HOME/.bashrc"
        ;;
    zsh)
        RC_FILE="$HOME/.zshrc"
        ;;
    *)
        echo "Shell '$CURRENT_SHELL' não suportado. O script suporta apenas Bash e Zsh."
        exit 1
        ;;
esac

echo "Adicionando aliases ao arquivo $RC_FILE"

# Adiciona aliases apenas se ainda não existirem
grep -qxF "alias pip='pip3'" "$RC_FILE" || echo "alias pip='pip3'" >> "$RC_FILE"
grep -qxF "alias python='python3'" "$RC_FILE" || echo "alias python='python3'" >> "$RC_FILE"

# Recarrega o arquivo de configuração
# shellcheck disable=SC1090
source "$RC_FILE"

# Atualizar pip e instalar dependências
pip3 install --upgrade pip
pip3 install -r requirements.txt

echo "Setup concluído com sucesso."
