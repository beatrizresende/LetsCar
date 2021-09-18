--DATABASE
CREATE DATABASE LetsCar
GO
USE LetsCar
GO
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

--EXEC InserirMarca @NomeMarca = 'Honda'
--EXEC InserirMarca @NomeMarca = 'Fiat'
--EXEC InserirMarca @NomeMarca = 'Tesla'
--EXEC InserirMarca @NomeMarca = 'BMW'
--EXEC InserirMarca @NomeMarca = 'VolksWagen'
--EXEC InserirMarca @NomeMarca = 'Ferrari'
--EXEC InserirMarca @NomeMarca = 'Vou tentar editar essa'

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

--EXEC EditarMarca @IdMarca = 7, @NomeMarca = 'Consegui editar!'

GO
CREATE PROCEDURE DeletarMarca
	@IdMarca INT
	AS
	BEGIN
		DELETE FROM Marcas
			WHERE Id = @IdMarca
	END

--EXEC DeletarMarca @IdMarca = 7

GO

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

--EXEC InserirModelo @NomeModelo = 'Honda Civic', @IdMarca = 1
--EXEC InserirModelo @NomeModelo = 'Ferrari 250 GT', @IdMarca = 6
--EXEC InserirModelo @NomeModelo = 'Uno Pallo', @IdMarca = 2
--EXEC InserirModelo @NomeModelo = 'Vou tentar editar essa', @IdMarca = 3

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

--EXEC EditarModelo @NomeModelo = 'Modelo editado!', @IdMarca = 3,  @IdModelo = 4

GO
CREATE PROCEDURE DeletarModelo
	@IdModelo INT
	AS
	BEGIN
		DELETE FROM Modelos
			WHERE Id = @IdModelo
	END

--EXEC DeletarModelo @IdModelo = 4

GO

--Cores---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Cores
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Cores PRIMARY KEY(Id)
)

GO
CREATE PROCEDURE InserirCor
	@NomeCor VARCHAR(50)
	AS
	BEGIN
		INSERT INTO Cores(Nome)
			VALUES (@NomeCor)
	END

--EXEC InserirCor @NomeCor = 'Azul'
--EXEC InserirCor @NomeCor = 'Vermelho'
--EXEC InserirCor @NomeCor = 'Cinza'
--EXEC InserirCor @NomeCor = 'Branco'
--EXEC InserirCor @NomeCor = 'Preto'
--EXEC InserirCor @NomeCor = 'Teste de edição'

GO
CREATE PROCEDURE EditarCor
	@NomeCor VARCHAR(50),
	@IdCor INT
	AS
	BEGIN
		UPDATE Cores
			SET Nome = @NomeCor
				WHERE Id = @IdCor
	END

--EXEC EditarCor @NomeCor = 'Cor editada', @IdCor = 6

GO
CREATE PROCEDURE DeletarCor
	@IdCor INT
	AS
	BEGIN
		DELETE FROM Cores
			WHERE Id = @IdCor
	END

--EXEC DeletarCor @IdCor = 6
GO
--Carros---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Carros
(
	Id INT IDENTITY(1,1) NOT NULL,
	IdModelo INT NOT NULL,
	Ano CHAR(4) NOT NULL,
	IdCor INT NOT NULL,
	Preco DECIMAL(20,2) NOT NULL,
	CONSTRAINT PK_Carros PRIMARY KEY(Id),
	CONSTRAINT FK_Carros_Modelos FOREIGN KEY(IdModelo) REFERENCES Modelos(Id),
	CONSTRAINT FK_Carros_Cores FOREIGN KEY(IdCor) REFERENCES Cores(Id)
)

GO
CREATE PROCEDURE InserirCarro
	@IdModelo INT,
	@Ano CHAR(4),
	@IdCor INT,
	@Preco DECIMAL(20,2)
	AS
	BEGIN
		INSERT INTO Carros(IdModelo, Ano, IdCor, Preco)
			VALUES (@IdModelo, @Ano, @IdCor, @Preco)
	END

