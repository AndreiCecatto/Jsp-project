# StockHub

Sistema Java Web para controle de estoque de pequena loja.

## Tecnologias

- Java
- JSP e Servlet
- JDBC
- PostgreSQL
- Maven
- Bootstrap 5
- Bootstrap Icons
- HTML, CSS e JavaScript simples quando necessario

## Como configurar o banco

1. Crie ou use o banco PostgreSQL chamado `poow1`.
2. Confirme no arquivo `src/main/java/dao/ConectaDBPostgres.java`:
   - usuario: `postgres`
   - senha: `1234`
   - banco: `poow1`
3. Execute o script:

```sql
src/main/resources/database/schema.sql
```

Login de teste:

- E-mail: `teste@teste`
- Senha: `123`

## Funcionalidades

- Login com sessao
- Dashboard com dados reais do banco
- CRUD de produtos
- CRUD de categorias
- Upload opcional de imagens
- Tela de estoque baixo
- Relacionamento entre produto e categoria
