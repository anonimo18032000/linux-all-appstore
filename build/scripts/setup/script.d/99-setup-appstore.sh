#!/bin/bash

set -e 

DEFAULT_APPSTORE_PATH="/var/lib/casaos/appstore/default"

if [ -d "${DEFAULT_APPSTORE_PATH}" ]; then
    echo "🟩 Fazer backup da loja de aplicativos padrão existente..."
    mv -f "${DEFAULT_APPSTORE_PATH}" "${DEFAULT_APPSTORE_PATH}.old" || {
        echo "🟥 Falha ao Fazer backup da loja de aplicativos padrão existente"
        exit 1
    }
fi

echo "🟩 Atualizando a appstore padrão..."

if [ -d "${DEFAULT_APPSTORE_PATH}.new" ]; then
    mv -vf "${DEFAULT_APPSTORE_PATH}.new" "${DEFAULT_APPSTORE_PATH}" || {
        echo "🟥Falha ao atualizar a loja de aplicativos padrão... restaurando o backup..."
        rm -vf "${DEFAULT_APPSTORE_PATH}"
        mv -vf "${DEFAULT_APPSTORE_PATH}.old" "${DEFAULT_APPSTORE_PATH}"
        rm -rvf "${DEFAULT_APPSTORE_PATH}.new"
        exit 1
    }
    rm -rvf "${DEFAULT_APPSTORE_PATH}.old" || {
        echo "🟨 Falha ao remover o backup padrão antigo da appstore"
    }
else
    echo "🟨 A nova loja de aplicativos padrão não existe"
fi