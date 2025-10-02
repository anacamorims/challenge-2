*** Settings ***
Library     RequestsLibrary
Library    String

*** Variables ***
${nome_produto}    
${preco}    
${descricao}    
${quantidade}    

*** Keywords ***

Cadastrar produto válido
    ${palavra_aleatoria}    Generate Random String    length=6    chars=[LETTERS]
    Set Global Variable    ${nome_produto}    Produto ${palavra_aleatoria}
    Set Global Variable    ${preco}    100
    Set Global Variable    ${descricao}    Descrição do produto
    Set Global Variable    ${quantidade}    10
    ${body}    Create Dictionary
    ...    nome=${nome_produto}
    ...    preco=${preco}
    ...    descricao=${descricao}
    ...    quantidade=${quantidade}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/produtos
    ...    json=${body}
    Log To Console    ${resposta.json()}

Cadastrar produto com preço negativo
    ${palavra_aleatoria}    Generate Random String    length=6    chars=[LETTERS]
    Set Global Variable    ${nome_produto}    Produto ${palavra_aleatoria}
    Set Global Variable    ${preco}    -50
    Set Global Variable    ${descricao}    Descrição do produto
    Set Global Variable    ${quantidade}    10
    ${body}    Create Dictionary
    ...    nome=${nome_produto}
    ...    preco=${preco}
    ...    descricao=${descricao}
    ...    quantidade=${quantidade}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/produtos
    ...    json=${body}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Excluir produto presente em carrinho
    ${produto_id}    Set Variable    BeeJh5lz3k6kSIzA
    ${resposta}    DELETE On Session
    ...    alias=ServeRest
    ...    url=/produtos/${produto_id}
    ...    expected_status=400
    Log To Console    ${resposta.json()}