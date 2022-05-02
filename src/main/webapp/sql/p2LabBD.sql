CREATE DATABASE p2LabBD
GO
USE p2LabBD

/*
CREATE TABLE times(
	codigoTime		INT				NOT NULL	IDENTITY(1,1),
	nomeTime		VARCHAR(100)	NOT NULL,
	cidade			VARCHAR(100)	NOT NULL,
	estadio			VARCHAR(100)	NOT NULL,
	fl_unico_time	BIT				NOT NULL
	PRIMARY KEY(codigoTime)
)

CREATE TABLE grupos(
	codigoGrupo		INT				NOT NULL	IDENTITY(1,1),
	nome			VARCHAR(1)		NOT NULL	CHECK(UPPER(nome) = 'A' OR 
													  UPPER(nome) = 'B' OR 
													  UPPER(nome) = 'C' OR 
													  UPPER(nome) = 'D')
	PRIMARY KEY(codigoGrupo)
)

CREATE TABLE grupos_times(
	codigoTime		INT,
	codigoGrupo		INT				
	PRIMARY KEY(codigoTime, codigoGrupo)
	FOREIGN KEY(codigoGrupo) REFERENCES grupos(codigoGrupo),
	FOREIGN KEY(codigoTime) REFERENCES times(codigoTime)
)

CREATE TABLE jogos(
	CodigoTimeA		INT				NOT NULL,
	CodigoTimeB		INT				NOT NULL,
	GolsTimeA		INT				,
	GolsTimeB		INT				,
	Data			DATE				
	PRIMARY KEY(CodigoTimeA, CodigoTimeB),
	FOREIGN KEY(CodigoTimeA) REFERENCES times(CodigoTime),
	FOREIGN KEY(CodigoTimeB) REFERENCES times(CodigoTime)
)

CREATE TABLE datas_jogos(
	dia				DATE			NOT NULL,
	fl_passou		BIT				NOT NULL
	PRIMARY KEY(dia)
)

/*Declaração de constantes*/
INSERT INTO times VALUES('Corinthians', 'São Paulo', 'Neo Química Arena', 1),
						('Palmeiras', 'São Paulo', 'Allianz Parque', 1),
						('São Paulo', 'São Paulo', 'Morumbi', 1),
						('Santos', 'Santos', 'Vila Belmiro', 1),
						('Botafogo-SP', 'Ribeirão Preto', 'Santa Cruz', 0),
						('Ferroviária', 'Araraquara', 'Fonte Luminosa', 0),
						('Guarani', 'Campinas', 'Brinco de Ouro', 0),
						('Inter de Limeira', 'Limeira', 'Limeirão', 0),
						('Ituano', 'Itu', 'Novelli Júnior', 0),
						('Mirassol', 'Mirassol', 'José Maria de Campos Maia', 0),
						('Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biasi', 0),
						('Ponte Preta', 'Campinas', 'Moisés Lucarelli', 0),
						('Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid', 0),
						('Santo André', 'Santo André', 'Bruno José Daniel', 0),
						('São Bento', 'Sorocaba', 'Walter Ribeiro', 0),
						('São Caetano', 'São Caetano do Sul', 'Anacletto Campanella', 0)

INSERT INTO grupos VALUES ('A'), ('B'), ('C'), ('D')

INSERT INTO datas_jogos VALUES ('2022-02-27', 0), ('2022-03-02', 0), ('2022-03-06', 0), 
('2022-03-09', 0), ('2022-03-13', 0), ('2022-03-16', 0), 
('2022-03-20', 0), ('2022-03-23', 0), ('2022-03-27', 0),
('2022-03-30', 0), ('2022-04-03', 0), ('2022-04-06', 0)

