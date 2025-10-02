*** Settings ***
Resource    ../resources/produtos.resource
Resource    ../resources/usuarios.resource

*** Test Cases ***

Cenario 01: CT-09 Cadastrar produto
    Criar sessão na ServeRest
    Cadastrar produto válido

Cenario 02: CT-15 Cadastrar produto com preço negativo
    Criar sessão na ServeRest
    Cadastrar produto com preço negativo

Cenario 03: CT-17 Excluir produto presente em carrinho
    Criar sessão na ServeRest
    Excluir produto presente em carrinho