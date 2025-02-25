INSERT INTO staging.acidentes (data_inversa, dia_semana, horario, uf, br, km, municipio, causa_acidente, tipo_acidente, classificacao_acidente, fase_dia, 
sentido_via, condicao_metereologica, tipo_pista, tracado_via, pessoas, mortos, feridos_leves, feridos_graves, ilesos, ignorados, 
feridos, veiculos, latitude, longitude, regional, delegacia)
SELECT   CAST(data_inversa AS DATE),
    dia_semana,
    CAST(horario AS TIME),
    uf,
    CAST(br AS NUMERIC(10, 2)),
    CAST(REPLACE(km, ',', '.') AS NUMERIC(10, 2)),
    municipio,
    causa_acidente,
    tipo_acidente,
    classificacao_acidente,
    fase_dia,
    sentido_via,
    condicao_metereologica,
    tipo_pista,
    tracado_via,
    CAST(pessoas AS INT),
    CAST(mortos AS INT),
    CAST(feridos_leves AS INT),
    CAST(feridos_graves AS INT),
    CAST(ilesos AS INT),
    CAST(ignorados AS INT),
    CAST(feridos AS INT),
    CAST(veiculos AS INT),
    CAST(latitude AS DOUBLE PRECISION),
    CAST(longitude AS DOUBLE PRECISION),
    regional,
    delegacia
FROM raw.acidentes
WHERE data_inversa >= '01-01-2021' 

-- DELETE FROM datawarehouse.dim_tempo 
INSERT INTO datawarehouse.dim_tempo (dia_semana, horario, fase_dia)
SELECT DISTINCT dia_semana, horario, fase_dia
FROM staging.acidentes;

-- DELETE FROM datawarehouse.dim_localizacao
INSERT INTO datawarehouse.dim_localizacao (uf, br, km, municipio, regional)
SELECT DISTINCT uf, br, km, municipio, regional
FROM staging.acidentes;
--80491

-- DELETE FROM datawarehouse.dim_pista
INSERT INTO datawarehouse.dim_pista (sentido_via, tipo_pista, tracado_via)
SELECT DISTINCT sentido_via, tipo_pista, tracado_via
FROM staging.acidentes; --85 LINHAS

-- DELETE FROM datawarehouse.dim_acidente
INSERT INTO datawarehouse.dim_acidente (causa_acidente, tipo_acidente, classificacao_acidente)
SELECT DISTINCT causa_acidente, tipo_acidente, classificacao_acidente
FROM staging.acidentes; --2845 LINHAS


-- DELETE FROM datawarehouse.fato_acidentes 
INSERT INTO datawarehouse.fato_acidentes 
(   
	id_acidente,
    id_tempo,
    id_localizacao,
	id_pista,
	data_inversa,
    condicao_metereologica,
    pessoas ,
    mortos ,
    feridos_leves ,
    feridos_graves ,
    ilesos ,
    ignorados ,
    feridos ,
    veiculos ,
    delegacia
)
SELECT
    d.id_acidente,
    t.id_tempo,
    l.id_localizacao,
	p.id_pista,
	s.data_inversa,
    condicao_metereologica,
    pessoas ,
    mortos ,
    feridos_leves ,
    feridos_graves ,
    ilesos ,
    ignorados ,
    feridos ,
    veiculos ,
    delegacia
FROM staging.acidentes s
LEFT JOIN datawarehouse.dim_acidente d ON s.causa_acidente = d.causa_acidente
LEFT JOIN datawarehouse.dim_tempo t ON s.dia_semana = t.dia_semana
LEFT JOIN datawarehouse.dim_localizacao l ON s.uf = l.uf
INNER JOIN datawarehouse.dim_pista p ON s.tipo_pista = p.tipo_pista 
AND s.tipo_acidente = d.tipo_acidente
AND s.classificacao_acidente = d.classificacao_acidente
--tempo
AND s.horario = t.horario
AND s.fase_dia = t.fase_dia
--localizacao
AND s.br = l.br
AND s.km = l.km
AND s.municipio = l.municipio
AND s.regional = l.regional
--pista 
AND s.sentido_via = p.sentido_via
AND s.tracado_via = p.tracado_via
--173121




