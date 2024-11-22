USE MASTER
GO
CREATE DATABASE CLINICA_DB
GO
USE CLINICA_DB
GO




CREATE TABLE Direcciones (
    id_direccion INT PRIMARY KEY IDENTITY(1000,1),
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    localidad VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL
);
GO

CREATE TABLE Niveles_acceso (
    id_acceso INT PRIMARY KEY IDENTITY(1,1),
    nivel_acceso VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Personas (
    dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nac DATE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    id_direccion INT NOT NULL,
    id_acceso INT NOT NULL,

    FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion),
    FOREIGN KEY (id_acceso) REFERENCES Niveles_acceso(id_acceso)
);
GO

CREATE TABLE Planes (
    id_plan INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Pacientes (
    numero_afiliado VARCHAR(100) PRIMARY KEY,
    dni VARCHAR(20),
	fecha_alta date default getdate(),
	id_plan int NOT NULL,
    estado bit default 1,

    FOREIGN KEY (dni) REFERENCES Personas(dni),
	FOREIGN KEY (id_plan) REFERENCES Planes(id_plan)
);
GO

CREATE TABLE Trabajadores (
    legajo VARCHAR(100) PRIMARY KEY,
    dni VARCHAR(20),
    fecha_ing date default getdate(),
    estado BIT DEFAULT 1,

    FOREIGN KEY (dni) REFERENCES Personas(dni)
);
GO

CREATE TABLE Especialidades (
    id_especialidad INT PRIMARY KEY IDENTITY(100,1),
    especialidad VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Horarios_Trabajador (
    legajo VARCHAR(100),
    dia VARCHAR(20) NOT NULL,
    id_especialidad INT,
	hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,

    PRIMARY KEY (legajo, dia),
    FOREIGN KEY (legajo) REFERENCES Trabajadores(legajo),
	FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad),
    CONSTRAINT CHK_Dia CHECK (dia IN ('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sábado', 'domingo'))
);
GO



CREATE TABLE Medico_x_especialidad (
    legajo VARCHAR(100),
    id_especialidad INT,

    PRIMARY KEY (legajo, id_especialidad),
    FOREIGN KEY (legajo) REFERENCES Trabajadores(legajo),
    FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad)
);
GO

CREATE TABLE Sanatorios (
    id_sanatorio INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
    id_direccion INT unique, 
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    estado BIT DEFAULT 1,

    FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion)
);
GO

CREATE TABLE Sanatorios_x_planes (
    id_sanatorio INT,
    id_plan INT,

    PRIMARY KEY (id_sanatorio, id_plan),
    FOREIGN KEY (id_sanatorio) REFERENCES Sanatorios(id_sanatorio),
    FOREIGN KEY (id_plan) REFERENCES Planes(id_plan)
);
GO

CREATE TABLE Turnos (
    id_turno INT PRIMARY KEY IDENTITY(1000,1),
    numero_afiliado VARCHAR(100),
    id_medico VARCHAR(100),
    especialidad VARCHAR(100) NOT NULL,
    fecha_hora DATETIME NOT NULL,
    motivo VARCHAR(255) NOT NULL,
    observaciones TEXT,
    estado VARCHAR(50) NOT NULL, --PROVISORIO --> DEBE IR A UNA TABLA APARTE

    FOREIGN KEY (numero_afiliado) REFERENCES Pacientes(numero_afiliado),
    FOREIGN KEY (id_medico) REFERENCES Trabajadores(legajo)
);
GO
select* from planes
CREATE TABLE Horarios_Disponibles(
	legajo VARCHAR(100),
	id_especialidad INT,
	Fecha DATETIME,
	hora TIME
)

CREATE TABLE Usuarios(
	Usuario VARCHAR(20),
	Pass VARCHAR(50),
	id_acceso INT NOT NULL,
	estado bit default 1

	PRIMARY KEY (Usuario,Pass),
	FOREIGN KEY(Usuario) REFERENCES Personas(dni)
)
GO

