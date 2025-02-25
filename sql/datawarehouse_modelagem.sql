CREATE SCHEMA raw;
CREATE SCHEMA staging;
CREATE SCHEMA datawarehouse;

DROP TABLE IF EXISTS datawarehouse.fato_acidentes CASCADE;
DROP TABLE IF EXISTS datawarehouse.dim_tempo CASCADE;
DROP TABLE IF EXISTS datawarehouse.dim_localizacao CASCADE;
DROP TABLE IF EXISTS datawarehouse.dim_pista CASCADE;
DROP TABLE IF EXISTS datawarehouse.dim_acidente CASCADE;


-- DROP TABLE raw.acidentes;
CREATE TABLE raw.acidentes (
    data_inversa TEXT,
    dia_semana TEXT,
    horario TEXT,
    uf TEXT,
    br TEXT,
    km TEXT,
    municipio TEXT,
    causa_acidente TEXT,
    tipo_acidente TEXT,
    classificacao_acidente TEXT,
    fase_dia TEXT,
    sentido_via TEXT,
    condicao_metereologica TEXT,
    tipo_pista TEXT,
    tracado_via TEXT,
    pessoas INT,
    mortos INT,
    feridos_leves INT,
    feridos_graves INT,
    ilesos INT,
    ignorados INT,
    feridos INT,
    veiculos INT,
    latitude TEXT,
    longitude TEXT,
    regional TEXT,
    delegacia TEXT
);


--Criar Tabela Transformada no Schema staging
--Os dados são limpos e convertidos para tipos apropriados.
--DROP TABLE IF EXISTS staging.acidentes;
CREATE TABLE staging.acidentes (
    id SERIAL PRIMARY KEY,
    data_inversa DATE,
    dia_semana VARCHAR(20),
    horario TIME,
    uf VARCHAR(2),
    br NUMERIC(10, 2),
    km NUMERIC(10, 2),
    municipio VARCHAR(100),
    causa_acidente VARCHAR(255),
    tipo_acidente VARCHAR(255),
    classificacao_acidente VARCHAR(50),
    fase_dia VARCHAR(50),
    sentido_via VARCHAR(50),
    condicao_metereologica VARCHAR(50),
    tipo_pista VARCHAR(50),
    tracado_via VARCHAR(50),
    pessoas INT,
    mortos INT,
    feridos_leves INT,
    feridos_graves INT,
    ilesos INT,
    ignorados INT,
    feridos INT,
    veiculos INT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    regional VARCHAR(100),
    delegacia VARCHAR(100)
);


-- Criar as Tabelas Dimensão no Schema 
-- DROP TABLE IF EXISTS datawarehouse.dim_tempo CASCADE;
CREATE TABLE IF NOT EXISTS datawarehouse.dim_tempo
(
    id_tempo SERIAL PRIMARY KEY,
    dia_semana VARCHAR(30),
    horario TIME,
    fase_dia VARCHAR(50)
);


-- DROP TABLE IF EXISTS datawarehouse.dim_localizacao
CREATE TABLE IF NOT EXISTS datawarehouse.dim_localizacao
(
    id_localizacao SERIAL PRIMARY KEY,
    uf VARCHAR(3),
    br DOUBLE PRECISION,
    km DOUBLE PRECISION,
    municipio VARCHAR(100),
    regional VARCHAR(100)
); --312464

-- DROP TABLE IF EXISTS datawarehouse.dim_pista;
CREATE TABLE IF NOT EXISTS datawarehouse.dim_pista
(
    id_pista SERIAL PRIMARY KEY,
    sentido_via VARCHAR(50),
    tipo_pista VARCHAR(50),
    tracado_via VARCHAR(50)
);

-- DROP TABLE IF EXISTS datawarehouse.dim_acidente;
CREATE TABLE datawarehouse.dim_acidente (
    id_acidente SERIAL PRIMARY KEY,
    causa_acidente VARCHAR(255),
    tipo_acidente VARCHAR(255),
    classificacao_acidente VARCHAR(50)
);

-- DROP TABLE IF EXISTS datawarehouse.fato_acidentes;
CREATE TABLE datawarehouse.fato_acidentes (
    id_fato INT GENERATED ALWAYS AS IDENTITY,
    id_acidente INT REFERENCES datawarehouse.dim_acidente(id_acidente),
    id_tempo INT REFERENCES datawarehouse.dim_tempo(id_tempo),
    id_localizacao INT REFERENCES datawarehouse.dim_localizacao(id_localizacao),
    id_pista INT REFERENCES datawarehouse.dim_pista(id_pista),
    data_inversa TIMESTAMP,
    condicao_metereologica VARCHAR(100),
    pessoas INT,
    mortos INT,
    feridos_leves INT,
    feridos_graves INT,
    ilesos INT,
    ignorados INT,
    feridos INT,
    veiculos INT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    delegacia VARCHAR(100)
);

