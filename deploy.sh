#!/bin/bash

echo "🚀 Iniciando deploy do Gbite..."
echo "-------------------------------------------"

SOURCE_DIR="../gbite-site-source"
PUBLIC_DIR="../gbite-site-public"

# 🧭 Verifica se o script está dentro de uma das pastas
if [ ! -d "$SOURCE_DIR" ] && [ ! -d "$PUBLIC_DIR" ]; then
  echo "❌ Estrutura de diretórios não encontrada. Verifique se está em GBITE/gbite-site-source."
  exit 1
fi

# Corrige caminhos relativos se estiver dentro do source
if [ -d "../gbite-site-public" ]; then
  SOURCE_DIR="."
  PUBLIC_DIR="../gbite-site-public"
fi

echo "ℹ️  Sincronizando arquivos entre source e public..."
rsync -av --delete \
  --exclude=".git" \
  --exclude="deploy.sh" \
  --exclude="README.md" \
  --exclude="LICENSE" \
  --exclude=".gitignore" \
  --exclude="node_modules" \
  "$SOURCE_DIR/" "$PUBLIC_DIR/"

if [ $? -ne 0 ]; then
  echo "❌ Falha ao sincronizar arquivos!"
  exit 1
fi
echo "✅ Arquivos sincronizados com sucesso!"

cd "$PUBLIC_DIR"

echo "ℹ️  Adicionando mudanças ao Git..."
git add .

if [ $? -ne 0 ]; then
  echo "❌ Falha ao adicionar mudanças ao Git!"
  exit 1
fi

# Cria o commit com a mensagem recebida como argumento
COMMIT_MSG="${1:-Atualização automática via deploy.sh}"
echo "ℹ️  Criando commit..."
git commit -m "$COMMIT_MSG"

if [ $? -ne 0 ]; then
  echo "❌ Falha ao criar commit!"
  exit 1
fi

echo "ℹ️  Enviando para o repositório remoto..."
git push origin main

if [ $? -ne 0 ]; then
  echo "❌ Falha ao enviar alterações para o repositório remoto!"
  exit 1
fi

echo "✅ Deploy concluído com sucesso! 🎉"