--EXEC InserirCarro @IdModelo = 2, @Ano = 2000, @IdCor = 3, @Preco = 200000000.00
--EXEC InserirCarro @IdModelo = 3, @Ano = 2010, @IdCor = 2, @Preco = 300000.00

GO
CREATE PROCEDURE EditarCarro
	@IdModelo INT,
	@Ano CHAR(4),
	@IdCor INT,
	@Preco DECIMAL(20,2),
	@IdCarro INT
	AS
	BEGIN
		UPDATE Carros
			SET IdModelo = IsNull(@IdModelo, IdModelo),
			Ano = IsNull(@Ano, Ano),
			IdCor = IsNull(@IdCor, IdCor),
			Preco = IsNull(@Preco, Preco)
				WHERE Id = @IdCarro
	END

--EXEC EditarCarro @IdModelo = 3, @Ano = 2010, @IdCor = 4, @Preco = 3500000.00, @IdCarro = 2

GO
CREATE PROCEDURE DeletarCarro
	@IdCarro INT
	AS
	BEGIN
		DELETE FROM Carros
			WHERE Id = @IdCarro
	END

--EXEC DeletarCarro @IdCarro = 2
GO
--Adicionais---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Adicionais
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(100),
	CONSTRAINT PK_Adicionais PRIMARY KEY(Id)
)

GO
CREATE PROCEDURE InserirAdicional
	@NomeAdicional VARCHAR(100) 
	AS
	BEGIN
		INSERT INTO Adicionais(Nome)
			VALUES (@NomeAdicional)
	END

--EXEC InserirAdicional @NomeAdicional = 'Ar condicionado'
--EXEC InserirAdicional @NomeAdicional = 'Vidro blindado'
--EXEC InserirAdicional @NomeAdicional = 'Vou editar esse'

GO
CREATE PROCEDURE EditarAdicional
	@NomeAdicional VARCHAR(100),
	@IdAdicional INT
	AS
	BEGIN
		UPDATE Adicionais
			SET Nome = @NomeAdicional
				WHERE Id = @IdAdicional
	END

--EXEC EditarAdicional @NomeAdicional = 'Editando', @IdAdicional = 3

GO
CREATE PROCEDURE DeletarAdicional
	@IdAdicional INT
	AS
	BEGIN
		DELETE FROM Adicionais
			WHERE Id = @IdAdicional
	END

--EXEC DeletarAdicional @IdAdicional = 3
GO
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
	@IdAdicional INT,
	@IdCarro INT
	AS
	BEGIN
		INSERT INTO AdicionaisCarros(IdAdicional, IdCarro)
			VALUES (@IdAdicional, @IdCarro)
	END

--EXEC InserirAdicionalCarro @IdAdicional = 2, @IdCarro = 1

GO
CREATE PROCEDURE EditarAdicionalCarro
	@IdAdicional INT,
	@IdCarro INT,
	@IdOperacao INT
	AS
	BEGIN
		UPDATE AdicionaisCarros
			SET IdAdicional = IsNull(@IdAdicional, IdAdicional),
			IdCarro = IsNull(@IdCarro, IdCarro)
				WHERE Id = @IdOperacao
	END

--EXEC EditarAdicionalCarro @IdAdicional = 1, @IdCarro = 1, @IdOperacao = 1

GO
CREATE PROCEDURE DeletarAdicionalCarro
	@IdOperacao INT
	AS
	BEGIN
		DELETE FROM AdicionaisCarros
			WHERE Id = @IdOperacao
	END

--EXEC DeletarAdicionalCarro @IdOperacao = 1
GO
--Modos de pagamento---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE ModosPagamento
(
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	CONSTRAINT PK_ModosPagamento PRIMARY KEY(Id)
)

GO
CREATE PROCEDURE InserirModoPagamento
	@ModoPagamento VARCHAR(50)
	AS
	BEGIN
		INSERT INTO ModosPagamento(Nome)
			VALUES (@ModoPagamento)
	END

--EXEC InserirModoPagamento @ModoPagamento = 'À vista'
--EXEC InserirModoPagamento @ModoPagamento = 'Crédito'
--EXEC InserirModoPagamento @ModoPagamento = 'Débito'
--EXEC InserirModoPagamento @ModoPagamento = 'Teste'

