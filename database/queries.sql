-- VETFLOW - CONSULTAS SQL
-- Consultas para validacao do banco de dados

-- CONSULTA 01
-- Lista os animais e seus respectivos tutores.

SELECT
    a.id_animal,
    a.nome AS nome_animal,
    a.especie,
    a.raca,
    t.nome AS nome_tutor,
    t.telefone
FROM animais a
INNER JOIN tutores t
    ON a.id_tutor = t.id_tutor
ORDER BY a.nome;


-- CONSULTA 02
-- Historico de consultas e atendimentos dos animais.

SELECT
    a.nome AS nome_animal,
    t.nome AS nome_tutor,
    v.nome AS nome_veterinario,
    c.data_hora,
    c.tipo_consulta,
    c.status,
    at.diagnostico,
    at.procedimentos
FROM consultas c
INNER JOIN animais a
    ON c.id_animal = a.id_animal
INNER JOIN tutores t
    ON a.id_tutor = t.id_tutor
INNER JOIN veterinarios v
    ON c.id_veterinario = v.id_veterinario
LEFT JOIN atendimentos at
    ON c.id_consulta = at.id_consulta
ORDER BY c.data_hora DESC;


-- CONSULTA 03
-- Lista as consultas agendadas dos veterinarios.

SELECT
    c.id_consulta,
    v.nome AS nome_veterinario,
    a.nome AS nome_animal,
    t.nome AS nome_tutor,
    t.telefone,
    c.data_hora,
    c.tipo_consulta,
    c.status,
    c.motivo
FROM consultas c
INNER JOIN veterinarios v
    ON c.id_veterinario = v.id_veterinario
INNER JOIN animais a
    ON c.id_animal = a.id_animal
INNER JOIN tutores t
    ON a.id_tutor = t.id_tutor
WHERE c.status = 'AGENDADA'
ORDER BY c.data_hora ASC;


-- CONSULTA 04
-- Pesquisa de animais pelo nome OU pelo nome do tutor.

SELECT
    a.id_animal,
    a.nome AS nome_animal,
    a.especie,
    a.raca,
    t.nome AS nome_tutor,
    t.telefone
FROM animais a
INNER JOIN tutores t
    ON a.id_tutor = t.id_tutor
WHERE
    a.nome ILIKE '%Luna%'
    OR t.nome ILIKE '%Maria%'
ORDER BY a.nome;

-- CONSULTA 05
-- Quantidade total de consultas por veterinario.

SELECT
    v.id_veterinario,
    v.nome AS nome_veterinario,
    COUNT(c.id_consulta) AS total_consultas
FROM veterinarios v
LEFT JOIN consultas c
    ON v.id_veterinario = c.id_veterinario
GROUP BY
    v.id_veterinario,
    v.nome
ORDER BY total_consultas DESC;

