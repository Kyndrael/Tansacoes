-- Criação da tabela de contas
CREATE TABLE IF NOT EXISTS contas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titular VARCHAR(100),
    saldo DECIMAL(10,2) DEFAULT 0.00
);

-- Inserindo dados fictícios para teste
INSERT INTO contas (titular, saldo) VALUES
('João', 1000.00),
('Maria', 500.00);

-- Criação da tabela de log para registrar transferências
CREATE TABLE IF NOT EXISTS log_transferencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    conta_origem INT,
    conta_destino INT,
    valor DECIMAL(10,2),
    status VARCHAR(100),
    data_transferencia DATETIME DEFAULT CURRENT_TIMESTAMP
);
