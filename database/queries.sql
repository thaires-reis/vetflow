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
