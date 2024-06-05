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