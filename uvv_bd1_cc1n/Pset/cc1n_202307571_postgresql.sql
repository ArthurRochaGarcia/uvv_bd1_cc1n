-- Usuário Criado

CREATE USER arthur WITH 
SUPERUSER 
CREATEROLE 
CREATEDB 
PASSWORD 'computacao@raiz' 
;

-- BD Criado

CREATE DATABASE uvv 
OWNER 'arthur' 
TEMPLATE 'template0' 
ENCODING 'UTF8' 
lc_collate 'pt_BR.UTF-8' 
lc_ctype 'pt_BR.UTF-8' 
allow_connections 'true'
;

--Conectando no BD com o usuário 'arthur'
\c uvv arthur;

-- Schema Criado 
CREATE SCHEMA IF NOT EXISTS lojas 
AUTHORIZATION arthur;

SELECT CURRENT_SCHEMA ();

-- Caminho do Schema

SET SEARCH_PATH TO lojas, "$user", public;

SHOW SEARCH_PATH;

ALTER USER arthur
SET SEARCH_PATH TO lojas, "$user", public;

-- Criando a Tabela Produtos



CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                detalhes BYTEA,
                preco_unitario NUMERIC(10,2),
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                imagem_charset VARCHAR(512),
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

-- Comentários da Tabela Produtos
COMMENT ON TABLE produtos IS 'Inclui informações sobre o(s) produto(s) da(s) loja(s)';
COMMENT ON COLUMN produtos.produto_id IS 'chave primaria da tabela produtos, se relaciona com a tabela pedidos_itens e com a tabela estoques';
COMMENT ON COLUMN produtos.nome IS 'inserir Nome do produto';
COMMENT ON COLUMN produtos.detalhes IS 'Inserir imagens que detalhe o produto.
Exemplo:Manual de utilização do produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'Inserir preco do produto em R$
Exemplo: R$ XX,XX';
COMMENT ON COLUMN produtos.imagem IS 'Inserir imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'informações do tipo de arquivo e formato da imagem do produto';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Arquivo da imagem do produto';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Ultima atualizacao da imagem do produto';
COMMENT ON COLUMN produtos.imagem_charset IS 'Denomina a codificação de caracteres.';

-- Criando a Tabela Lojas

CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                logitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_ultima_atualizacao DATE,
                logo_charset VARCHAR(512),
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

-- Comentários da Tabela Lojas 
COMMENT ON TABLE lojas IS 'Lojas uvv, contém o(s) dado(s) da Lojas UVV, endereco da loja (fisco e web), e dados de atualizacao.';
COMMENT ON COLUMN lojas.loja_id IS 'chave primaria da tabela lojas, se relaciona com as tabelas  pedidos, envios e estoques';
COMMENT ON COLUMN lojas.nome IS 'nome da loja';
COMMENT ON COLUMN lojas.endereco_web IS 'inserir o endereco_web (URL) da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Endereco onde se situa a loja.
Inserir: Rua (ou) Avenidade (ou) Rodovia e número';
COMMENT ON COLUMN lojas.latitude IS 'cordenadas geográfica (latitude). fundamentais para a localização exata na superfície do planeta Terra.';
COMMENT ON COLUMN lojas.logitude IS 'cordenadas geográfica (longitude). fundamentais para a localização exata na superfície do planeta Terra.';
COMMENT ON COLUMN lojas.logo IS 'Armazenar a imagem logo das Lojas UVV';
COMMENT ON COLUMN lojas.logo_mime_type IS 'informações do tipo de arquivo e formato da logo';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Arquivo da Logo da Loja';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Ultima atualizacao do logo da loja';
COMMENT ON COLUMN lojas.logo_charset IS 'Denomina a codificação de caracteres.';

-- Criando a Tabela Estoques

CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

-- Comentários da Tabela Estoques
COMMENT ON TABLE estoques IS 'Inclui informações sobre o(s) estoque(s) da(s) loja(s)
como o produto(s) e quantidade(s)';
COMMENT ON COLUMN estoques.estoque_id IS 'PK da tabela estoques.';
COMMENT ON COLUMN estoques.loja_id IS 'chave estrangeira da tabela lojas';
COMMENT ON COLUMN estoques.produto_id IS 'chave estrangeira da tabela produtos';
COMMENT ON COLUMN estoques.quantidade IS 'coluna de insercao da quantidade de um produto no estoque';

-- Criando a Tabela Clientes

CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

-- Comentários da Tabela Cliente

