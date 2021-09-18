--DATABASE
CREATE DATABASE LetsCar

USE LetsCar

--TABELAS
--Marcas---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Marcas
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Marcas PRIMARY KEY(Id)
)

GO
CREATE PROCEDURE InserirMarca 
	@NomeMarca VARCHAR(50)
	AS
	BEGIN
		INSERT INTO Marcas(Nome)
			VALUES (@NomeMarca)
	END

EXEC InserirMarca @NomeMarca = 'Honda'
EXEC InserirMarca @NomeMarca = 'Fiat'
EXEC InserirMarca @NomeMarca = 'Tesla'
EXEC InserirMarca @NomeMarca = 'BMW'
EXEC InserirMarca @NomeMarca = 'VolksWagen'
EXEC InserirMarca @NomeMarca = 'Ferrari'
EXEC InserirMarca @NomeMarca = 'Vou tentar editar essa'

GO
CREATE PROCEDURE EditarMarca
	@IdMarca INT,
	@NomeMarca VARCHAR(50)
	AS
	BEGIN
		UPDATE Marcas
		SET Nome = @NomeMarca
			WHERE Id = @IdMarca
	END

EXEC EditarMarca @IdMarca = 7, @NomeMarca = 'Consegui editar!'

GO
CREATE PROCEDURE DeletarMarca
	@IdMarca INT
	AS
	BEGIN
		DELETE FROM Marcas
			WHERE Id = @IdMarca
	END

EXEC DeletarMarca @IdMarca = 7

SELECT * FROM Marcas

--Modelos---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Modelos
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	IdMarca INT NOT NULL,
	CONSTRAINT PK_Modelos PRIMARY KEY(Id),
	CONSTRAINT FK_Modelos_Marcas FOREIGN KEY(IdMarca) REFERENCES Marcas(Id)
)

GO
CREATE PROCEDURE InserirModelo
	@NomeModelo VARCHAR(100),
	@IdMarca INT
	AS
	BEGIN
		INSERT INTO Modelos(Nome, IdMarca)
			VALUES (@NomeModelo, @IdMarca)
	END

EXEC InserirModelo @NomeModelo = 'Honda Civic', @IdMarca = 1
EXEC InserirModelo @NomeModelo = 'Ferrari 250 GT', @IdMarca = 6
EXEC InserirModelo @NomeModelo = 'Uno Pallo', @IdMarca = 2
EXEC InserirModelo @NomeModelo = 'Vou tentar editar essa', @IdMarca = 3

GO
CREATE PROCEDURE EditarModelo
	@NomeModelo VARCHAR(100),
	@IdMarca INT,
	@IdModelo INT
	AS
	BEGIN
		UPDATE Modelos
			SET Nome = @NomeModelo,
			IdMarca = @IdMarca
				WHERE Id = @IdModelo
	END

EditarModelo 

GO
CREATE PROCEDURE DeletarModelo
	@IdModelo INT NOT NULL
	AS
	BEGIN
		DELETE FROM Modelos
			WHERE Id = @IdModelo
	END

--Cores---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Cores
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Cores PRIMARY KEY(Id)
)

GO
CREATE PROCEDURE InserirCor
	@NomeCor VARCHAR(50) NOT NULL
	AS
	BEGIN
		INSERT INTO Cores(Nome)
			VALUES (@NomeCor)
	END

GO
CREATE PROCEDURE EditarCor
	@NomeCor VARCHAR(50) NOT NULL,
	@IdCor INT NOT NULL
	AS
	BEGIN
		UPDATE Cores
			SET Nome = @NomeCor
				WHERE Id = @IdCor
	END

GO
CREATE PROCEDURE DeletarCor
	@IdCor INT NOT NULL
	AS
	BEGIN
		DELETE FROM Cores
			WHERE Id = @IdCor
	END

--Carros---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Carros
(
	Id INT IDENTITY(1,1) NOT NULL,
	IdModelo INT NOT NULL,
	Ano CHAR(4) NOT NULL,
	IdCor INT NOT NULL,
	Preco DECIMAL(20,2) NOT NULL,
	CONSTRAINT PK_Carros PRIMARY KEY(Id),
	CONSTRAINT FK_Carros_Marcas FOREIGN KEY(IdMarca) REFERENCES Marcas(Id),
	CONSTRAINT FK_Carros_Modelos FOREIGN KEY(IdModelo) REFERENCES Modelos(Id),
	CONSTRAINT FK_Carros_Cores FOREIGN KEY(IdCor) REFERENCES Cores(Id)
)