GO
CREATE PROCEDURE EditarModoPagamento
	@ModoPagamento VARCHAR(50),
	@IdModoPagamento INT
	AS
	BEGIN
		UPDATE ModosPagamento
			SET Nome = @ModoPagamento
				WHERE Id = @IdModoPagamento
	END

--EXEC EditarModoPagamento @ModoPagamento = 'Editando', @IdModoPagamento = 4

GO
CREATE PROCEDURE DeletarModoPagamento
	@IdModoPagamento INT
	AS
	BEGIN
		DELETE FROM ModosPagamento
			WHERE Id = @IdModoPagamento
	END

--EXEC DeletarModoPagamento @IdModoPagamento = 4
GO
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
	@IdModo INT,
	@IdCarro INT
	AS
	BEGIN
		INSERT INTO ModosPagamentoCarros(IdModo, IdCarro)
			VALUES (@IdModo, @IdCarro)
	END

--EXEC InserirModoPagamentoCarro @IdModo = 2, @IdCarro = 1
--EXEC InserirModoPagamentoCarro @IdModo = 3, @IdCarro = 1

GO
CREATE PROCEDURE EditarModoPagamentoCarro
	@IdModo INT,
	@IdCarro INT,
	@IdOperacao INT
	AS
	BEGIN
		UPDATE ModosPagamentoCarros
			SET IdModo = @IdModo,
			IdCarro = @IdCarro
				WHERE Id = @IdOperacao
	END

--EXEC EditarModoPagamentoCarro @IdModo = 1, @IdCarro = 1, @IdOperacao = 3

GO
CREATE PROCEDURE DeletarModoPagamentoCarro
	@IdOperacao INT
	AS
	BEGIN
		DELETE FROM ModosPagamentoCarros
			WHERE Id = @IdOperacao
	END

--EXEC DeletarModoPagamentoCarro @IdOperacao = 3
GO
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
	@Nome VARCHAR(200),
	@CPF VARCHAR(14),
	@DataNascimento DATE,
	@Email VARCHAR(256),
	@Senha VARCHAR(50)
	AS
	BEGIN
		INSERT INTO Usuarios(Nome, CPF, DataNascimento, Email, Senha)
			VALUES (@Nome, @CPF, @DataNascimento, @Email, @Senha)
	END

--EXEC InserirUsuario @Nome = 'Vinicius Mussak', @CPF = '738291813', @DataNascimento = '08-10-1990', @Email = 'vini123@gmail.com', @Senha = 'vini123'
--EXEC InserirUsuario @Nome = 'Teste', @CPF = '738291813', @DataNascimento = '08-10-1990', @Email = 'vini123@gmail.com', @Senha = 'vini123'


GO
CREATE PROCEDURE EditarUsuario
	@Nome VARCHAR(200),
	@CPF VARCHAR(14),
	@DataNascimento DATE,
	@Email VARCHAR(256),
	@Senha VARCHAR(50),
	@IdUsuario INT
	AS
	BEGIN
		UPDATE Usuarios
			SET Nome = @Nome,
			CPF = @CPF,
			DataNascimento = @DataNascimento,
			Email = @Email,
			Senha = @Senha
				WHERE Id = @IdUsuario
	END

--EXEC EditarUsuario @Nome = 'Editando o teste', @CPF = '738291813', @DataNascimento = '08-10-1990', @Email = 'vini123@gmail.com', @Senha = 'vini123', @IdUsuario = 2

GO
CREATE PROCEDURE DeletarUsuario
	@IdUsuario INT
	AS
	BEGIN
		DELETE FROM Usuarios
			WHERE Id = @IdUsuario
	END

--EXEC DeletarUsuario @IdUsuario = 2
GO
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
	@IdUsuario INT,
	@IdCarro INT
	AS
	BEGIN
		INSERT INTO FavoritosUsuario(IdUsuario, IdCarro)
			VALUES (@IdUsuario, @IdCarro)
	END

--EXEC FavoritarCarro @IdUsuario = 1, @IdCarro = 1

