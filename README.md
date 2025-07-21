# 📦 ClassicModels SQL Project

Este repositório contém scripts SQL relacionados ao banco de dados **ClassicModels**, um modelo relacional clássico usado para fins educacionais. 
Ele é útil para praticar consultas SQL, modelagem relacional e integração com sistemas de informação.

🔗 [Acesse o desafio aqui](https://www.richardtwatson.com/open/Reader/ClassicModels.html#)

## 🧱 Estrutura do Banco de Dados

O banco de dados representa a empresa fictícia *Classic Models*, especializada na venda de produtos em miniatura, com operações de vendas, pedidos e logística realizados por meio de representantes comerciais.

### Principais Tabelas

- **Customers** – Informações sobre os clientes
- **Employees** – Dados dos funcionários e representantes de vendas
- **Offices** – Localização física dos escritórios
- **Orders** – Pedidos realizados pelos clientes
- **OrderDetails** – Itens de cada pedido
- **Products** – Catálogo de produtos vendidos
- **ProductLines** – Categorias dos produtos
- **Payments** – Registros de pagamentos dos clientes

As relações seguem uma modelagem relacional com chaves primárias e estrangeiras bem definidas.

📊 Veja o diagrama ER:  
([ClassicModels-relacionamento.png](https://github.com/thaishagler/SQL-Solutions/blob/main/ER/ClassicModels-relacionamento.png))

---

## 📂 Conteúdo dos Arquivos

| Arquivo | Descrição |
|--------|-----------|
| cria.sql | Criação das tabelas e relacionamentos |
| apaga.sql | Script para remoção das tabelas (drop) |
| One to many relationship.sql | Exemplos de relacionamentos 1:N |
| SINGLE-ENTITY.sql | Consultas com base em uma única entidade |

---

## ▶️ Como usar

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/classicmodels-sql.git
cd classicmodels-sql
