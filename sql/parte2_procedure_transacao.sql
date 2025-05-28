DELIMITER $$

CREATE PROCEDURE TransferenciaComVerificacao(
    IN contaOrigem INT,
    IN contaDestino INT,
    IN valor DECIMAL(10,2)
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        INSERT INTO log_transferencias(conta_origem, conta_destino, valor, status)
        VALUES (contaOrigem, contaDestino, valor, 'Erro: rollback executado');
        SELECT 'Erro detectado. Rollback executado.' AS status;
    END;

    START TRANSACTION;

    -- Verificar existência das contas
    IF NOT EXISTS (SELECT 1 FROM contas WHERE id = contaOrigem) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta de origem inexistente';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM contas WHERE id = contaDestino) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta de destino inexistente';
    END IF;

    -- Debitar
    SAVEPOINT antes_debito;
    UPDATE contas SET saldo = saldo - valor WHERE id = contaOrigem;

    -- Verificar saldo insuficiente
    IF (SELECT saldo FROM contas WHERE id = contaOrigem) < 0 THEN
        ROLLBACK TO antes_debito;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
    END IF;

    -- Creditar
    SAVEPOINT antes_credito;
    UPDATE contas SET saldo = saldo + valor WHERE id = contaDestino;

    -- Registro no log
    INSERT INTO log_transferencias(conta_origem, conta_destino, valor, status)
    VALUES (contaOrigem, contaDestino, valor, 'Transferência realizada com sucesso');

    -- Confirma transação
    COMMIT;

    SELECT 'Transferência realizada com sucesso.' AS status;
END$$

DELIMITER ;