GO
CREATE PROCEDURE EditarCarroFavoritado
	@IdUsuario INT,
	@IdCarro INT,
	@IdOperacao INT
	AS
	BEGIN
		UPDATE FavoritosUsuario
			SET IdUsuario = IsNull(@IdUsuario, IdUsuario),
			IdCarro = IsNull(@IdCarro, IdCarro)
				WHERE Id = @IdOperacao
	END

--EXEC EditarCarroFavoritado @IdUsuario = 1, @IdCarro = 1, @IdOperacao = 1

GO
CREATE PROCEDURE ExibirCarrosFavoritados
	@IdUsuario INT
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

--EXEC ExibirCarrosFavoritados @IdUsuario = 1

GO
CREATE PROCEDURE DeletarCarroFavoritado
	@IdOperacao INT
	AS
	BEGIN
		DELETE FROM FavoritosUsuario
			WHERE Id = @IdOperacao
	END

--EXEC DeletarCarroFavoritado @IdOperacao = 1
GO
--Formulário de contato---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Contato
(
	Id INT IDENTITY(1,1) NOT NULL,
	IdUsuario INT NOT NULL,
	IdCarro INT NOT NULL,
	Mensagem VARCHAR(MAX) NOT NULL,
	CONSTRAINT PK_Contato PRIMARY KEY(Id),
	CONSTRAINT FK_Contato_Usuarios FOREIGN KEY(IdUsuario) REFERENCES Usuarios(Id),
	CONSTRAINT FK_Contato_Carros FOREIGN KEY(IdCarro) REFERENCES Carros(Id)
)

GO
CREATE PROCEDURE CriarFormularioContato
	@IdUsuario INT,
	@IdCarro INT,
	@Mensagem VARCHAR(MAX)
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
	@IdFormulario INT
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
	@IdFormulario INT
	AS
	BEGIN
		DELETE FROM Contato
			WHERE Id = @IdFormulario
	END

--SELECTS---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Buscar por atributo---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE BuscarMarca
	@Marca VARCHAR(50)
	AS
	BEGIN
		SELECT m.Nome AS Marca,
		mo.Nome AS Modelo,
		c.Ano,
		co.Nome AS Cor,
		c.Preco,
		mp.Nome AS ModoPagamento
			FROM Marcas m
				INNER JOIN Modelos mo
					ON m.Id = mo.IdMarca
						INNER JOIN Carros c
							ON mo.Id = c.IdModelo
								INNER JOIN Cores co
									ON co.Id = c.IdCor
										INNER JOIN ModosPagamentoCarros mpc
											ON mpc.IdCarro = c.Id
												INNER JOIN ModosPagamento mp
													ON mpc.IdModo = mp.Id
														WHERE m.Nome = @Marca
	END

--EXEC BuscarMarca @Marca = 'FERRARI'

GO
CREATE PROCEDURE BuscarModelo
	@Modelo VARCHAR(100)
	AS
	BEGIN
		SELECT mo.Nome AS Modelo,
		m.Nome AS Marca,
		c.Ano,
		co.Nome AS Cor,
		c.Preco,
		mp.Nome AS ModoPagamento
			FROM Modelos mo
				INNER JOIN Marcas m
					ON mo.IdMarca = m.Id
						INNER JOIN Carros c
							ON mo.Id = c.IdModelo
								INNER JOIN Cores co
									ON co.Id = c.IdCor
										INNER JOIN ModosPagamentoCarros mpc
											ON mpc.IdCarro = c.Id
												INNER JOIN ModosPagamento mp
													ON mpc.IdModo = mp.Id
														WHERE mo.Nome = @Modelo
	END

--EXEC BuscarModelo @Modelo = 'FERRARI 250 GT'

GO
CREATE PROCEDURE BuscarAno
	@Ano CHAR(4)
	AS
	BEGIN
		SELECT c.Ano,
		mo.Nome AS Modelo,
		m.Nome AS Marca,
		co.Nome AS Cor,
		c.Preco,
		mp.Nome AS ModoPagamento
			FROM Carros c
				INNER JOIN Modelos mo
					ON mo.Id = c.IdModelo
						INNER JOIN Marcas m
							ON m.Id = mo.IdMarca
								INNER JOIN Cores co
									ON co.Id = c.IdCor
										INNER JOIN ModosPagamentoCarros mpc
											ON mpc.IdCarro = c.Id
												INNER JOIN ModosPagamento mp
													ON mpc.IdModo = mp.Id
														WHERE c.Ano = @Ano
	END

