-- Criando tabela Usuários
CREATE TABLE usuario(
	id_usuario INT IDENTITY(1,1) PRIMARY KEY,
	login VARCHAR(50) NOT NULL UNIQUE,
	senha VARCHAR(50) NOT NULL
);
GO

-- Criando tabela Produtos
CREATE TABLE produto(
	id_produto INT NOT NULL PRIMARY KEY,
	nome VARCHAR(25) NOT NULL,
	quantidade INT NOT NULL,
	precoVenda DECIMAL(10,2) NOT NULL
);
GO


-- Criando tabela Movimentação
CREATE TABLE movimento(
	id_movimento INT IDENTITY(1,1) PRIMARY KEY,
	id_usuario INT NOT NULL,
	id_pessoa INT NOT NULL,
	id_produto INT NOT NULL,
	quantidade INT NOT NULL,
	tipo CHAR(1) NOT NULL CHECK (tipo IN ('E', 'S')),
	valorUnitario DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario),
	FOREIGN KEY(id_pessoa) REFERENCES pessoa(id_pessoa),
	FOREIGN KEY(id_produto) REFERENCES produto(id_produto)
);
GO

-- Inserindo usuários na DB
INSERT INTO usuario VALUES 
	('op1', 'op1'),
	('op2', 'op2');
GO

-- Inserindo produtos na DB
INSERT INTO produto VALUES
	(1, 'Banana', 100, 5.00),
	(3, 'Laranja', 500, 2.00),
	(4, 'Manga', 800, 4.00);
GO

-- Inserindo pessoas na DB
INSERT INTO pessoa VALUES
	('João', 'Rua 12, casa 3, Quitanda', 'Riacho do Sul', 'PA', '1111-1111', 'joao@riacho.com'),
	('JJC', 'Rua 11, Centro', 'Riacho do Norte', 'PA', '1212-1212', 'jjc@riacho.com');
GO

-- Inserindo pessoasFisicas na DB
INSERT INTO pessoaFisica VALUES ('11111111111', 1);
GO

-- Inserindo pessoasJuridicas na DB
INSERT INTO pessoaJuridica VALUES ('22222222222222', 2);
GO

-- Inserindo movimentações na DB
INSERT INTO movimento VALUES
	(1, 1, 1, 20, 'S', 4.00),
	(1, 1, 3, 15, 'S', 2.00),
	(2, 1, 3, 10, 'S', 3.00),
	(1, 2, 3, 15, 'E', 5.00),
	(1, 2, 4, 20, 'E', 4.00);
GO

-- Consultas:

-- Todos os usuários
SELECT * FROM usuario;
GO

-- Todos os produtos
SELECT * FROM produto;
GO

-- Todo movimento
SELECT * FROM movimento;
GO

-- Todas as pessoasFisicas
SELECT p.id_pessoa, p.nome, p.logradouro, p.cidade, p.estado, p.telefone, p.email, pf.id_pessoa, pf.cpf
FROM pessoa p
JOIN pessoaFisica pf ON (pf.id_pessoa = p.id_pessoa);
GO

-- Todas as pessoasJuridicas
SELECT p.id_pessoa, p.nome, p.logradouro, p.cidade, p.estado, p.telefone, p.email, pj.id_pessoa, pj.cnpj
FROM pessoa p
JOIN pessoaJuridica pj ON (pj.id_pessoa = p.id_pessoa);
GO

-- Valor total das entradas agrupadas por produto
SELECT id_produto, SUM(quantidade) AS quantidadeTotal, SUM(quantidade * valorUnitario) AS valorTotalEntrada
FROM  movimento
WHERE tipo = 'E'
GROUP BY id_produto;
GO

-- Valor total das saídas agrupadas por produto
SELECT id_produto, SUM(quantidade) AS quantidadeTotal, SUM(quantidade * valorUnitario) AS valorTotalSaidas
FROM  movimento
WHERE tipo = 'S'
GROUP BY id_produto;
GO

-- Valor total de entrada, agrupado por operador
SELECT id_usuario, SUM(quantidade) AS quantidadeTotal, SUM(quantidade * valorUnitario) AS valorTotalEntrada
FROM  movimento
WHERE tipo = 'E'
GROUP BY id_usuario;
GO


-- Valor total de saída, agrupado por operador
SELECT id_usuario, SUM(quantidade) AS quantidadeTotal, SUM(quantidade * valorUnitario) AS valorTotalSaidas
FROM  movimento
WHERE tipo = 'S'
GROUP BY id_usuario;
GO

-- Valor médio de venda por produto, utilizando média ponderada
SELECT id_produto, SUM(quantidade) AS quantidadeTotal, SUM(quantidade*valorUnitario)/SUM(quantidade) AS mediaPonderada
FROM  movimento
WHERE tipo = 'S'
GROUP BY id_produto;
GO
