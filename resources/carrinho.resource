*** Settings ***
Library     RequestsLibrary
Library    String

*** Variables ***
${produto_id}    
${quantidade}
${token}

*** Keywords ***

Fazer login e obter token
    ${body}    Create Dictionary
    ...    email=fulano@qa.com
    ...    password=teste
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/login
    ...    json=${body}
    ${token_response}    Set Variable    ${resposta.json()}
    Set Global Variable    ${token}    ${token_response['authorization']}
    Log To Console    Token obtido: ${token}

Adicionar produto válido ao carrinho
    ${palavra_aleatoria}    Generate Random String    length=6    chars=[LETTERS]
    ${body_produto}    Create Dictionary
    ...    nome=Produto ${palavra_aleatoria}
    ...    preco=100
    ...    descricao=Produto para carrinho
    ...    quantidade=10
    ${headers}    Create Dictionary    Authorization=${token}
    ${resposta_produto}    POST On Session
    ...    alias=ServeRest
    ...    url=/produtos
    ...    json=${body_produto}
    ...    headers=${headers}
    ${produto_response}    Set Variable    ${resposta_produto.json()}
    Set Global Variable    ${produto_id}    ${produto_response['_id']}
    
    Run Keyword And Ignore Error    DELETE On Session
    ...    alias=ServeRest
    ...    url=/carrinhos/cancelar-compra
    ...    headers=${headers}
    
    Set Global Variable    ${quantidade}    2
    ${produto}    Create Dictionary    idProduto=${produto_id}    quantidade=${quantidade}
    ${produtos_list}    Create List    ${produto}
    ${body}    Create Dictionary    produtos=${produtos_list}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body}
    ...    headers=${headers}
    Log To Console    ${resposta.json()}

Adicionar produto com quantidade inválida
    ${headers}    Create Dictionary    Authorization=${token}
    Run Keyword And Ignore Error    DELETE On Session
    ...    alias=ServeRest
    ...    url=/carrinhos/cancelar-compra
    ...    headers=${headers}
    
    Set Global Variable    ${produto_id}    BeeJh5lz3k6kSIzA
    Set Global Variable    ${quantidade}    -1
    ${produto}    Create Dictionary    idProduto=${produto_id}    quantidade=${quantidade}
    ${produtos_list}    Create List    ${produto}
    ${body}    Create Dictionary    produtos=${produtos_list}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Adicionar produto com payload grande
    Set Global Variable    ${produto_id}    BeeJh5lz3k6kSIzA  #id fixo da api
    Set Global Variable    ${quantidade}    999999999
    ${produto}    Create Dictionary    idProduto=${produto_id}    quantidade=${quantidade}
    ${produtos_list}    Create List    ${produto}
    ${body}    Create Dictionary    produtos=${produtos_list}
    ${headers}    Create Dictionary    Authorization=${token}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Remover produto do carrinho
    ${headers}    Create Dictionary    Authorization=${token}
    ${resposta}    DELETE On Session
    ...    alias=ServeRest
    ...    url=/carrinhos/cancelar-compra
    ...    headers=${headers}
    Log To Console    ${resposta.json()}

Tentar adicionar produto inexistente
    Set Global Variable    ${produto_id}    produto_inexistente_123
    Set Global Variable    ${quantidade}    1
    ${produto}    Create Dictionary    idProduto=${produto_id}    quantidade=${quantidade}
    ${produtos_list}    Create List    ${produto}
    ${body}    Create Dictionary    produtos=${produtos_list}
    ${headers}    Create Dictionary    Authorization=${token}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=400
    Log To Console    ${resposta.json()}