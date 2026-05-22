-- StockHub - schema PostgreSQL.
-- Execute este script no banco poow1 para recriar as tabelas usadas pelo projeto.

-- Usuario usado pelo login e controle de sessao.
CREATE TABLE usuario (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(160) NOT NULL UNIQUE,
    senha VARCHAR(120) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

-- Categoria organiza os produtos do estoque. A imagem e opcional.
CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    descricao TEXT,
    imagem VARCHAR(255)
);

-- Produto possui chave estrangeira para categoria.
CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(160) NOT NULL,
    descricao TEXT,
    preco NUMERIC(10, 2) NOT NULL DEFAULT 0,
    quantidade INTEGER NOT NULL DEFAULT 0,
    estoque_minimo INTEGER NOT NULL DEFAULT 0,
    imagem VARCHAR(255),
    categoria_id INTEGER NOT NULL,
    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categoria(id)
        ON DELETE RESTRICT,
    CONSTRAINT ck_produto_preco
        CHECK (preco >= 0),
    CONSTRAINT ck_produto_quantidade
        CHECK (quantidade >= 0),
    CONSTRAINT ck_produto_estoque_minimo
        CHECK (estoque_minimo >= 0)
);

-- Indices simples para melhorar listagens, filtros e dashboard.
CREATE INDEX idx_produto_categoria ON produto(categoria_id);
CREATE INDEX idx_produto_nome ON produto(nome);
CREATE INDEX idx_categoria_nome ON categoria(nome);

-- Usuario de teste.
-- Login: teste@teste
-- Senha: 123
INSERT INTO usuario (nome, email, senha, ativo)
VALUES ('Usuario Teste', 'teste@teste', '123', TRUE);

-- Categorias de exemplo para testar os CRUDs.
INSERT INTO categoria (nome, descricao, imagem)
VALUES
    ('Eletronicos', 'Produtos eletronicos e acessorios para venda rapida.', NULL),
    ('Papelaria', 'Materiais escolares e itens de escritorio.', NULL),
    ('Bebidas', 'Bebidas para conveniencia e pequeno varejo.', NULL);

-- Produtos de exemplo com relacionamento real com categoria.
INSERT INTO produto (nome, descricao, preco, quantidade, estoque_minimo, imagem, categoria_id)
VALUES
    ('Mouse sem fio', 'Mouse compacto com conexao USB.', 79.90, 12, 5, NULL, 1),
    ('Caderno universitario', 'Caderno 10 materias capa dura.', 24.50, 4, 8, NULL, 2),
    ('Garrafa de agua', 'Agua mineral 500ml.', 3.50, 30, 10, NULL, 3),
    ('Teclado mecanico', 'Teclado compacto com iluminacao.', 189.90, 2, 3, NULL, 1);
