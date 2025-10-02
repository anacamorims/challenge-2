*** Settings ***
Library     RequestsLibrary
Library    String

*** Variables ***
${email}    
${password}    

*** Keywords ***

Fazer login com credenciais válidas
    Set Global Variable    ${email}    fulano@qa.com
    Set Global Variable    ${password}    teste
    ${body}    Create Dictionary
    ...    email=${email}
    ...    password=${password}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/login
    ...    json=${body}
    Log To Console    ${resposta.json()}

Fazer login com senha incorreta
    Set Global Variable    ${email}    fulano@qa.com
    Set Global Variable    ${password}    senhaerrada
    ${body}    Create Dictionary
    ...    email=${email}
    ...    password=${password}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/login
    ...    json=${body}
    ...    expected_status=401
    Log To Console    ${resposta.json()}

Fazer login com campos vazios
    Set Global Variable    ${email}    
    Set Global Variable    ${password}    
    ${body}    Create Dictionary
    ...    email=${email}
    ...    password=${password}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/login
    ...    json=${body}
    ...    expected_status=401
    Log To Console    ${resposta.json()}

Fazer login com formato de email inválido
    Set Global Variable    ${email}    email_sem_arroba
    Set Global Variable    ${password}    teste
    ${body}    Create Dictionary
    ...    email=${email}
    ...    password=${password}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/login
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}