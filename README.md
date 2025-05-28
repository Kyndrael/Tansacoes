# Projeto: Transações e Backup no MySQL

Este projeto demonstra o uso de transações SQL, procedures com tratamento de erro e operações de backup e restore utilizando `mysqldump`.

## 📁 Estrutura

- `sql/parte1_transacoes.sql`: Transações manuais com `START TRANSACTION`, `COMMIT`, `ROLLBACK`
- `sql/parte2_procedure_transacao.sql`: Procedure com savepoints e verificação de saldo
- `backup/backup_e_commerce.sql`: Backup do banco `e_commerce` com rotinas e eventos

## 🛠️ Execução

### 1. Executar transação manual
```sql
SOURCE sql/parte1_transacoes.sql;
