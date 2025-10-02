*** Settings ***
Resource    ../resources/carrinho.resource
Resource    ../resources/usuarios.resource

*** Test Cases ***

Cenario 01: CT-10 Adicionar produto válido ao carrinho
    Criar sessão na ServeRest
    Fazer login e obter token
    Adicionar produto válido ao carrinho

Cenario 02: CT-11 Adicionar produto com quantidade inválida
    Criar sessão na ServeRest
    Fazer login e obter token
    Adicionar produto com quantidade inválida

Cenario 03: CT-12 Adicionar produto com payload grande
    Criar sessão na ServeRest
    Fazer login e obter token
    Adicionar produto com payload grande

Cenario 04: CT-13 Remover produto do carrinho
    Criar sessão na ServeRest
    Fazer login e obter token
    Remover produto do carrinho

Cenario 05: CT-16 Tentar adicionar produto inexistente
    Criar sessão na ServeRest
    Fazer login e obter token
    Tentar adicionar produto inexistente


