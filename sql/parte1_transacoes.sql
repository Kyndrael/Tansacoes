-- Desabilita o autocommit
SET autocommit = 0;

START TRANSACTION;

-- Exemplo de movimentação bancária
UPDATE contas SET saldo = saldo - 500 WHERE id = 1;
UPDATE contas SET saldo = saldo + 500 WHERE id = 2;

COMMIT;
