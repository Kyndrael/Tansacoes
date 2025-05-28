CREATE TABLE IF NOT EXISTS log_transferencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    conta_origem INT,
    conta_destino INT,
    valor DECIMAL(10,2),
    status VARCHAR(100),
    data_transferencia DATETIME DEFAULT CURRENT_TIMESTAMP
);