--Busca Empleado x dni
CREATE FUNCTION dbo.Obtener_Empleado(@DNI VARCHAR(20))
RETURNS TABLE
RETURN(
	SELECT P.dni, P.nombre, P.apellido, P.fecha_nac, P.telefono,P.email,T.legajo,T.fecha_ing,
		   D.id_direccion,D.calle, D.numero,D.localidad,D.codigo_postal, p.id_acceso,T.estado
	FROM Trabajadores T
	INNER JOIN Personas P ON P.dni = T.dni
	INNER JOIN Direcciones D ON D.id_direccion = P.id_direccion
	WHERE P.dni = @DNI
);
GO

--Busca Paciente x dni
CREATE FUNCTION dbo.Obtener_Paciente(@DNI VARCHAR(20))
RETURNS TABLE
RETURN(
	SELECT P.dni, P.nombre, P.apellido, P.fecha_nac, P.telefono,P.email,Pa.numero_afiliado, Pl.nombre as plan_pac,
		   Pl.id_plan,Pa.fecha_alta,D.id_direccion,D.calle, D.numero,D.localidad,D.codigo_postal, p.id_acceso,Pa.estado
	FROM Pacientes Pa
	INNER JOIN Personas P ON P.dni = Pa.dni
	INNER JOIN Direcciones D ON D.id_direccion = P.id_direccion
	INNER JOIN Planes Pl ON Pa.id_plan = Pl.id_plan
	WHERE P.dni = @DNI
);
GO

--Buscar Persona x dni
CREATE FUNCTION dbo.Obtener_Persona(@DNI VARCHAR(20))
RETURNS TABLE
RETURN(
	SELECT nombre,apellido,dni,fecha_nac,calle,P.id_direccion AS 'id_direccion',numero,
		   localidad,codigo_postal,telefono,email,id_acceso 
		   FROM Personas P
	INNER JOIN Direcciones D ON P.id_direccion = D.id_direccion
	WHERE dni = @DNI
);
GO

-- Busca Horarios asignados a cada empleado
CREATE FUNCTION dbo.Obtener_Horarios(@LEGAJO VARCHAR(100))
RETURNS TABLE
RETURN(
	SELECT legajo,dia,hora_inicio,hora_fin,e.id_especialidad as 'id_especialidad', e.especialidad as 'especialidad'  
	   from Horarios_Trabajador H
	INNER JOIN Especialidades E ON E.id_especialidad = H.id_especialidad
	WHERE legajo = @LEGAJO
);
GO

--Buscar Sanatorios por plan
CREATE FUNCTION dbo.Sanatorios_por_Plan(@ID_PLAN INT)
RETURNS TABLE
RETURN(

	SELECT S.id_sanatorio AS 'id_sanatorio',nombre,telefono,email,S.id_direccion AS 'id_direccion',
		   calle,numero,localidad,codigo_postal
	FROM Sanatorios_x_planes SP
	INNER JOIN Sanatorios S ON SP.id_sanatorio = S.id_sanatorio
	INNER JOIN Direcciones D ON S.id_direccion = D.id_direccion
	WHERE id_plan = @ID_PLAN AND estado = '1'
);
GO

--Buscar Medicos_x_especialidad
CREATE FUNCTION dbo.Buscar_Medicos(@ID_ESPECIALIDAD INT)
RETURNS TABLE
RETURN(
	SELECT T.legajo AS 'legajo',T.dni AS 'dni', nombre,apellido
	FROM Medico_x_especialidad MD
	INNER JOIN Trabajadores T ON MD.legajo = T.legajo
	INNER JOIN Personas P ON T.dni = P.dni
	WHERE id_especialidad = @ID_ESPECIALIDAD AND estado = '1'
);
GO

