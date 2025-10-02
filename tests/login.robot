*** Settings ***
Resource    ../resources/login.resource
Resource    ../resources/usuarios.resource


*** Test Cases ***

Cenario 01: CT-01 Login com credenciais válidas
    Criar sessão na ServeRest
    Fazer login com credenciais válidas

Cenario 02: CT-02 Login com senha incorreta
    Criar sessão na ServeRest
    Fazer login com senha incorreta

Cenario 03: CT-03 Login com campos vazios
    Criar sessão na ServeRest
    Fazer login com campos vazios

Cenario 04: CT-14 Login com formato de e-mail inválido
    Criar sessão na ServeRest
    Fazer login com formato de email inválido
