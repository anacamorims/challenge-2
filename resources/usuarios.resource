*** Settings ***
Library     RequestsLibrary
Library    String

*** Variables ***
${email}    

*** Keywords ***
Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String    
    ...    length=6    
    ...    chars=[LETTERS]
    Set Global Variable    
    ...    ${email}    
    ...    ${palavra_aleatoria}@email.com
    Log To Console    ${email}

Cadastrar usuário na ServeRest
    ${body}    Create Dictionary       
    ...    nome=Fulano da Silva
    ...    email=${email}   
    ...    password=123456
    ...    administrador=true      
    Log To Console    ${body}

    Criar sessão na ServeRest
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    Log To Console    ${resposta.json()}

Criar sessão na ServeRest
    ${headers}    Create Dictionary    
    ...    accept=application/json    
    ...    Content-Type=application/json
    Create Session
    ...    alias=ServeRest
    ...    url=https://serverest.dev
    ...    headers=${headers}
    Log To Console    Sessão criada

Cadastrar usuário com email inválido
    ${body}    Create Dictionary
    ...    nome=Fulano da Silva
    ...    email=email_invalido
    ...    password=123456
    ...    administrador=true
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Cadastrar usuário com payload grande
    ${nome_grande}    Generate Random String    
    ...    length=300    
    ...    chars=[LETTERS]
    ${email}    Generate Random String    
    ...    length=6    
    ...    chars=[LETTERS]
    ${body}    Create Dictionary
    ...    nome=${nome_grande}
    ...    email=${email}@email.com
    ...    password=123456
    ...    administrador=true
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Cadastrar usuário com domínio restrito
    ${palavra_aleatoria}    Generate Random String    
    ...    length=6    
    ...    chars=[LETTERS]
    Set Global Variable    ${email}    
    ...    ${palavra_aleatoria}@hotmail.com
    ${body}    Create Dictionary
    ...    nome=Fulano da Silva
    ...    email=${email}
    ...    password=123456
    ...    administrador=true
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}
    
    ${palavra_aleatoria2}    Generate Random String    
    ...    length=6    
    ...    chars=[LETTERS]
    Set Global Variable    ${email}   
    ...    ${palavra_aleatoria2}@gmail.com
    ${body2}    Create Dictionary
    ...    nome=Fulano da Silva
    ...    email=${email}
    ...    password=123456
    ...    administrador=true
    ${resposta2}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body2}
    ...    expected_status=400
    Log To Console    ${resposta2.json()}

Cadastrar usuário com senha menor que 5 caracteres
    ${palavra_aleatoria}    Generate Random String    
    ...    length=6    
    ...    chars=[LETTERS]
    Set Global Variable    ${email}    
    ...    ${palavra_aleatoria}@email.com
    ${body}    Create Dictionary
    ...    nome=Fulano da Silva
    ...    email=${email}
    ...    password=123
    ...    administrador=true
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Cadastrar usuário com senha maior que 10 caracteres
    ${palavra_aleatoria}    Generate Random String    
    ...    length=6    
    ...    chars=[LETTERS]
    Set Global Variable    ${email}    
    ...    ${palavra_aleatoria}@email.com
    ${body}    Create Dictionary
    ...    nome=Fulano da Silva
    ...    email=${email}
    ...    password=12345678901234567890
    ...    administrador=true
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}