--vista para obtener todos los pacientes
CREATE VIEW vw_Lista_Pacientes
AS
SELECT Pa.numero_afiliado,P.dni,P.nombre,P.apellido,P.fecha_nac,P.telefono,
	   P.email, P.id_direccion,D.calle,D.numero,D.localidad,D.codigo_postal,
	   Pa.fecha_alta,Pl.id_plan,Pl.nombre AS plan_pac ,P.id_acceso
FROM Personas P
INNER JOIN Pacientes Pa ON P.dni = Pa.dni
INNER JOIN Direcciones D ON P.id_direccion = D.id_direccion
INNER JOIN Planes Pl ON Pa.id_plan = Pl.id_plan
WHERE Pa.estado = 1
GO

--vista para obtener todos los Empleados
CREATE VIEW vw_Lista_Empleados
AS
SELECT T.legajo,P.dni,P.nombre,P.apellido,P.fecha_nac,P.telefono,
	   P.email,T.fecha_ing, P.id_direccion,D.calle,D.numero,D.localidad,D.codigo_postal,
	   P.id_acceso
FROM Personas P
INNER JOIN Trabajadores T ON P.dni = T.dni
INNER JOIN Direcciones D ON P.id_direccion = D.id_direccion
WHERE T.estado = 1
GO

--vista para obtener todos los sanatorios
CREATE VIEW vw_Lista_Sanatorios
AS
SELECT id_sanatorio,S.nombre,telefono,email,S.id_direccion AS 'id_direccion',calle,numero,localidad,codigo_postal FROM Sanatorios S
INNER JOIN Direcciones D ON S.id_direccion = D.id_direccion
WHERE estado = '1'
GO


--FUNCION PARA OBTENER UN NUEVO NUMERO DE AFILIADO
CREATE FUNCTION ObtenerNuevoNumeroAfiliado()
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @NuevoNumero INT;
    DECLARE @NumeroAfiliado VARCHAR(100);

    SELECT @NuevoNumero = COUNT(*) + 10000 + 1 FROM Pacientes;
    SET @NumeroAfiliado = 'P' + CAST(@NuevoNumero AS VARCHAR(100));

    RETURN @NumeroAfiliado;
END;
GO

--Funcion para obtener nuevo numero de Legajo
CREATE FUNCTION ObtenerNuevoLegajo()
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @NuevoNumero INT;
    DECLARE @Legajo VARCHAR(100);

    SELECT @NuevoNumero = COUNT(*) + 7000 + 1 FROM Trabajadores;
    SET @Legajo = 'E' + CAST(@NuevoNumero AS VARCHAR(100));

    RETURN @Legajo;
END;
GO

-- Funcion para buscar un sanatorio
CREATE FUNCTION dbo.BuscarSanatorio(@ID INT)
RETURNS TABLE
RETURN(
	SELECT id_sanatorio,nombre, telefono,email,D.id_direccion AS 'id_direccion',
		   calle,numero,localidad,codigo_postal
	FROM Sanatorios S
	INNER JOIN Direcciones D ON S.id_direccion = D.id_direccion
	WHERE id_sanatorio = @ID AND estado = '1'
);
GO

-- Funcion para obtener el proximo id de un sanatorio
CREATE FUNCTION dbo.ObtenerNuevoIdSanatorio()
RETURNS INT
AS
BEGIN
	DECLARE @ID INT = 0
	SELECT @ID = IDENT_CURRENT('Sanatorios')+1 

	RETURN @ID
END
GO

CREATE FUNCTION dbo.ObtenerNuevoIdPlan()
RETURNS INT
AS
BEGIN
	DECLARE @ID INT
	SELECT @ID = IDENT_CURRENT('Planes')+1 

	RETURN @ID
END
GO

-- Creacion de paciente + direccion asociada + Usuario de la pagina
CREATE PROCEDURE sp_Crear_Paciente(
	@pDNI VARCHAR(20),
	@pNOMBRE VARCHAR(100),
	@pAPELLIDO VARCHAR(100),
	@pFECHA_NAC DATE,
	@pTELEFONO VARCHAR(20),
	@pEMAIL VARCHAR(100),
	@pCALLE VARCHAR(100),
	@pNUMERO VARCHAR(10),
	@pLOCALIDAD VARCHAR(100),
	@pCOD_POSTAL VARCHAR(10),
	@pID_PLAN INT
	)AS
