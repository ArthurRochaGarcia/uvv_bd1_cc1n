-- Usuário Criado

CREATE USER 'arthur'@'localhost' IDENTIFIED BY 'computacao@raiz' 
;

-- BD Criado

CREATE DATABASE uvv;

-- Permissões ao usuário 'arthur'

GRANT all ON uvv.*  TO 'arthur'@'localhost'
FLUSH PRIVILEGES;

--Conectando com o BD
USE uvv;

-- Criando a Tabela Produtos



CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                detalhes LONGBLOB,
                preco_unitario NUMERIC(10,2),
                imagem LONGBLOB,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                imagem_charset VARCHAR(512),
                PRIMARY KEY (produto_id)
);

-- Comentários da Tabela Produtos
ALTER TABLE produtos COMMENT 'Inclui informações sobre o(s) produto(s) da(s) loja(s)';
ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'chave primaria da tabela produtos, se relaciona com a tabela pedidos_itens e com a tabela estoques';
ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT 'inserir Nome do produto';
ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT 'Inserir imagens que detalhe o produto.
Exemplo:Manual de utilização do produto';
ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Inserir preco do produto em R$
Exemplo: R$ XX,XX';
ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT 'Inserir imagem do produto';
ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT 'informações do tipo de arquivo e formato da imagem do produto';
ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT 'Arquivo da imagem do produto';
ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE COMMENT 'Ultima atualizacao da imagem do produto';
ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT 'Denomina a codificação de caracteres.';

-- CHECK CONSTRAINTS tabela PRODUTOS

ALTER TABLE produtos
      ADD CONSTRAINT check_produtos_preco_unitario
      CHECK (preco_unitario >= 0);

-- Criando a Tabela Lojas

CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                logitude NUMERIC,
                logo LONGBLOB,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_ultima_atualizacao DATE,
                logo_charset VARCHAR(512),
                PRIMARY KEY (loja_id)
);

-- Comentários da Tabela Lojas 
ALTER TABLE lojas COMMENT 'Lojas uvv, contém o(s) dado(s) da Lojas UVV, endereco da loja (fisco e web), e dados de atualizacao.';
ALTER TABLE lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'chave primaria da tabela lojas, se relaciona com as tabelas  pedidos, envios e estoques';
ALTER TABLE lojas MODIFY COLUMN nome VARCHAR(255) COMMENT 'nome da loja';
ALTER TABLE lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT 'inserir o endereco_web (URL) da loja';
ALTER TABLE lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT 'Endereco onde se situa a loja.
Inserir: Rua (ou) Avenidade (ou) Rodovia e número';
ALTER TABLE lojas MODIFY COLUMN latitude NUMERIC COMMENT 'cordenadas geográfica (latitude). fundamentais para a localização exata na superfície do planeta Terra.';
ALTER TABLE lojas MODIFY COLUMN longitude NUMERIC COMMENT 'cordenadas geográfica (longitude). fundamentais para a localização exata na superfície do planeta Terra.';
ALTER TABLE lojas MODIFY COLUMN logo BLOB COMMENT 'Armazenar a imagem logo das Lojas UVV';
ALTER TABLE lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT 'informações do tipo de arquivo e formato da logo';
ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT 'Arquivo da Logo da Loja';
ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT 'Ultima atualizacao do logo da loja';
ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT 'Denomina a codificação de caracteres.';
 
-- Criando a Tabela Estoques

CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                PRIMARY KEY (estoque_id)
);

-- Comentários da Tabela Estoques
ALTER TABLE estoques COMMENT 'Inclui informações sobre o(s) estoque(s) da(s) loja(s)
como o produto(s) e quantidade(s)';
ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT 'PK da tabela estoques.';
ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'chave estrangeira da tabela lojas';
ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'chave estrangeira da tabela produtos';
ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'coluna de insercao da quantidade de um produto no estoque';

-- FK da tabela ESTOQUES
ALTER TABLE estoques
      ADD CONSTRAINT fk_lojas_estoques
      FOREIGN KEY (loja_id)
      REFERENCES lojas (loja_id);

ALTER TABLE estoques
      ADD CONSTRAINT fk_produtos_estoques
      FOREIGN KEY (produto_id)
      REFERENCES produtos (produto_id);