GO
CREATE PROCEDURE InserirCarro
	@IdModelo INT NOT NULL,
	@Ano CHAR(4) NOT NULL,
	@IdCor INT NOT NULL,
	@Preco DECIMAL(20,2) NOT NULL
	AS
	BEGIN
		INSERT INTO Carros(IdModelo, Ano, IdCor, Preco)
			VALUES (@IdModelo, @Ano, @IdCor, @Preco)
	END

GO
CREATE PROCEDURE EditarCarro
	@IdModelo INT,
	@Ano CHAR(4),
	@IdCor INT,
	@Preco DECIMAL(20,2),
	@IdCarro INT NOT NULL
	AS
	BEGIN
		UPDATE Carros
			SET IdModelo = IsNull(@IdModelo, IdModelo),
			Ano = IsNull(@Ano, Ano),
			IdCor = IsNull(@IdCor, IdCor),
			Preco = IsNull(@Preco, Preco)
				WHERE Id = @IdCarro
	END

GO
CREATE PROCEDURE DeletarCarro
	@IdCarro INT NOT NULL
	AS
	BEGIN
		DELETE FROM Carros
			WHERE Id = @IdCarro
	END

--Adicionais---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Adicionais
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(100),
	CONSTRAINT PK_Adicionais PRIMARY KEY(Id)
)

GO
CREATE PROCEDURE InserirAdicional
	@NomeAdicional VARCHAR(100) NOT NULL
	AS
	BEGIN
		INSERT INTO Adicionais(Nome)
			VALUES (@NomeAdicional)
	END

GO
CREATE PROCEDURE EditarAdicional
	@NomeAdicional VARCHAR(100) NOT NULL,
	@IdAdicional INT NOT NULL
	AS
	BEGIN
		UPDATE Adicionais
			SET Nome = @NomeAdicional
				WHERE Id = @IdAdicional
	END

GO
CREATE PROCEDURE DeletarAdicional
	@IdAdicional INT NOT NULL
	AS
	BEGIN
		DELETE FROM Adicionais
			WHERE Id = @IdAdicional
	END

CREATE TABLE AdicionaisCarros
(
	Id INT IDENTITY(1,1) NOT NULL,
	IdAdicional INT NOT NULL,
	IdCarro INT NOT NULL,
	CONSTRAINT PK_AdicionaisCarros PRIMARY KEY(Id),
	CONSTRAINT FK_AdicionaisCarros_Adicionais FOREIGN KEY(IdAdicional) REFERENCES Adicionais(Id),
	CONSTRAINT FK_AdicionaisCarros_Carros FOREIGN KEY(IdCarro) REFERENCES Carros(Id)
)

GO
CREATE PROCEDURE InserirAdicionalCarro
	@IdAdicional INT NOT NULL,
	@IdCarro INT NOT NULL
	AS
	BEGIN
		INSERT INTO AdicionaisCarros(IdAdicional, IdCarro)
			VALUES (@IdAdicional, @IdCarro)
	END

GO
CREATE PROCEDURE EditarAdicionalCarro
	@IdAdicional INT,
	@IdCarro INT,
	@IdOperacao INT NOT NULL
	AS
	BEGIN
		UPDATE AdicionaisCarros
			SET IdAdicional = IsNull(@IdAdicional, IdAdicional),
			IdCarro = IsNull(@IdCarro, IdCarro)
				WHERE Id = @IdOperacao
	END

GO
CREATE PROCEDURE DeletarAdicionalCarro
	@IdOperacao INT NOT NULL
	AS
	BEGIN
		DELETE FROM AdicionaisCarros
			WHERE Id = @IdOperacao
	END

--Modos de pagamento---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE ModosPagamento
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	CONSTRAINT PK_ModosPagamento PRIMARY KEY(Id)
)

GO
CREATE PROCEDURE InserirModoPagamento
	@ModoPagamento VARCHAR(50) NOT NULL
	AS
	BEGIN
		INSERT INTO ModosPagamento(Nome)
			VALUES (@ModoPagamento)
	END

GO
CREATE PROCEDURE EditarModoPagamento
	@ModoPagamento VARCHAR(50) NOT NULL,
	@IdModoPagamento INT NOT NULL
	AS
	BEGIN
		UPDATE ModosPagamento
			SET Nome = @ModoPagamento
				WHERE Id = @IdModoPagamento
	END