--EXEC BuscarAno @Ano = '2000'

GO
CREATE PROCEDURE BuscarCor
	@Cor VARCHAR(50)
	AS
	BEGIN
		SELECT co.Nome AS Cor,
		mo.Nome AS Modelo,
		m.Nome AS Marca,
		c.Ano,
		c.Preco,
		mp.Nome AS ModoPagamento
			FROM Cores co
				INNER JOIN Carros c
					ON co.Id = c.IdCor
						INNER JOIN Modelos mo
							ON mo.Id = c.IdModelo
								INNER JOIN Marcas m
									ON m.Id = mo.IdMarca
										INNER JOIN ModosPagamentoCarros mpc
											ON mpc.IdCarro = c.Id
												INNER JOIN ModosPagamento mp
													ON mpc.IdModo = mp.Id
														WHERE co.Nome = @Cor
	END

--EXEC BuscarCor @Cor = 'Cinza'

GO
CREATE PROCEDURE BuscarPreco
	@Preco DECIMAL(20,2)
	AS
	BEGIN
		SELECT c.Preco,
		mo.Nome AS Modelo,
		m.Nome AS Marca,
		c.Ano,
		co.Nome AS Cor,
		mp.Nome AS ModoPagamento
			FROM Carros c
				INNER JOIN Modelos mo
					ON mo.Id = c.IdModelo
						INNER JOIN Marcas m
							ON mo.IdMarca = m.Id
								INNER JOIN Cores co
									ON co.Id = c.IdCor
										INNER JOIN ModosPagamentoCarros mpc
											ON mpc.IdCarro = c.Id
												INNER JOIN ModosPagamento mp
													ON mpc.IdModo = mp.Id
														WHERE c.Preco = @Preco
	END

--EXEC BuscarPreco @Preco = 200000000.00


GO
CREATE PROCEDURE BuscarModoPagamento
	@ModoPagamento VARCHAR(50)
	AS
	BEGIN
		SELECT mp.Nome AS ModoPagamento,
		mo.Nome AS Modelo,
		m.Nome AS Marca,
		c.Ano,
		co.Nome AS Cor,
		c.Preco
			FROM ModosPagamentoCarros mpc
				INNER JOIN ModosPagamento mp
					ON mp.Id = mpc.IdModo
						INNER JOIN Carros c
							ON c.Id = mpc.IdCarro
								INNER JOIN Modelos mo
									ON c.IdModelo = mo.Id
										INNER JOIN Marcas m
											ON mo.IdMarca = m.Id
												INNER JOIN Cores co
													ON co.Id = c.IdCor
														WHERE mp.Nome = @ModoPagamento
	END

--EXEC BuscarPreco @Preco = 200000000.00

--Buscar por adicionais-----------------------------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE PROCEDURE BuscarAdicionais
	@Adicional VARCHAR(100)
	AS
	BEGIN
		SELECT a.Nome AS Adicional,
		mo.Nome AS Modelo,
		m.Nome AS Marca,
		c.Ano,
		co.Nome AS Cor,
		c.Preco,
		mp.Nome AS ModoPagamento
			FROM Adicionais a
				INNER JOIN AdicionaisCarros ac
					ON a.Id = ac.IdAdicional
						INNER JOIN Carros c
							ON c.Id = ac.IdCarro
								INNER JOIN Modelos mo
									ON c.IdModelo = mo.Id
										INNER JOIN Marcas m
											ON mo.IdMarca = m.Id
												INNER JOIN Cores co
													ON co.Id = c.IdCor
														INNER JOIN ModosPagamentoCarros mpc
															ON mpc.IdCarro = c.Id
																INNER JOIN ModosPagamento mp
																	ON mp.Id = mpc.IdModo
																		WHERE a.Nome = @Adicional
	END