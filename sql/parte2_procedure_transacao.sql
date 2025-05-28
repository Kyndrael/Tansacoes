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
        SELECT 'Erro detectado. Rollback executado.' AS status;
    END;

    START TRANSACTION;

    SAVEPOINT antes_debito;
    UPDATE contas SET saldo = saldo - valor WHERE id = contaOrigem;

    IF (SELECT saldo FROM contas WHERE id = contaOrigem) < 0 THEN
        ROLLBACK TO antes_debito;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
    END IF;

    SAVEPOINT antes_credito;
    UPDATE contas SET saldo = saldo + valor WHERE id = contaDestino;

    COMMIT;

    SELECT 'Transferência realizada com sucesso.' AS status;
END$$

DELIMITER ;
