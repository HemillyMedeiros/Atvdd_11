--1.1 Adicione a tabela de log
CREATE TABLE log_restaurante (
    log_id SERIAL PRIMARY KEY,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nome_procedimento VARCHAR(255)
);

--1.2 Adicione um procedimento
CREATE OR REPLACE PROCEDURE total_pedidos_cliente(p_codigo_cliente INTEGER)
LANGUAGE plpgsql
AS $$ 
DECLARE
    total_pedidos INTEGER;
BEGIN
    -- Lógica para calcular o total de pedidos
    SELECT COUNT(*) INTO total_pedidos
    FROM pedidos
    WHERE codigo_cliente = p_codigo_cliente;

    RAISE NOTICE 'O cliente possui % pedidos.', total_pedidos;
END;
$$

--1.3: Reescreva o exercício 1.2:
-- Drop do procedimento existente
DROP PROCEDURE IF EXISTS total_pedidos_cliente(integer);

-- Criação do novo procedimento
CREATE OR REPLACE PROCEDURE total_pedidos_cliente(p_codigo_cliente INTEGER, OUT p_total_pedidos INTEGER)
AS $$ 
BEGIN
    -- Lógica para calcular o total de pedidos
    SELECT COUNT(*) INTO p_total_pedidos
    FROM pedidos
    WHERE codigo_cliente = p_codigo_cliente;
END;
$$ LANGUAGE plpgsql;

--1.4 Adicione um procedimento INOUT:
CREATE OR REPLACE PROCEDURE total_pedidos_cliente_inout(INOUT p_codigo_cliente INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Lógica para calcular o total de pedidos
    SELECT COUNT(*) INTO p_codigo_cliente
    FROM pedidos
    WHERE codigo_cliente = p_codigo_cliente;
END;
$$
