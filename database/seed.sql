
-- ============================================
-- VETFLOW - DADOS FICTICIOS PARA TESTES
-- Total previsto: 300 registros
-- ============================================

BEGIN;

-- 1. USUARIOS: 12 registros
INSERT INTO usuarios (nome, email, senha_hash, perfil)
SELECT
    'Usuario ' || g,
    'usuario' || g || '@vetflow.com',
    'HASH_DEMO_' || g,
    CASE
        WHEN g = 1 THEN 'ADMIN'
        ELSE 'FUNCIONARIO'
    END
FROM generate_series(1, 12) AS g;

-- 2. TUTORES: 30 registros
INSERT INTO tutores (nome, cpf, telefone, email, endereco)
SELECT
    'Tutor ' || g,
    LPAD(g::TEXT, 11, '0'),
    '(19) 90000-' || LPAD(g::TEXT, 4, '0'),
    'tutor' || g || '@email.com',
    'Rua Exemplo, ' || g
FROM generate_series(1, 30) AS g;

-- 3. ANIMAIS: 60 registros
INSERT INTO animais (
    id_tutor, nome, especie, raca, sexo, data_nascimento, peso
)
SELECT
    ((g - 1) % 30) + 1,
    'Animal ' || g,
    CASE
        WHEN g % 3 = 0 THEN 'Coelho'
        WHEN g % 2 = 0 THEN 'Gato'
        ELSE 'Cachorro'
    END,
    'Raca ' || g,
    CASE WHEN g % 2 = 0 THEN 'F' ELSE 'M' END,
    DATE '2020-01-01' + (g * 10),
    2.00 + (g * 0.35)
FROM generate_series(1, 60) AS g;

-- 4. VETERINARIOS: 10 registros
INSERT INTO veterinarios (
    id_usuario, nome, crmv, telefone
)
SELECT
    g,
    'Veterinario ' || g,
    'CRMV-SP-' || LPAD(g::TEXT, 5, '0'),
    '(19) 98888-' || LPAD(g::TEXT, 4, '0')
FROM generate_series(1, 10) AS g;

-- 5. ESPECIALIDADES: 8 registros
INSERT INTO especialidades (nome, descricao)
VALUES
    ('Clinica Geral', 'Atendimento clinico geral'),
    ('Dermatologia', 'Tratamento de problemas de pele'),
    ('Cardiologia', 'Cuidados com o coracao'),
    ('Ortopedia', 'Tratamento do sistema locomotor'),
    ('Oftalmologia', 'Cuidados com os olhos'),
    ('Neurologia', 'Tratamento neurologico'),
    ('Odontologia', 'Cuidados com a saude bucal'),
    ('Oncologia', 'Tratamento de tumores');

-- 6. VETERINARIO_ESPECIALIDADES: 20 registros
INSERT INTO veterinario_especialidades (
    id_veterinario, id_especialidade
)
SELECT
    ((g - 1) % 10) + 1,
    ((g - 1) % 8) + 1
FROM generate_series(1, 20) AS g;

-- 7. CONSULTAS INICIAIS: 80 registros
INSERT INTO consultas (
    id_animal, id_veterinario, tipo_consulta,
    data_hora, status, motivo
)
SELECT
    ((g - 1) % 60) + 1,
    ((g - 1) % 10) + 1,
    'INICIAL',
    CURRENT_TIMESTAMP + (g * INTERVAL '1 day'),
    CASE
        WHEN g <= 60 THEN 'REALIZADA'
        ELSE 'AGENDADA'
    END,
    'Consulta inicial de rotina'
FROM generate_series(1, 80) AS g;

-- 8. CONSULTAS DE RETORNO: 20 registros
INSERT INTO consultas (
    id_animal, id_veterinario, id_consulta_origem,
    tipo_consulta, data_hora, status, motivo
)
SELECT
    c.id_animal,
    c.id_veterinario,
    c.id_consulta,
    'RETORNO',
    CURRENT_TIMESTAMP + ((100 + g) * INTERVAL '1 day'),
    'AGENDADA',
    'Retorno para acompanhamento'
FROM generate_series(1, 20) AS g
JOIN consultas c ON c.id_consulta = g;

-- 9. ATENDIMENTOS: 60 registros
INSERT INTO atendimentos (
    id_consulta, diagnostico, procedimentos, observacoes
)
SELECT
    g,
    'Diagnostico de teste ' || g,
    'Procedimento de teste ' || g,
    'Registro ficticio para validacao do sistema'
FROM generate_series(1, 60) AS g;

COMMIT;