BEGIN
	DECLARE @ID_DIRECCION INT
	DECLARE @PASS VARCHAR(4)
	DECLARE @NUM_AFILIADO VARCHAR(100)

	SET @PASS = RIGHT(@pDNI, 4);

	INSERT Direcciones (calle,numero,localidad,codigo_postal)
	VALUES (@pCALLE,@pNUMERO,@pLOCALIDAD,@pCOD_POSTAL)
	
	SELECT @ID_DIRECCION = IDENT_CURRENT('Direcciones')

	IF EXISTS (SELECT 1 FROM Personas WHERE dni = @pDNI)
	BEGIN
		UPDATE Personas set nombre=@pNOMBRE, apellido = @pAPELLIDO, fecha_nac = @pFECHA_NAC,
			   telefono = @pTELEFONO, email = @pEMAIL,id_direccion = @ID_DIRECCION,id_acceso = '1'
		WHERE dni = @pDNI

		UPDATE Usuarios set Pass = @PASS, id_acceso = '1', estado = '1'
		WHERE Usuario = @pDNI 
	END

	ELSE BEGIN
		INSERT Personas (dni,nombre,apellido,fecha_nac,telefono,email,id_direccion,id_acceso)
		VALUES (@pDNI,@pNOMBRE,@pAPELLIDO,@pFECHA_NAC,@pTELEFONO,@pEMAIL,@ID_DIRECCION,'1')

		INSERT Usuarios (Usuario,Pass,id_acceso)
		VALUES (@pDNI,@PASS,'1')
	END

	SET @NUM_AFILIADO = dbo.ObtenerNuevoNumeroAfiliado();

	INSERT Pacientes (numero_afiliado,dni,id_plan)
	VALUES (@NUM_AFILIADO,@pDNI,@pID_PLAN)
	
END
GO

-- Creacion de Empleado + direccion asociada + Usuario de la pagina
CREATE PROCEDURE sp_Crear_Empleado(
	@pDNI VARCHAR(20),
	@pNOMBRE VARCHAR(100),
	@pAPELLIDO VARCHAR(100),
	@pFECHA_NAC DATE,
	@pTELEFONO VARCHAR(20),
	@pEMAIL VARCHAR(100),
	@pCALLE VARCHAR(100),
	@pNUMERO VARCHAR(10),
	@pLOCALIDAD VARCHAR(100),
	@pCOD_POSTAL VARCHAR(10),
	@pID_ACCESO INT
	)AS
BEGIN
	DECLARE @ID_DIRECCION INT
	DECLARE @PASS VARCHAR(4)
	DECLARE @Legajo VARCHAR(100)

	SET @PASS = RIGHT(@pDNI, 4);

	INSERT Direcciones (calle,numero,localidad,codigo_postal)
	VALUES (@pCALLE,@pNUMERO,@pLOCALIDAD,@pCOD_POSTAL)

	SELECT @ID_DIRECCION = IDENT_CURRENT('Direcciones')

	IF EXISTS (SELECT 1 FROM Personas WHERE DNI = @pDNI)
	BEGIN
		UPDATE Personas set nombre=@pNOMBRE, apellido = @pAPELLIDO, fecha_nac = @pFECHA_NAC,
			   telefono = @pTELEFONO, email = @pEMAIL,id_direccion = @ID_DIRECCION,id_acceso = @pID_ACCESO
		WHERE dni = @pDNI

		UPDATE Usuarios set Pass = @PASS, id_acceso = @pID_ACCESO, estado = '1'
		WHERE Usuario = @pDNI
	END
	
	ELSE BEGIN
			INSERT Personas (dni,nombre,apellido,fecha_nac,telefono,email,id_direccion,id_acceso)
			VALUES (@pDNI,@pNOMBRE,@pAPELLIDO,@pFECHA_NAC,@pTELEFONO,@pEMAIL,@ID_DIRECCION,@pID_ACCESO)	
			
			INSERT Usuarios (Usuario,Pass,id_acceso)
			VALUES (@pDNI,@PASS,@pID_ACCESO)
	END

	SET @Legajo = dbo.ObtenerNuevoLegajo();

	INSERT Trabajadores(legajo,dni)
	VALUES (@Legajo,@pDNI)

