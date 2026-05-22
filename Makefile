.DEFAULT_GOAL := help

# Diretório de resultados
RESULTS_DIR := tests/results

# Tag padrão para execução filtrada
TAG ?= regressivo

# ─────────────────────────────────────────────
# Setup
# ─────────────────────────────────────────────

.PHONY: install
install: ## Instala as dependências do projeto
	@echo "🔧 Atualizando pip e instalando dependências..."
	pip3 install --upgrade pip
	pip3 install -r requirements.txt
	@echo "✅ Dependências instaladas com sucesso."
	@echo ""
	@echo "💡 Para configurar aliases de python/pip no seu shell, execute manualmente:"
	@echo "   bash setup.sh"

# ─────────────────────────────────────────────
# Execução de testes
# ─────────────────────────────────────────────

.PHONY: test
test: ## Executa todos os cenários de teste
	@echo "🤖 Executando todos os testes..."
	robot -d $(RESULTS_DIR) tests

.PHONY: test-tag
test-tag: ## Executa testes por tag. Uso: make test-tag TAG=smoke
	@echo "🤖 Executando testes com tag: $(TAG)..."
	robot -d $(RESULTS_DIR) --include $(TAG) tests

.PHONY: test-smoke
test-smoke: ## Executa apenas os cenários com tag 'smoke'
	@echo "🤖 Executando testes smoke..."
	robot -d $(RESULTS_DIR) --include smoke tests

.PHONY: test-parallel
test-parallel: ## Executa todos os testes em paralelo com Pabot
	@echo "🤖 Executando testes em paralelo..."
	pabot -d $(RESULTS_DIR) tests

.PHONY: test-parallel-tag
test-parallel-tag: ## Executa testes em paralelo por tag. Uso: make test-parallel-tag TAG=regressivo
	@echo "🤖 Executando testes em paralelo com tag: $(TAG)..."
	pabot -d $(RESULTS_DIR) --include $(TAG) tests

# ─────────────────────────────────────────────
# Utilitários
# ─────────────────────────────────────────────

.PHONY: clean
clean: ## Remove os arquivos de resultado anteriores
	@echo "🧹 Limpando resultados anteriores..."
	@rm -rf $(RESULTS_DIR)
	@echo "✅ Diretório $(RESULTS_DIR) removido."

.PHONY: save-results
save-results: ## Envia os resultados dos testes para o banco de dados
	@echo "💾 Salvando resultados no banco de dados..."
	python3 save_test_results.py

.PHONY: help
help: ## Lista todos os comandos disponíveis
	@echo ""
	@echo "Uso: make [target] [VARIÁVEL=valor]"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Variáveis:"
	@echo "  \033[33mTAG\033[0m   Tag para filtrar testes (padrão: regressivo)"
	@echo ""
