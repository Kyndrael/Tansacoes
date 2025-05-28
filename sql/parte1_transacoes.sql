-- Desabilita autocommit
SET autocommit = 0;

-- Inicia transação
START TRANSACTION;

-- Transferência de R$100 da conta 1 para a conta 2
UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas SET saldo = saldo + 100 WHERE id = 2;

-- Finaliza transação
COMMIT;

-- Para desfazer, usar:
-- ROLLBACK;
