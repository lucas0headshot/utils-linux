#!/bin/bash

# Inicia o agente SSH se ele não estiver rodando
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# Diretórios com chaves SSH
KEY_DIRS=(~/.ssh ~/.ssh/gitlab)

# Itera sobre os diretórios e verifica/adiciona chaves
for dir in "${KEY_DIRS[@]}"; do
    if [[ -d $dir ]]; then
        for key in "$dir"/id_*; do
            # Ignorar arquivos públicos (.pub)
            if [[ $key != *.pub ]]; then
                # Verifica se a chave já está carregada
                if ssh-add -l | grep -q "$(ssh-keygen -lf "$key" | awk '{print $2}')"; then
                    #echo "A chave $key está carregada."
                else
                    #echo "Carregando a chave: $key"
                    ssh-add "$key" &>/dev/null
                fi
            fi
        done
    fi
done
