*** Settings ***
Library     RequestsLibrary
Library    String

*** Variables ***
${nome_produto}    
${preco}    
${descricao}    
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

Cadastrar produto válido
    ${palavra_aleatoria}    Generate Random String    
    ...    length=6    
    ...    chars=[LETTERS]
    Set Global Variable    ${nome_produto}    
    ...    Produto ${palavra_aleatoria}
    Set Global Variable    ${preco}    100
    Set Global Variable    ${descricao}    Descrição do produto
    Set Global Variable    ${quantidade}    10
    ${body}    Create Dictionary
    ...    nome=${nome_produto}
    ...    preco=${preco}
    ...    descricao=${descricao}
    ...    quantidade=${quantidade}
    ${headers}    Create Dictionary    Authorization=${token}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/produtos
    ...    json=${body}
    ...    headers=${headers}
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
    ${headers}    Create Dictionary    Authorization=${token}
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/produtos
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=400
    Log To Console    ${resposta.json()}

Excluir produto presente em carrinho
    # Primeiro cadastra um produto
    ${palavra_aleatoria}    Generate Random String    length=6    chars=[LETTERS]
    ${body_produto}    Create Dictionary
    ...    nome=Produto ${palavra_aleatoria}
    ...    preco=100
    ...    descricao=Produto para teste de exclusão
    ...    quantidade=10
    ${headers}    Create Dictionary    Authorization=${token}
    ${resposta_produto}    POST On Session
    ...    alias=ServeRest
    ...    url=/produtos
    ...    json=${body_produto}
    ...    headers=${headers}
    ${produto_response}    Set Variable    ${resposta_produto.json()}
    ${produto_id}    Set Variable    ${produto_response['_id']}
    
    Run Keyword And Ignore Error    DELETE On Session
    ...    alias=ServeRest
    ...    url=/carrinhos/cancelar-compra
    ...    headers=${headers}

    ${produto_carrinho}    Create Dictionary    idProduto=${produto_id}    quantidade=1
    ${produtos_list}    Create List    ${produto_carrinho}
    ${body_carrinho}    Create Dictionary    produtos=${produtos_list}
    ${resposta_carrinho}    POST On Session
    ...    alias=ServeRest
    ...    url=/carrinhos
    ...    json=${body_carrinho}
    ...    headers=${headers}
    
    ${resposta}    DELETE On Session
    ...    alias=ServeRest
    ...    url=/produtos/${produto_id}
    ...    headers=${headers}
    ...    expected_status=400
    Log To Console    ${resposta.json()}