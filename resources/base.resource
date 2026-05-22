*** Settings ***
Documentation    Arquivo responsavel pela declaração centralizada de todas as libraries do projeto

# Biblioteca de automação web
Library    SeleniumLibrary

# Biblioteca de interação com o sistema operacional (variáveis de ambiente, arquivos, etc.)
Library    OperatingSystem

# Keywords Python customizadas do projeto (Scroll To Element, Clear Text Element, Click Text Element, Fake*)
Library    ../libs/utils.py
