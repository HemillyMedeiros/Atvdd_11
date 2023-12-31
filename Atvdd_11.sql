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

--1.5 Adicione um procedimento com parâmentro VARIADIC
CREATE OR REPLACE PROCEDURE cadastrar_clientes(VARIADIC nomes_clientes VARCHAR[])
LANGUAGE plpgsql
AS $$
DECLARE
    clientes_cadastrados TEXT;
BEGIN
    -- Lógica para inserir na tabela de clientes
    -- Exemplo: INSERT INTO tabela_clientes (nome) VALUES (nomes_clientes[i]);
    
    FOR i IN 1..array_length(nomes_clientes, 1) LOOP
        -- Lógica de inserção aqui
    END LOOP;

    clientes_cadastrados := 'Os clientes: ' || array_to_string(nomes_clientes, ', ') || ' foram cadastrados';
    
    RAISE NOTICE '%', clientes_cadastrados;
END;
$$;

--1.6 Bloco anônimo para cada procedimento:
DO $$

DECLARE
    total_pedidos INTEGER;

BEGIN
    -- Código para executar o procedimento 1.2
    PERFORM total_pedidos_cliente(123);

    -- Código para executar o procedimento 1.3
    CALL total_pedidos_cliente(123, total_pedidos);
    RAISE NOTICE 'O cliente possui % pedidos.', total_pedidos;

END $$;