/*Procedure para separar os times nos grupos*/
CREATE PROCEDURE sp_gerador_grupos 
AS
	
	/*Limpa a separação de gupos passada*/
	DELETE FROM grupos_times

	DECLARE @loop INT
	SET @loop = 1

	WHILE(@loop < 5)BEGIN
		DECLARE @time INT
		SELECT TOP 1 @time = t.codigoTime FROM times AS t 
		LEFT JOIN grupos_times AS gt ON gt.codigoTime = t.codigoTime
		WHERE fl_unico_time = 1 AND gt.codigoTime IS NULL ORDER BY NEWID()
		INSERT INTO grupos_times VALUES(@time, @loop)
		SET @loop = @loop + 1
	END

	SET @loop = 1
	WHILE (@loop < 13)BEGIN
		DECLARE @grupo INT

		SELECT TOP 1 @time = t.codigoTime FROM times AS t 
		LEFT JOIN grupos_times AS gt ON gt.codigoTime = t.codigoTime
		WHERE fl_unico_time = 0 AND gt.codigoTime IS NULL ORDER BY NEWID()

		SELECT TOP 1 @grupo = g.codigoGrupo FROM grupos AS g
		INNER JOIN grupos_times AS gt ON gt.codigoGrupo = g.codigoGrupo
		GROUP BY g.codigoGrupo
		HAVING COUNT(g.codigoGrupo) < 4
		ORDER BY NEWID()

		INSERT INTO grupos_times VALUES(@time, @grupo) 

		SET @loop = @loop + 1
	END

/*Procedure para separar os times*/
CREATE PROCEDURE sp_grupos_rodadas(@rodada INT, @jogos INT, @codigoA INT OUTPUT, @codigoB INT OUTPUT) 
AS
	IF(@rodada <= 4)BEGIN
		IF(@jogos <= 4)BEGIN
			SET @codigoA = 1
			SET @codigoB = 2
		END
		ELSE
		BEGIN
			SET @codigoA = 3
			SET @codigoB = 4
		END
	END

	IF(@rodada > 4 AND @rodada <= 8)BEGIN
		IF(@jogos <= 4)BEGIN
			SET @codigoA = 1
			SET @codigoB = 4
		END
		ELSE
		BEGIN
			SET @codigoA = 2
			SET @codigoB = 3
		END
	END

	IF(@rodada > 8)BEGIN
		IF(@jogos <= 4)BEGIN
			SET @codigoA = 1
			SET @codigoB = 3
		END
		ELSE
		BEGIN
			SET @codigoA = 2
			SET @codigoB = 4
		END
	END

/*Procedure para gerar os jogos*/
CREATE PROCEDURE sp_gerador_jogos
AS

/*Limpa as ultimas partidas*/
DELETE FROM jogos
UPDATE datas_jogos SET fl_passou = 0

/*Separa os grupos caso não estejam separados*/
IF(ISNULL((SELECT COUNT(codigoTime) FROM grupos_times), 0) = 0)BEGIN
	exec sp_gerador_grupos
END

DECLARE @loopRodada INT, @data DATE
SET @loopRodada = 1
SELECT TOP 1 @data = dia FROM datas_jogos WHERE fl_passou != 1 ORDER BY NEWID()

