--1.1 Adicione a tabela de log
CREATE TABLE log_restaurante (
    log_id SERIAL PRIMARY KEY,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nome_procedimento VARCHAR(255)
);