-- Criando a Tabela Clientes

CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                PRIMARY KEY (cliente_id)
);

-- Comentários da Tabela Cliente

ALTER TABLE clientes COMMENT 'Tabela clientes, contem dados de todos os clientes da lojas uvv';
ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'chave primária da tabela Clientes, se relaciona com a tabela Envios e com a tabela pedidos';
ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT  'inserir email do cliente: exemplo@hotmail.com';
ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT 'inserir nome do cliente das lojas uvv';
ALTER TABLE clientes MODIFY COLUMN telefone1 VARCHAR(20) COMMENT 'telefone 1 limite 20 caractéres';
ALTER TABLE clientes MODIFY COLUMN telefone2 VARCHAR(20) COMMENT 'telefone 2 limite 20 caractéres';
ALTER TABLE clientes MODIFY COLUMN telefone3 VARCHAR(20) COMMENT 'telefone 2 limite 20 caractéres';


-- Criando a Tabela envios

CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                PRIMARY KEY (envio_id)
);

-- Comentário da tabela estoques

ALTER TABLE envios COMMENT 'Tabela Envios, contém os dados do envios, endereco de entrega, o destinatário da entrega e o status da entrega';
ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'chave primaria da tabela envios, se relaciona com as tabelas lojas e pedido_itens';
ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'chave estrangeira da tabela lojas.';
ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'chave estrangeira da tabela clientes.';
ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT 'Endereco onde será enviado.
Inserir: Rua (ou) Avenidade (ou) Rodovia e número.';
ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT 'Inserir Status da Entrega. Para saber o processo do envio';

-- FK tebela envios
ALTER TABLE envios
      ADD CONSTRAINT fk_lojas_envios
      FOREIGN KEY (loja_id)
      REFERENCES lojas (loja_id);

ALTER TABLE envios
      ADD CONSTRAINT fk_clientes_envios
      FOREIGN KEY (cliente_id)
      REFERENCES clientes (cliente_id);

-- Criando a Tabela Pedidos

CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                PRIMARY KEY (pedido_id)
);

-- Comentários da tabela pedidos

ALTER TABLE pedidos COMMENT 'Tabela pedidos, contém data e hora do pedido, com chaves estrangeiras de qual loja o pedido foi efetuado e qual cliente';
ALTER TABLE pedidos MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Chave Primaria da tabela pedidos, se relaciona com a tabela pedido_itens';
ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT 'Inserir data e hora do pedido';
ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'chave estrangeira da tabela clientes.';
ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Chave estrangeira da tabela loja';
ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT 'Diz sobre o processo do pedido';

-- FK da tabela pedidos
ALTER TABLE pedidos
      ADD CONSTRAINT fk_clientes_pedidos
      FOREIGN KEY (cliente_id)
      REFERENCES clientes (cliente_id);

ALTER TABLE pedidos
      ADD CONSTRAINT fk_lojas_pedidos
      FOREIGN KEY (loja_id)
      REFERENCES lojas (loja_id);

-- Criando a tabela pedidos_itens

CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2),
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                PRIMARY KEY (pedido_id, produto_id)
);

-- comentários da tabela pedidos_itens

ALTER TABLE pedidos_itens COMMENT 'inclui informacoes do pedido+item';
ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'chave primaria estrangeira da tabela pedidos';
ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'chave primaria estrangeira da tabela produtos';
ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT 'inserir numero da linha do pedido';
ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Inserir preco do produto em R$
Exemplo: R$ XX,XX';
ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'quantidade de itens no pedido';
ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'chave estrangeira da tabela pedidos';

-- FK entre as tabelas pedidos itens

ALTER TABLE pedidos_itens
      ADD CONSTRAINT fk_pedidos_pedidos_itens
      FOREIGN KEY (pedido_id)
      REFERENCES pedidos (pedido_id);

ALTER TABLE pedidos_itens
      ADD CONSTRAINT fk_produtos_pedidos_itens
      FOREIGN KEY (produto_id)
      REFERENCES produtos (produto_id);

ALTER TABLE pedidos_itens
      ADD CONSTRAINT fk_envios_pedidos_itens
      FOREIGN KEY (pedido_id)
      REFERENCES pedidos (pedido_id);

-- Fim