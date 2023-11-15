--1.1 Adicione a tabela de log
CREATE TABLE log_restaurante (
    log_id SERIAL PRIMARY KEY,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nome_procedimento VARCHAR(255)
);

--1.2 Adicione um procedimento
CREATE OR REPLACE PROCEDURE total_pedidos_cliente(p_codigo_cliente INTEGER)
AS
    total_pedidos INTEGER;
BEGIN
    -- Lógica para calcular o total de pedidos
    SELECT COUNT(*) INTO total_pedidos
    FROM pedidos
    WHERE codigo_cliente = p_codigo_cliente;

    RAISE NOTICE 'O cliente possui % pedidos.', total_pedidos;
END;