WHILE(@loopRodada < 13)BEGIN
	DECLARE @loopJogos INT
	SET @loopJogos = 1
	WHILE(@loopJogos < 9)BEGIN
		DECLARE @loopValido BIT, @grupoA INT, @grupoB INT
		SET @loopValido = 0

		EXEC sp_grupos_rodadas @loopRodada, @loopJogos, @grupoA OUTPUT, @grupoB OUTPUT

		/*Prevenção de Deadlock*/
		DECLARE @temp TABLE (CodigoTime INT, CodigoGrupo INT)
		DELETE FROM @temp

		IF(@loopRodada % 2 = 0)BEGIN
			IF(@loopJogos % 2 = 0)BEGIN
				INSERT INTO @temp
				SELECT TOP 2 * FROM grupos_times WHERE codigoGrupo = @grupoA ORDER BY codigoTime ASC
				INSERT INTO @temp
				SELECT TOP 2 * FROM grupos_times WHERE codigoGrupo = @grupoB ORDER BY codigoTime ASC
			END
			ELSE
			BEGIN
				INSERT INTO @temp
				SELECT TOP 2 * FROM grupos_times WHERE codigoGrupo = @grupoA ORDER BY codigoTime DESC
				INSERT INTO @temp
				SELECT TOP 2 * FROM grupos_times WHERE codigoGrupo = @grupoB ORDER BY codigoTime DESC
			END
		END
		ELSE
		BEGIN
			IF(@loopJogos % 2 = 0)BEGIN
				INSERT INTO @temp
				SELECT TOP 2 * FROM grupos_times WHERE codigoGrupo = @grupoA ORDER BY codigoTime ASC
				INSERT INTO @temp
				SELECT TOP 2 * FROM grupos_times WHERE codigoGrupo = @grupoB ORDER BY codigoTime DESC
			END
			ELSE
			BEGIN
				INSERT INTO @temp
				SELECT TOP 2 * FROM grupos_times WHERE codigoGrupo = @grupoA ORDER BY codigoTime DESC
				INSERT INTO @temp
				SELECT TOP 2 * FROM grupos_times WHERE codigoGrupo = @grupoB ORDER BY codigoTime ASC
			END
		END

		/*Loop para validação da partida*/
		WHILE(@loopValido = 0)BEGIN
			DECLARE @timeA INT, @timeB INT, @golsA INT, @golsB INT 
			
			SELECT TOP 1 @timeA = codigoTime FROM @temp 
			WHERE codigoGrupo = @grupoA
			AND codigoTime NOT IN(SELECT codigoTimeA FROM jogos WHERE Data = @data)
			ORDER BY NEWID() 

			SELECT TOP 1 @timeB = codigoTime FROM @temp
			WHERE codigoGrupo = @grupoB
			AND codigoTime NOT IN(SELECT codigoTimeB FROM jogos WHERE Data = @data)
			ORDER BY NEWID()
			
			IF((SELECT codigoTimeA FROM jogos WHERE CodigoTimeA = @timeA AND CodigoTimeB = @timeB) IS NULL)BEGIN
				INSERT INTO jogos(CodigoTimeA, CodigoTimeB, Data) VALUES (@timeA, @timeB, @data)
				SET @loopValido = 1
				SET @loopJogos = @loopJogos + 1
			END

		END
		
	END

	UPDATE datas_jogos SET fl_passou = 1 WHERE dia = @data
	SELECT TOP 1 @data = dia FROM datas_jogos WHERE fl_passou != 1 ORDER BY NEWID()
	SET @loopRodada = @loopRodada + 1
END
*/

EXEC sp_gerador_jogos
EXEC sp_gerador_grupos

SELECT * FROM grupos_times ORDER BY CodigoGrupo 
SELECT * FROM jogos ORDER BY Data

/*Inicio da P2*/


/*TRIGGERS*/
CREATE TRIGGER t_grupos ON grupos_times
AFTER INSERT, UPDATE, DELETE
AS
	RAISERROR('A tabela de grupos não pode ser alterada', 16, 1)
	ROLLBACK TRANSACTION

CREATE TRIGGER t_jogos ON jogos
AFTER INSERT, DELETE
AS
	RAISERROR('Jogos não podem ser inseridos ou excluidos', 16, 1)
	ROLLBACK TRANSACTION

/*SP INSERIR GOLS*/

CREATE PROCEDURE sp_marcar_gols(@golsTimeA INT, @golsTimeB INT, @timeA VARCHAR(100), @timeB VARCHAR(100))
AS
BEGIN
	DECLARE @codigoTimeA INT, @codigoTimeB INT
	SELECT @codigoTimeA = codigoTime FROM times WHERE nomeTime LIKE '%'+@timeA+'%'
	SELECT @codigoTimeB = codigoTime FROM times WHERE nomeTime LIKE '%'+@timeB+'%'

	UPDATE jogos SET GolsTimeA = @golsTimeA, GolsTimeB = @golsTimeB
	WHERE CodigoTimeA = @codigoTimeA AND CodigoTimeB = @codigoTimeB
END

/*FUNCTION TABELA GERAL*/