GO
CREATE PROCEDURE DeletarModoPagamento
	@IdModoPagamento INT NOT NULL
	AS
	BEGIN
		DELETE FROM ModosPagamento
			WHERE Id = @IdModoPagamento
	END

CREATE TABLE ModosPagamentoCarros
(
	Id INT IDENTITY(1,1) NOT NULL,
	IdModo INT NOT NULL,
	IdCarro INT NOT NULL,
	CONSTRAINT PK_ModosPagamentoCarros PRIMARY KEY(Id),
	CONSTRAINT FK_ModosPagamentoCarros_ModosPagamento FOREIGN KEY(IdModo) REFERENCES ModosPagamento(Id),
	CONSTRAINT FK_ModosPagamentoCarros_Carros FOREIGN KEY(IdCarro) REFERENCES Carros(Id)
)

GO
CREATE PROCEDURE InserirModoPagamentoCarro
	@IdModo INT NOT NULL,
	@IdCarro INT NOT NULL
	AS
	BEGIN
		INSERT INTO ModosPagamentoCarros(IdModo, IdCarro)
			VALUES (@IdModo, @IdCarro)
	END

GO
CREATE PROCEDURE EditarModoPagamentoCarro
	@IdModo INT,
	@IdCarro INT,
	@IdOperacao INT NOT NULL
	AS
	BEGIN
		UPDATE ModosPagamentoCarros
			SET IdModo = IsNull(@IdModo, IdModo),
			IdCarro = IsNull(@IdCarro, IdCarro)
				WHERE Id = @IdOperacao
	END

GO
CREATE PROCEDURE DeletarModoPagamentoCarro
	@IdOperacao INT NOT NULL
	AS
	BEGIN
		DELETE FROM ModosPagamentoCarros
			WHERE Id = @IdOperacao
	END

--Usuarios---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Usuarios
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	CPF VARCHAR(14) NOT NULL,
	DataNascimento DATE NOT NULL,
	Email VARCHAR(256) NOT NULL,
	Senha VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Usuarios PRIMARY KEY(Id)
)

GO
CREATE PROCEDURE InserirUsuario
	@Nome VARCHAR(200) NOT NULL,
	@CPF VARCHAR(14) NOT NULL,
	@DataNascimento DATE NOT NULL,
	@Email VARCHAR(256) NOT NULL,
	@Senha VARCHAR(50) NOT NULL
	AS
	BEGIN
		INSERT INTO Usuarios(Nome, CPF, DataNascimento, Email, Senha)
			VALUES (@Nome, @CPF, @DataNascimento, @Email, @Senha)
	END

GO
CREATE PROCEDURE EditarUsuario
	@Nome VARCHAR(200),
	@CPF VARCHAR(14),
	@DataNascimento DATE,
	@Email VARCHAR(256),
	@Senha VARCHAR(50),
	@IdUsuario INT NOT NULL
	AS
	BEGIN
		UPDATE Usuarios
			SET Nome = IsNull(@Nome, Nome),
			CPF = IsNull(@CPF, CPF),
			DataNascimento = IsNull(@DataNascimento, DataNascimento),
			Email = IsNull(@Email, Email),
			Senha = IsNull(@Senha, Senha)
				WHERE Id = @IdUsuario
	END

GO
CREATE PROCEDURE DeletarUsuario
	@IdUsuario INT NOT NULL
	AS
	BEGIN
		DELETE FROM Usuarios
			WHERE Id = @IdUsuario
	END

--Favoritados---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE FavoritosUsuario
(
	Id INT IDENTITY(1,1) NOT NULL,
	IdUsuario INT NOT NULL,
	IdCarro INT NOT NULl,
	CONSTRAINT PK_FavoritosUsuario PRIMARY KEY(Id),
	CONSTRAINT FK_FavoritosUsuario_Adicionais FOREIGN KEY(IdUsuario) REFERENCES Usuarios(Id),
	CONSTRAINT FK_FavoritosUsuario_Carros FOREIGN KEY(IdCarro) REFERENCES Carros(Id)
)

GO
CREATE PROCEDURE FavoritarCarro
	@IdUsuario INT NOT NULL,
	@IdCarro INT NOT NULl
	AS
	BEGIN
		INSERT INTO FavoritosUsuario(IdUsuario, IdCarro)
			VALUES (@IdUsuario, @IdCarro)
	END