END
GO

--Agregar Sanatorio
CREATE PROCEDURE sp_Agregar_Sanatorio(
	@pNOMBRE VARCHAR(100),
	@pCALLE VARCHAR(100),
	@pNUMERO VARCHAR(100),
	@pLOCALIDAD VARCHAR(100),
	@pCOD_POSTAL VARCHAR(100),
	@pTELEFONO VARCHAR(100),
	@pEMAIL VARCHAR(100)
	)AS
BEGIN
	DECLARE @ID_DIRECCION INT
	
	INSERT Direcciones(calle,numero,localidad,codigo_postal)
	VALUES (@pCALLE,@pNUMERO,@pLOCALIDAD,@pCOD_POSTAL)

	SELECT @ID_DIRECCION = IDENT_CURRENT('Direcciones')

	INSERT Sanatorios (id_direccion,nombre,telefono,email)
	VALUES (@ID_DIRECCION,@pNOMBRE,@pTELEFONO,@pEMAIL)

	select*from Sanatorios

END
GO

--Modificar Empleado
CREATE PROCEDURE sp_Modificar_Empleado(
	@pLEGAJO VARCHAR(100),
	@pDNI VARCHAR(20),
	@pNOMBRE VARCHAR(100),
	@pAPELLIDO VARCHAR(100),
	@pFECHA_NAC DATE,
	@pTELEFONO VARCHAR(20),
	@pEMAIL VARCHAR(100),
	@pID_DIRECCION INT,
	@pCALLE VARCHAR(100),
	@pNUMERO VARCHAR(10),
	@pLOCALIDAD VARCHAR(100),
	@pCOD_POSTAL VARCHAR(10),
	@pID_ACCESO INT	
	)AS
BEGIN
	
	IF (SELECT COUNT(*) FROM Medico_x_especialidad WHERE legajo = @pLEGAJO) <> 0
	BEGIN
		-- Elimina las especialidades asignadas para volverlas a cargar
		DELETE Medico_x_especialidad WHERE legajo = @pLEGAJO
	END

	UPDATE Direcciones SET calle = @pCALLE,numero = @pNUMERO,localidad = @pLOCALIDAD, codigo_postal = @pCOD_POSTAL
	WHERE id_direccion = @pID_DIRECCION
	
	UPDATE Personas SET nombre = @pNOMBRE,apellido = @pAPELLIDO,fecha_nac = @pFECHA_NAC,telefono = @pTELEFONO,
		   email = @pEMAIL,id_direccion = @pID_DIRECCION,id_acceso = @pID_ACCESO
	WHERE dni = @pDNI

	UPDATE Usuarios SET id_acceso = @pID_ACCESO
	WHERE Usuario = @pDNI

END
GO

--Modificar Paciente
CREATE PROCEDURE sp_Modificar_Paciente(
	@pDNI VARCHAR(20),
	@pNOMBRE VARCHAR(100),
	@pAPELLIDO VARCHAR(100),
	@pFECHA_NAC DATE,
	@pTELEFONO VARCHAR(20),
	@pEMAIL VARCHAR(100),
	@pID_DIRECCION INT,
	@pCALLE VARCHAR(100),
	@pNUMERO VARCHAR(10),
	@pLOCALIDAD VARCHAR(100),
	@pCOD_POSTAL VARCHAR(10),
	@pID_PLAN INT
	)AS