CREATE FUNCTION fn_tabela_geral()
RETURNS @tabela TABLE (
nomeTime		VARCHAR(100),
jogosDisputados	INT,
vitorias		INT,
empates			INT,
derrotas		INT,
golsMarcados	INT,
golsSofridos	INT,
saldoGols		INT,
pontos			INT,
fg_rebaixamento BIT		DEFAULT(0)
)
AS
BEGIN

	DECLARE @loopJogos INT
	SET @loopJogos = 1
	WHILE(@loopJogos < 17)
	BEGIN
		DECLARE @nome VARCHAR(100), @jogosDisputados INT, @vitorias INT, @empates INT, @derrotas INT, @marcados INT,
		@sofridos INT, @saldo INT, @pontos INT

		SELECT @nome = nomeTime FROM times WHERE codigoTime = @loopJogos

		SELECT @jogosDisputados = COUNT(CodigoTimeA) FROM jogos WHERE CodigoTimeA = @loopJogos AND GolsTimeA IS NOT NULL
		SET @jogosDisputados = @jogosDisputados + (SELECT COUNT(CodigoTimeB) FROM jogos WHERE CodigoTimeB = @loopJogos AND GolsTimeB IS NOT NULL)

		SELECT @vitorias = COUNT(CodigoTimeA) FROM jogos WHERE CodigoTimeA = @loopJogos AND GolsTimeA > GolsTimeB
		SET @vitorias = @vitorias + (SELECT COUNT(CodigoTimeB) FROM jogos WHERE CodigoTimeB = @loopJogos AND GolsTimeB > GolsTimeA)

		SELECT @empates = COUNT(CodigoTimeA) FROM jogos WHERE CodigoTimeA = @loopJogos AND GolsTimeA = GolsTimeB
		SET @empates = @empates + (SELECT COUNT(CodigoTimeB) FROM jogos WHERE CodigoTimeB = @loopJogos AND GolsTimeB = GolsTimeA)

		SELECT @derrotas = COUNT(CodigoTimeA) FROM jogos WHERE CodigoTimeA = @loopJogos AND GolsTimeA < GolsTimeB
		SET @derrotas = @derrotas + (SELECT COUNT(CodigoTimeB) FROM jogos WHERE CodigoTimeB = @loopJogos AND GolsTimeB < GolsTimeA)

		SELECT @marcados = SUM(GolsTimeA) FROM jogos WHERE CodigoTimeA = @loopJogos
		SET @marcados = ISNULL(@marcados, 0) + ISNULL((SELECT SUM(GolsTimeB) FROM jogos WHERE CodigoTimeB = @loopJogos), 0)

		SELECT @sofridos = SUM(GolsTimeB) FROM jogos WHERE CodigoTimeA = @loopJogos
		SET @sofridos = ISNULL(@sofridos, 0) + ISNULL((SELECT SUM(GolsTimeA) FROM jogos WHERE CodigoTimeB = @loopJogos), 0)

		SET @saldo = @marcados - @sofridos

		SET @pontos = (3 * @vitorias) + @empates

		INSERT INTO @tabela VALUES (@nome, @jogosDisputados, @vitorias, @empates, @derrotas, @marcados, @sofridos, @saldo, @pontos, default)

		SET @loopJogos = @loopJogos + 1
	END

	;WITH tabela AS 
	( 
	SELECT TOP 2 * 
	FROM @tabela 
	ORDER BY pontos ASC, vitorias ASC, golsMarcados ASC, saldoGols ASC 
	) 
	UPDATE tabela SET fg_rebaixamento = 1
 
	RETURN
END

/*FUNCTION TABELA GRUPOS*/

CREATE FUNCTION fn_tabela_grupos(@grupo VARCHAR(15))
RETURNS @tabela TABLE (
nomeTime		VARCHAR(100),
jogosDisputados	INT,
vitorias		INT,
empates			INT,
derrotas		INT,
golsMarcados	INT,
golsSofridos	INT,
saldoGols		INT,
pontos			INT,
fg_rebaixamento BIT		DEFAULT(0)
)
AS
BEGIN
	
	DECLARE @codigoGrupo INT
	SELECT @codigoGrupo = codigoGrupo FROM grupos WHERE nome LIKE '%'+@grupo+'%'

	INSERT INTO @tabela
	SELECT tb.nomeTime, tb.jogosDisputados, tb.vitorias, tb.empates, tb.derrotas, tb.golsMarcados, tb.golsSofridos, tb.saldoGols, tb.pontos, tb.fg_rebaixamento
	FROM fn_tabela_geral() AS tb  
	INNER JOIN times AS t ON t.nomeTime = tb.nomeTime 
	INNER JOIN grupos_times AS gt ON gt.codigoTime = t.codigoTime
	WHERE gt.codigoGrupo = @codigoGrupo
 
	RETURN