GO
CREATE PROCEDURE EditarCarroFavoritado
	@IdUsuario INT,
	@IdCarro INT,
	@IdOperacao INT NOT NULL
	AS
	BEGIN
		UPDATE FavoritosUsuario
			SET IdUsuario = IsNull(@IdUsuario, IdUsuario),
			IdCarro = IsNull(@IdCarro, IdCarro)
				WHERE Id = @IdOperacao
	END

GO
CREATE PROCEDURE ExibirCarrosFavoritados
	@IdUsuario INT NOT NULL
	AS
	BEGIN
		SELECT m.Nome AS Modelo,
		ma.Nome AS Marca,
		c.Ano AS Ano,
		co.Nome AS Cor,
		c.Preco AS Preco
			FROM FavoritosUsuario fu
				INNER JOIN Carros c
					ON fu.IdCarro = c.Id
						INNER JOIN Modelos m
							ON c.IdModelo = m.Id
								INNER JOIN Marcas ma
									ON m.IdMarca = ma.Id
										INNER JOIN Cores co
											ON c.IdCor = co.Id
												WHERE fu.IdUsuario = @IdUsuario
	END

GO
CREATE PROCEDURE DeletarCarroFavoritado
	@IdOperacao INT NOT NULL
	AS
	BEGIN
		DELETE FROM FavoritosUsuario
			WHERE Id = @IdOperacao
	END

--Formulário de contato---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Contato
(
	Id INT IDENTITY(1,1) NOT NULL,
	IdUsuario INT NOT NULL,
	IdCarro INT NOT NULL,
	Mensagem VARCHAR(MAX) NOT NULL,
	CONSTRAINT PK_Contato PRIMARY KEY(Id),
	CONSTRAINT FK_Contato_Carros FOREIGN KEY(IdCarro) REFERENCES Carros(Id)
)

GO
CREATE PROCEDURE CriarFormularioContato
	@IdUsuario INT NOT NULL,
	@IdCarro INT NOT NULL,
	@Mensagem VARCHAR(MAX) NOT NULL
	AS
	BEGIN
		INSERT INTO Contato(IdUsuario, IdCarro, Mensagem)
			VALUES (@IdUsuario, @IdCarro, @Mensagem)
	END

GO
CREATE PROCEDURE EditarFormularioContato
	@IdUsuario INT,
	@IdCarro INT,
	@Mensagem VARCHAR(MAX),
	@IdFormulario INT NOT NULL
	AS
	BEGIN
		UPDATE Contato
			SET IdUsuario = IsNull(@IdUsuario, IdUsuario),
			IdCarro = IsNull(@IdCarro, IdCarro),
			Mensagem = IsNull(@Mensagem, Mensagem)
				WHERE Id = @IdFormulario
	END

GO
CREATE PROCEDURE DeletarFormularioContato
	@IdUsuario INT,
	@IdCarro INT,
	@Mensagem VARCHAR(MAX),
	@IdFormulario INT NOT NULL
	AS
	BEGIN
		DELETE FROM Contato
			WHERE Id = @IdFormulario
	END

--SELECTS---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Buscar por atributo---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE BuscarMarca
	@Marca VARCHAR(50) NOT NULL
	AS
	BEGIN
		SELECT m.Nome AS Marca,
		mo.Nome AS Modelo,
		c.Ano,
		co.Nome AS Cor,
		c.Preco
			FROM Marcas m
				INNER JOIN Modelos mo
					ON m.Id = mo.IdMarca
						INNER JOIN Carros c
							ON mo.Id = c.IdModelo
								INNER JOIN Cores co
									ON co.Id = c.IdCor
										WHERE m.Nome = @Marca
	END

EXEC BuscarMarca @Marca = 'Fiat'

GO
CREATE PROCEDURE BuscarModelo
	@Modelo VARCHAR(100) NOT NULL
	AS
	BEGIN
		SELECT mo.Nome AS Modelo,
		m.Nome AS Marca,
		c.Ano,
		co.Nome AS Cor,
		c.Preco
			FROM Modelos mo
				INNER JOIN Marcas m
					ON mo.IdMarca = m.Id
						INNER JOIN Carros c
							ON mo.Id = c.IdModelo
								INNER JOIN Cores co
									ON co.Id = c.IdCor
										WHERE mo.Nome = @Modelo
	END
