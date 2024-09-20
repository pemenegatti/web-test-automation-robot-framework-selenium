<h1 align="center">QA Web Test Automation</h1>
<!-- # QA Web Test Automation -->
<h1 align="center">
    <a href="<https://robotframework.org/>">Robot Framework 🤖</a>
</h1>
<p align="center">Este projeto consiste em uma suíte de testes automatizados desenvolvidos utilizando o Robot Framework e execuções dos testes no GitHub Actions</p>

### 🛠 Tecnologias
As seguintes ferramentas foram usadas na construção do projeto:
- [Python](<https://www.python.org/>)
- [Robot Framework](<https://robotframework.org/>)
- [Bibliotecas do Robot Framework](<As bibliotecas específicas necessárias para seus testes podem variar. Consulte a documentação do Robot Framework para obter mais informações sobre como instalar bibliotecas.>)

### Certificar que a versão do Python esteja instalada.

### Para usuarios de Mac que estejam com dificuldades para executar os comandos pip ou python adicionar as linha no final do arquivo ~/.bashrc ou ~/.zshrc
```bash
alias pip="pip3"
```
```bash
alias python="python3"
```
- após adicionar as linhas acimas executar o seguinte comando no seu terminal (source ~/.bashrc ou source ~/.zshrc)

### Clone este repositório
```bash
git clone git@github.com:pemenegatti/web-test-automation-robot-framework-selenium.git
```
### Vá para a pasta do projeto (o caminho vai depender muito da sua estrutura de pastas)
- cd qa-web-test-automation

### Installar os requirements do projeto
```bash
pip install -r requirements.txt
```

### Para executar os cenarios automatizados execute o seguinte comando no terminal
```bash
robot tests
```

### 🛠 Branchs do projeto:
As seguintes Branchs que serão ultilizadas no projeto:
- main: branch principal (Utilizada para rodar os testes regressivos e afins) 
- develop: branch de desenvolvimento (Todas as novas branch devem ser criadas a partir dela)
- feature/nome-do-cenario: branch de criação de novos cenários (Todos os novos cenarios devem ser criados em uma branch com esse padram de nomenclatura)
- fix/nome-da-alteração: branch de alteração de algum cenário ou configuração do projeto(Todas as novas alteração devem ser criadas em uma branch com esse padram de nomenclatura)

### 🛠 Tags de cenários:
As seguintes Tags serão ultilizadas para rodar os cenários de teste:
- regressivo: roda todos os cenários automatizados.
- smoke: roda os principais cenários automatizados.
- login: roda apenas os cenários de login.
- compra: roda apenas os cenários de compra