END

/*FUNCTION JOGOS "FORMATADOS"*/

CREATE FUNCTION fn_jogos(@data VARCHAR(15))
RETURNS @tabela TABLE (
timeA		VARCHAR(100),
timeB		VARCHAR(100),
golsTimeA		INT,
golsTimeB		INT,
Data			VARCHAR(100)
)
AS
BEGIN
	
	INSERT INTO @tabela
	SELECT ta.nomeTime AS timeA, tb.nomeTime AS timeB, j.GolsTimeA, j.GolsTimeB, CONVERT(VARCHAR, Data, 103) AS Data FROM jogos AS j 
	INNER JOIN times AS ta ON j.CodigoTimeA = ta.codigoTime
	INNER JOIN times AS tb ON j.CodigoTimeB = tb.codigoTime
	WHERE Data = @data
 
	RETURN
END

/*STORED PROCEDURE jogos aleatórios*/

CREATE PROCEDURE sp_marcar_aleatorios
AS
BEGIN
	DECLARE @loop INT
SET @loop = 1

	UPDATE jogos SET GolsTimeA = NULL, GolsTimeB = NULL

	WHILE(@loop < 97)BEGIN
		

		;WITH tabela AS 
		( 
		SELECT TOP 1 * 
		FROM jogos
		WHERE GolsTimeA IS NULL
		ORDER BY NEWID()
		)
		UPDATE tabela SET GolsTimeA = CAST((RAND() * 5) AS INT), GolsTimeB = CAST((RAND() * 5) AS INT)

	SET @loop = @loop + 1
	END
END

/*FUNCTION PROJEÇÂO DAS QUARTAS DE FINAL*/

CREATE FUNCTION fn_quartas()
RETURNS @tabela TABLE (
timeA		VARCHAR(100),
timeB		VARCHAR(100)
)
AS
BEGIN
	
	DECLARE @time1 VARCHAR(100), @time2 VARCHAR(100), @grupo VARCHAR(1), @loop INT
	SET @loop = 1


	WHILE(@loop < 5)BEGIN
		SELECT @grupo = nome FROM grupos WHERE codigoGrupo = @loop

		SELECT TOP 1 @time1 = nomeTime FROM fn_tabela_grupos(@grupo) ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC 
	
		SELECT TOP 1 @time2 = nomeTime FROM fn_tabela_grupos(@grupo) WHERE nomeTime != @time1
		ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

		INSERT INTO @tabela VALUES(@time1, @time2)

		SET @loop = @loop + 1
	END

	RETURN
END

SELECT * FROM grupos
EXEC sp_marcar_aleatorios

SELECT * FROM fn_quartas()

DROP FUNCTION fn_tabela_geral

SELECT * FROM fn_tabela_grupos('D') ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM fn_tabela_geral() ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM times

SELECT * FROM jogos WHERE CodigoTimeA = 5 AND CodigoTimeB = 1

SELECT * FROM fn_jogos('02/03/2022')

UPDATE jogos SET GolsTimeA = NULL, GolsTimeB = NULL

DECLARE @loop INT
SET @loop = 1

WHILE(@loop < 97)BEGIN

	;WITH tabela AS 
	( 
	SELECT TOP 1 * 
	FROM jogos
	WHERE GolsTimeA IS NULL
	ORDER BY NEWID()
	)
	UPDATE tabela SET GolsTimeA = CAST((RAND() * 5) AS INT), GolsTimeB = CAST((RAND() * 5) AS INT)

SET @loop = @loop + 1
END

SELECT *, CONVERT(VARCHAR, data, 103) AS dia FROM jogos WHERE data = '27/02/2022' 

SELECT CONVERT(VARCHAR, dia, 103) AS dia FROM datas_jogos

SELECT ta.nomeTime AS timeA, tb.nomeTime AS timeB, j.GolsTimeA, j.GolsTimeB, CONVERT(VARCHAR, Data, 103) AS Data FROM jogos AS j 
INNER JOIN times AS ta ON j.CodigoTimeA = ta.codigoTime
INNER JOIN times AS tb ON j.CodigoTimeB = tb.codigoTime
WHERE Data = '27/02/2022'