BEGIN
	UPDATE Direcciones SET calle = @pCALLE,numero = @pNUMERO,localidad = @pLOCALIDAD, codigo_postal = @pCOD_POSTAL
	WHERE id_direccion = @pID_DIRECCION
	
	UPDATE Personas SET nombre = @pNOMBRE,apellido = @pAPELLIDO,fecha_nac = @pFECHA_NAC,telefono = @pTELEFONO,
		   email = @pEMAIL,id_direccion = @pID_DIRECCION, id_acceso = '1'
	WHERE dni = @pDNI

	UPDATE Pacientes SET id_plan = @pID_PLAN
	WHERE dni = @pDNI

	UPDATE Usuarios SET id_acceso = '1'
	WHERE Usuario = @pDNI
END
GO

--ASIGANAR ESPECIALIDADES A EMPLEADOS
CREATE PROCEDURE sp_Asignar_Especialidades(
	@pLEGAJO VARCHAR(100),
	@pID_ESPECIALIDAD INT
	)AS	
BEGIN
	
	IF(SELECT COUNT(*) FROM Medico_x_especialidad WHERE legajo = @pLEGAJO AND id_especialidad = @pID_ESPECIALIDAD) = 0
	BEGIN
		INSERT Medico_x_especialidad (legajo,id_especialidad)
		VALUES (@pLEGAJO,@pID_ESPECIALIDAD)
	END
END
GO

-- ASIGNAR HORARIOS A TRABAJADOR
CREATE PROCEDURE sp_Cargar_Horario(
	@pLEGAJO VARCHAR(100),
    @pDIA VARCHAR(20),
    @pHORA_INICIO TIME,
    @pHORA_FIN TIME,
	@pID_ESPECIALIDAD INT
	)AS
BEGIN

	IF (SELECT COUNT(*) 
		FROM Medico_x_especialidad 
		WHERE legajo = @pLEGAJO AND id_especialidad = @pID_ESPECIALIDAD) = 0
	BEGIN
		RETURN;		-- ESPECIALIDAD NO ASIGNADA A ESTE LEGAJO
	END

	
	IF(@pHORA_INICIO < @pHORA_FIN)
	BEGIN
		INSERT Horarios_Trabajador (legajo,dia,hora_inicio,hora_fin,id_especialidad)
		VALUES (@pLEGAJO,LOWER(@pDIA),@pHORA_INICIO,@pHORA_FIN,@pID_ESPECIALIDAD)
	END
END
GO

-- ELIMINAR HORARIOS A TRABAJADOR
CREATE PROCEDURE sp_Eliminar_Horario(
	@pLEGAJO VARCHAR(100),
	@pDIA VARCHAR(20)
	)AS
BEGIN
	DELETE FROM Horarios_Trabajador WHERE legajo = @pLEGAJO AND dia = LOWER(@pDIA)
END
GO


--BAJA LOGICA TRABAJADOR
CREATE PROCEDURE sp_Baja_Trabajador(
	@pDNI VARCHAR(20)
	)AS
BEGIN
	DECLARE @LEGAJO VARCHAR(100)
	SELECT @LEGAJO = legajo FROM dbo.Obtener_Empleado(@pDNI);

	DELETE Medico_x_especialidad WHERE legajo = @LEGAJO

	UPDATE Usuarios SET estado = 0 WHERE Usuario = @pDNI
	UPDATE Trabajadores SET estado = 0 WHERE dni = @pDNI
END
GO

--BAJA LOGICA PACIENTE
CREATE PROCEDURE sp_Baja_Paciente(
	@pDNI VARCHAR(20)
	)AS
BEGIN
	UPDATE Usuarios SET estado = 0 WHERE Usuario = @pDNI
	UPDATE Pacientes SET estado = 0 WHERE dni = @pDNI
END
GO

--RESTABLECER CONTRASENIA
CREATE PROCEDURE sp_Restablecer_Pass(
	@pDNI VARCHAR(20)
	)AS
