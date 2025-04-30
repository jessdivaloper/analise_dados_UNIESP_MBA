# 📊 Projeto Data Warehouse – Análise de Acidentes de Trânsito no Brasil

## 📌 Descrição do Projeto

Este projeto tem como objetivo a construção de um Data Warehouse para análise dos acidentes de trânsito registrados no Brasil entre 2021 e 2023. A solução utiliza Pentaho, Python e Pandas para realizar o ETL (extração, transformação e carga dos dados) e o PostgreSQL para armazenamento estruturado. A visualização e análise dos dados são feitas no Power BI.

A base de dados inicial contém aproximadamente 173.121 mil registros e foi disponibilizada em formato CSV no site [Kaggle](https://www.kaggle.com/datasets/mlippo/car-accidents-in-brazil-2017-2023). O projeto segue uma abordagem baseada em modelagem dimensional, utilizando tabelas fato e dimensões para facilitar a análise dos dados.


## 🎯 Objetivos

- Implementar um pipeline ETL eficiente utilizando Pentaho e PostgreSQL.
- Modelar um Data Warehouse utilizando o Pentaho PostgreSQL.
- Criar dashboards interativos e informativos no Power BI.

## 🔧 Tecnologias Utilizadas

- Python → Inserção dos dados no banco de dados
- Pentaho → Integração com o banco de dados, criação do pipeline que limpa e transforma os dados. Os dados são modelados de acordo com o *star schema* e são inseridos no banco de dados.
- PostgreSQL → Armazenamento dos dados no Data Warehouse
- Power BI → Visualização e análise dos dados

## 🛠️ Passo a Passo da Implementação

1) **Extração dos Dados e Carga dos Dados** 
    Leitura do arquivo CSV utilizando Pandas e psycopg2 e conexão com o banco de dados postgres. Para essa etapa os procedimentos abaixo foram realizados:
    - Criação dos schemas e tabelas no banco de dados com o [script SQL](carregar_dados.ipynb)
    - Leitura do arquivo csv no notebook
    - Conexão com o banco de dados Postgres
    - Ingestão dos dados na tabela *raw.acidentes*. 

2) **Transformação de dados:**
    - O processo de transformação foi realizado utilizando Pentaho Data Integration
    - Após a ingestão dos dados o próximo passo foi transformar o tipo dos dados como datas e numéricos e inserir eles na tabela *staging.acidentes*
    - [Um script SQL]() foi usado para remover as linhas duplicadas
    - As colunas *data_inversa* e *tipo_acidente* não podem ser vazias ou nulas pois são essenciais para o registro, por isso, a validação foi [realizada via SQL]().
    - Nas colunas XXX e Delegacia os dados nulos foram alterados para o valor 'Não Informado' garantindo a padronização dos dados.
    - Os dados da tabela *staging.acidentes* foram transformados e inseridos nas tabelas referente ao fato e as dimensões. Sendo elas:
        - datawarehouse.dim_tempo
        - datawarehouse.dim_localizacao
        - datawarehouse.dim_pista
        - datawarehouse.dim_acidente
        - datawarehouse.fato_acidentes
    

3) **Análise e Visualização:**

    - Modelagem dimensional e criação de tabelas fato e dimensão.
    - Conexão do Power BI ao PostgreSQL.
    - Criação de métricas, agregações e gráficos interativos.
   -  Desenvolvimento de relatórios e painéis de análise.

## Modelagem Dimensional - Esquema Estrela

Um esquema em estrela é um modelo multidimensional que organiza os dados em um banco de dados para torná-los mais fáceis de entender e analisar. O design do esquema em estrela é otimizado para consultar grandes conjuntos de dados. A imagem abaixo ilustra os dados após a modelagem.

![alt text](img\modelagem_dimensional.PNG)


## 📊 Storytelling e Análises

Os dados analisados ajudaram a responder as perguntas abaixo:

1) Quais estados brasileiros registraram mais acidentes ao longo dos anos?

    Os estados que apresentam maior quantidade de acidentes são 
    - 2021: MG
            SC
            PR
            
    - 2022:
    - 2023:

2) Qual o impacto das condições climáticas na quantidade de acidentes?
3) Há um padrão entre horário/dia da semana e número de acidentes?
4) Quais são os tipos de acidentes mais frequentes?

A partir dessas análises, o projeto busca fornecer insights valiosos que podem contribuir para a melhoria da segurança no trânsito e ajudar na definição de políticas públicas mais eficazes.

[Arquivos SQL](carregar_dados.ipynb)

## Power BI


![dashboard1](https://github.com/user-attachments/assets/c4f23e53-f90b-4d4b-b18b-78a70243ca1f)

![dashboard2](https://github.com/user-attachments/assets/5185eece-0f82-4d08-976c-a2519109cbc0)

