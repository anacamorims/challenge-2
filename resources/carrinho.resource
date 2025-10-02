*** Settings ***
Library     RequestsLibrary
Library    String

*** Variables ***
${produto_id}    
${quantidade}    

*** Keywords ***

Adicionar produto válido ao carrinho
    Set Global Variable    ${produto_id}    BeeJh5lz3k6kSIzA
    Set Global Variable    ${quantidade}    2
    ${body}    Create Dictionary
    ...    produtos=[{"idProduto": "${produto_id}", "quantidade": ${quantidade}}]
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body}
    Log To Console    ${resposta.json()}

Adicionar produto com quantidade inválida
    Set Global Variable    ${produto_id}    BeeJh5lz3k6kSIzA
    Set Global Variable    ${quantidade}    -1
    ${body}    Create Dictionary
    ...    produtos=[{"idProduto": "${produto_id}", "quantidade": ${quantidade}}]
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Adicionar produto com payload grande
    Set Global Variable    ${produto_id}    BeeJh5lz3k6kSIzA
    Set Global Variable    ${quantidade}    999999999
    ${body}    Create Dictionary
    ...    produtos=[{"idProduto": "${produto_id}", "quantidade": ${quantidade}}]
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Remover produto do carrinho
    ${carrinho_id}    Set Variable    qbMqntef4iTOwWfg
    ${resposta}    DELETE On Session
    ...    alias=ServeRest
    ...    url=/carrinhos/cancelar-compra
    Log To Console    ${resposta.json()}

Tentar adicionar produto inexistente
    Set Global Variable    ${produto_id}    produto_inexistente_123
    Set Global Variable    ${quantidade}    1
    ${body}    Create Dictionary
    ...    produtos=[{"idProduto": "${produto_id}", "quantidade": ${quantidade}}]
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}