COMMENT ON TABLE clientes IS 'Tabela clientes, contem dados de todos os clientes da lojas uvv';
COMMENT ON COLUMN clientes.cliente_id IS 'chave primária da tabela Clientes, se relaciona com a tabela Envios e com a tabela pedidos';
COMMENT ON COLUMN clientes.email IS 'inserir email do cliente: exemplo@hotmail.com';
COMMENT ON COLUMN clientes.nome IS 'inserir nome do cliente das lojas uvv';
COMMENT ON COLUMN clientes.telefone1 IS 'telefone 1 limite 20 caractéres';
COMMENT ON COLUMN clientes.telefone2 IS 'telefone 2 limite 20 caractéres';
COMMENT ON COLUMN clientes.telefone3 IS 'telefone 2 limite 20 caractéres';

-- Criando a Tabela Estoques

CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

-- Comentário da tabela estoques

COMMENT ON TABLE envios IS 'Tabela Envios, contém os dados do envios, endereco de entrega, o destinatário da entrega e o status da entrega';
COMMENT ON COLUMN envios.envio_id IS 'chave primaria da tabela envios, se relaciona com as tabelas lojas e pedido_itens';
COMMENT ON COLUMN envios.loja_id IS 'chave estrangeira da tabela lojas.';
COMMENT ON COLUMN envios.cliente_id IS 'chave estrangeira da tabela clientes.';
COMMENT ON COLUMN envios.endereco_entrega IS 'Endereco onde será enviado.
Inserir: Rua (ou) Avenidade (ou) Rodovia e número.';
COMMENT ON COLUMN envios.status IS 'Inserir Status da Entrega. Para saber o processo do envio';

-- Criando a Tabela Pedidos

CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

-- Comentários da tabela pedidos

COMMENT ON TABLE pedidos IS 'Tabela pedidos, contém data e hora do pedido, com chaves estrangeiras de qual loja o pedido foi efetuado e qual cliente';
COMMENT ON COLUMN pedidos.pedido_id IS 'Chave Primaria da tabela pedidos, se relaciona com a tabela pedido_itens';
COMMENT ON COLUMN pedidos.data_hora IS 'Inserir data e hora do pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'chave estrangeira da tabela clientes.';
COMMENT ON COLUMN pedidos.loja_id IS 'Chave estrangeira da tabela loja';
COMMENT ON COLUMN pedidos.status IS 'Diz sobre o processo do pedido';

-- Criando a tabela pedidos_itens

CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2),
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id, produto_id)
);

-- comentários da tabela pedidos_itens

COMMENT ON TABLE pedidos_itens IS 'inclui informacoes do pedido+item';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'chave primaria estrangeira da tabela pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'chave primaria estrangeira da tabela produtos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'inserir numero da linha do pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Inserir preco do produto em R$
Exemplo: R$ XX,XX';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'quantidade de itens no pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'chave estrangeira da tabela pedidos';

-- Constraint da definição da FK entre as tabelas Produtos e Estoques

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraint da definição da FK entre as tabelas Produtos e Pedidos_Itens


ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraint da definição da FK entre as tabelas Lojas e Pedidos


ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraint da definição da FK entre as tabelas Lojas e Envios

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraint da definição da FK entre as tabelas Lojas e Estoques

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraint da definição da FK entre as tabelas Clientes e Pedidos


ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraint da definição da FK entre as tabelas Clientes e Envios

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraint da definição da FK entre as tabelas Envios e Pedidos_Itens

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraint da definição da FK entre as tabelas Pedidos e Pedidos_Itens

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CONSTRAINTS DE CHECAGEM PREÇO UNITARIO POSITIVO
ALTER TABLE produtos ADD CONSTRAINT check_preco_unitario_produtos
CHECK (preco_unitario > 0);

ALTER TABLE pedidos_itens ADD CONSTRAINT check_preco_unitario_pedidos_itens
CHECK (preco_unitario > 0);

-- CONSTRAINTS DE CHECAGEM DE STATUS DOS PEDIDOS E ENVIOS
ALTER TABLE pedidos ADD CONSTRAINT check_status_pedidos
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE envios ADD CONSTRAINT check_status_envios
CHECK (status IN ( 'CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));


-- CONSTRAINT DE CHECAGEM PARA ALTERNATIVA DE PREENCHIMENTO ENTRE ENDEREÇOS WEB E FĨSICO
ALTER TABLE lojas ADD CONSTRAINT check_endereco_lojas
CHECK ((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL));

-- CONSTRAINT DE QUANTIDADES POSITIVAS 
ALTER TABLE estoques ADD CONSTRAINT check_quantidade_estoques
CHECK (quantidade >= 0);

ALTER TABLE pedidos_itens ADD CONSTRAINT check_quantidade_pedidos_itens
CHECK (quantidade >= 0);