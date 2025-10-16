#!/bin/bash
# 🚀 Deploy Gbite - Source → Public (com cores e emojis)

# ====== CONFIGURAÇÕES ======
COMMIT_MSG=${1:-"Deploy automático - atualização do site"}
PUBLIC_REPO="../gbite-site-public"

# ====== CORES ======
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m" # sem cor

# ====== FUNÇÕES ======
function info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
function success() { echo -e "${GREEN}✅ $1${NC}"; }
function warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
function error() { echo -e "${RED}❌ $1${NC}"; exit 1; }

# ====== CHECAGEM ======
echo -e "\n${BLUE}🚀 Iniciando deploy do Gbite...${NC}"
echo "-------------------------------------------"

if [ ! -d "$PUBLIC_REPO" ]; then
  error "Pasta '$PUBLIC_REPO' não encontrada!
  Coloque o repositório público (gbite-site-public) no mesmo nível do gbite-site-source."
fi

# ====== SINCRONIZAÇÃO ======
info "Sincronizando arquivos entre source e public..."
rsync -av --delete \
  --exclude='.git' \
  --exclude='.github' \
  --exclude='README.md' \
  --exclude='deploy.sh' \
  "$PWD/" "$PUBLIC_REPO/" || error "Falha ao sincronizar arquivos!"

success "Arquivos sincronizados com sucesso!"

# ====== COMMIT & PUSH ======
cd "$PUBLIC_REPO" || error "Falha ao acessar $PUBLIC_REPO"

info "Adicionando mudanças ao Git..."
git add .

# Verifica se há mudanças
if git diff-index --quiet HEAD --; then
  warn "Nenhuma modificação detectada. Nada para enviar."
  exit 0
fi

info "Criando commit..."
git commit -m "$COMMIT_MSG" || error "Falha ao criar commit!"

info "Enviando para o repositório remoto..."
git push origin main || error "Falha ao enviar alterações para o repositório remoto!"

# ====== FINAL ======
echo "-------------------------------------------"
success "🌐 Deploy concluído com sucesso! O site do Gbite está atualizado 🚀"
echo -e "${YELLOW}✨ Dica:${NC} use './deploy.sh \"mensagem\"' para personalizar o commit.\n"