<h1 align="center">QA Web Test Automation</h1>
<h1 align="center">
    <a href="https://robotframework.org/">Robot Framework 🤖</a>
</h1>
<p align="center">Suíte de testes automatizados E2E para o site Sauce Demo, desenvolvida com Robot Framework + SeleniumLibrary, com suporte a execução paralela e pipeline no GitHub Actions.</p>

---

## 🛠 Tecnologias

- [Python](https://www.python.org/)
- [Robot Framework](https://robotframework.org/)
- [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/)
- [FakerLibrary](https://guykisel.github.io/robotframework-faker/)
- [Pabot](https://pabot.org/) — execução paralela
- [GitHub Actions](https://docs.github.com/en/actions)

---

## 📋 Pré-requisitos

- Python 3.11+
- Google Chrome, Firefox ou Edge instalado
- Chave SSH configurada para clonar o repositório:
  - [Gerar Chave SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
  - [Adicionar Chave SSH no GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

---

## 🚀 Como executar

### 1. Clone o repositório
```bash
git clone git@github.com:pemenegatti/web-test-automation-robot-framework-selenium.git
cd web-test-automation-robot-framework-selenium
```

### 2. Instale as dependências
```bash
make install
```

> Internamente executa o `setup.sh`, que instala as dependências do `requirements.txt` e configura aliases de `python`/`pip` no seu shell.

### 3. Execute os testes

| Comando                        | Descrição                                  |
|--------------------------------|--------------------------------------------|
| `make test`                    | Executa todos os cenários                  |
| `make test-smoke`              | Executa apenas os cenários com tag `smoke` |
| `make test-tag TAG=login`      | Executa por tag customizada                |
| `make test-parallel`           | Executa todos em paralelo com Pabot        |
| `make test-parallel-tag TAG=regressivo` | Executa em paralelo por tag       |
| `make clean`                   | Remove os resultados anteriores            |
| `make save-results`            | Envia resultados ao banco de dados         |
| `make help`                    | Lista todos os comandos disponíveis        |

---

## ⚙️ Variáveis de ambiente

Todas as variáveis têm valores padrão definidos em `resources/config/config.yaml` e podem ser sobrescritas via variável de ambiente:

| Variável               | Descrição                              | Padrão           |
|------------------------|----------------------------------------|------------------|
| `EXECUTION_ENVIRONMENT`| Ambiente de execução (`HML` ou `PROD`) | `HML`            |
| `BASE_URL`             | URL base da aplicação                  | `https://www.saucedemo.com/` |
| `BROWSER`              | Navegador (`chrome`, `firefox`, `edge`)| `chrome`         |
| `HEADLESS`             | Modo headless (`True` / `False`)       | `False`          |
| `TIMEOUT`              | Timeout das ações Selenium (segundos)  | `20`             |
| `USERNAME`             | Usuário de login                       | `standard_user`  |
| `PASSWORD`             | Senha de login                         | `secret_sauce`   |
| `PRODUCT_ID`           | ID do produto a adicionar ao carrinho  | `sauce-labs-backpack` |

Exemplo de execução com variáveis customizadas:
```bash
HEADLESS=True BROWSER=firefox robot -d tests/results tests
```

---

## 🗂 Estrutura do projeto

```
tests/
└── TestCases.robot          # Casos de teste em BDD (Gherkin)

resources/
├── common.resource          # Hub central de imports
├── config.resource          # Setup de ambiente
├── utils.resource           # Keywords utilitárias
├── config/
│   └── config.yaml          # Configurações por ambiente
├── pages/                   # Page Objects (uma por tela)
│   ├── login.resource
│   ├── home.resource
│   ├── carrinho.resource
│   ├── checkout.resource
│   └── finalizar.resource
└── locators/                # Seletores separados por página
    ├── login_locator.yaml
    ├── home_locator.yaml
    ├── carrinho_locator.yaml
    ├── checkout_locator.yaml
    └── finalizar_locator.yaml

libs/
└── utils.py                 # Keywords Python customizadas (ver tabela abaixo)
```

### Keywords customizadas — `libs/utils.py`

Disponíveis em todos os testes via `common.resource`:

| Keyword | Argumentos | Quando usar |
|---|---|---|
| `Scroll To Element` | `locator` | Elemento fora da viewport — faz scroll até ele antes de interagir |
| `Clear Text Element` | `locator`, `locator_type` (padrão: `xpath`) | Limpar campos protegidos com `readonly` ou `disabled` |
| `Click Text Element` | `locator`, `locator_type` (padrão: `xpath`), `timeout` (padrão: `10`) | Clicar em elemento aguardando ele ficar clicável |

Exemplo de uso nos testes:
```robot
Scroll To Element         //div[@id="produto"]
Clear Text Element        //input[@id="campo"]
Click Text Element        //button[@id="confirmar"]    xpath    15
```

---

## 🏷 Tags dos cenários

| Tag          | Descrição                                  |
|--------------|--------------------------------------------|
| `regressivo` | Executa todos os cenários                  |
| `smoke`      | Executa os cenários principais             |
| `login`      | Executa apenas os cenários de login        |
| `compra`     | Executa apenas os cenários de compra       |

---

## 🗂 Estrutura de branches

| Branch                      | Uso                                              |
|-----------------------------|--------------------------------------------------|
| `main`                      | Branch principal — dispara pipeline de regressão |
| `develop`                   | Base para novas branches                         |
| `feature/nome-do-cenario`   | Criação de novos cenários                        |
| `fix/nome-da-alteracao`     | Correções e ajustes                              |

---

## 🗄 Salvar resultados no banco de dados

O script `save_test_results.py` lê o `output.xml` e insere os resultados em um banco PostgreSQL. Configure as variáveis de ambiente antes de executar:

```bash
export DB_HOST=localhost
export DB_PORT=5432
export DB_NAME=seu_banco
export DB_USER=seu_usuario
export DB_PASSWORD=sua_senha

python save_test_results.py
```
