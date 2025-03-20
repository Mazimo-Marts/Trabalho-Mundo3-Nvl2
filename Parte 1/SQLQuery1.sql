CREATE TABLE pessoa(
	id_pessoa INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	logradouro VARCHAR(255) NOT NULL,
	cidade VARCHAR(255) NOT NULL,
	estado CHAR(2) NOT NULL,
	telefone VARCHAR(11),
	email VARCHAR(255)
);
GO

CREATE TABLE pessoaFisica(
	cpf VARCHAR(11) PRIMARY KEY,
	id_pessoa INT UNIQUE,
	FOREIGN KEY(id_pessoa) REFERENCES pessoa(id_pessoa)
);
GO

CREATE TABLE pessoaJuridica(
	cnpj VARCHAR(14) PRIMARY KEY,
	id_pessoa INT UNIQUE,
	FOREIGN KEY(id_pessoa) REFERENCES pessoa(id_pessoa)
);
GO