BEGIN	
	DECLARE @PASS VARCHAR(4)
	SET @PASS = RIGHT(@pDNI, 4);

	UPDATE Usuarios SET Pass = @PASS WHERE Usuario = @pDNI
END
GO


--------------------------------------------------------- INSERT DATOS ----------------------------------


INSERT Niveles_acceso(nivel_acceso)
VALUES ('PACIENTE'),('RECEPCIONISTA'),('MEDICO'),('ADMIN')
GO

INSERT Especialidades (especialidad)
VALUES 
('Clinica'),('Pediatria'),('Dermatologia'),('Cardiologia'),
('Oncologia'),('Neumologia')
GO

INSERT Planes (nombre)
VALUES ('STANDARD'),('BRONCE'),('PLATINUM'),('GOLD')

EXEC sp_Crear_Paciente '11111111', 'Juan Carlos','Martinez','1985-03-15','1145678901','juan.martinez85@gmail.com','AV Santa Fe','1234','Buenos Aires','1059',1

--Creo Recepcionista
EXEC sp_Crear_Empleado '22222222','María Elena','Gomez','1990-07-22','2617891234','maria.gomez90@hotmail.com','Calle 50','789','La Plata','1900',2

--Creo Medico
EXEC sp_Crear_Empleado '33333333','Marcos','Gomez','2000-07-22','1559381788','marcos@hotmail.com','Calle 5','7890','Mar del Plata','1100',3

--Creo Administrador
EXEC sp_Crear_Empleado '42832435','Brian','Barrera','2000-08-02','1167624662','barreragomezb2800@gmail.com','Calle admin','1234','loc admin','1100',4

EXEC sp_Asignar_Especialidades 'E7002','101'
EXEC sp_Asignar_Especialidades 'E7002','105'
EXEC sp_Asignar_Especialidades 'E7002','102'

EXEC sp_Cargar_Horario 'E7002','LUNES','08:00:00','13:00:00','101'
EXEC sp_Cargar_Horario 'E7002','MARTES','10:00:00','15:00:00','105'
EXEC sp_Cargar_Horario 'E7002','JUEVES','13:00:00','17:00:00','102'

EXEC sp_Agregar_Sanatorio 'Sanatorio Finochietto', 'Av. Principal', '123', 'Ciudad A','1000','123456789', 'finochietto@sanatorio.com';
EXEC sp_Agregar_Sanatorio 'Sanatorio Anchorena', 'Calle Norte', '45', 'Ciudad B','2000', '987654321', 'anchorena@sanatorio.com';
EXEC sp_Agregar_Sanatorio 'Sanatorio Guemes', 'Calle Sur', '67', 'Ciudad C', '3000', '555666777', 'guemes@sanatorio.com';
EXEC sp_Agregar_Sanatorio 'Sanatorio Trinidad', 'Calle Este', '89', 'Ciudad D', '4000', '222333444', 'trinidad@sanatorio.com';
EXEC sp_Agregar_Sanatorio 'Clinica Zabala', 'Calle Oeste', '101', 'Ciudad E','5000', '111222333','zabala@sanatorio.com';

--Asignacion plan standard
INSERT Sanatorios_x_planes (id_sanatorio,id_plan)
VALUES ('1','1'),('2','1'),('3','1')

--Asignacion plan bronce
INSERT Sanatorios_x_planes (id_sanatorio,id_plan)
VALUES ('1','2'),('5','2')

--Asignacion plan platinum
INSERT Sanatorios_x_planes (id_sanatorio,id_plan)
VALUES ('1','3'),('5','3')

--Asignacion plan gold
INSERT Sanatorios_x_planes (id_sanatorio,id_plan)
VALUES ('1','4'),('2','4'),('3','4'),('4','4'),('5','4')

SELECT* FROM Sanatorios
SELECT* FROM Planes

select* from Sanatorios_x_planes