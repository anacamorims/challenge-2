*** Settings ***
Resource    ../resources/usuarios.resource


*** Test Cases ***
Cenario 01: CT-04 Criar um usuário válido
    Criar sessão na ServeRest
    Criar um usuário novo
    Cadastrar usuário na ServeRest

Cenario 02: CT-05 Criar um usuário com email inválido
    Criar sessão na ServeRest
    Cadastrar usuário com email inválido

Cenario 03: CT-06 Criar um usuário com payload grande
    Criar sessão na ServeRest
    Cadastrar usuário com payload grande

Cenario 04: CT-18 Cadastrar usuário com email de domínio restrito
    Criar sessão na ServeRest
    Cadastrar usuário com domínio restrito

Cenario 05: CT-19 Cadastrar usuário com senha menor que 5 caracteres
    Criar sessão na ServeRest
    Cadastrar usuário com senha menor que 5 caracteres

Cenario 06: CT-20 Cadastrar usuário com senha maior que 10 caracteres
    Criar sessão na ServeRest
    Cadastrar usuário com senha maior que 10 caracteres