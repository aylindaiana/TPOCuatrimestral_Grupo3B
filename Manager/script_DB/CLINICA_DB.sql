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

CREATE TABLE Horarios(
	id_horario BIGINT PRIMARY KEY IDENTITY(1,1),
	turno_horario VARCHAR(100)
)
GO

CREATE TABLE Trabajadores_x_Horario(
	legajo VARCHAR(100),
	id_horario BIGINT,

	PRIMARY KEY (legajo,id_horario),
	FOREIGN KEY (legajo) REFERENCES Trabajadores(legajo),
	FOREIGN KEY (id_horario) REFERENCES Horarios(id_horario)
)
GO

CREATE TABLE Especialidades (
    id_especialidad INT PRIMARY KEY IDENTITY(100,1),
    especialidad VARCHAR(100) NOT NULL
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
	SELECT P.dni, P.nombre, P.apellido, P.fecha_nac, P.telefono,P.email,Pa.numero_afiliado, Pl.nombre as plan_pac,Pa.fecha_alta,
		   D.id_direccion,D.calle, D.numero,D.localidad,D.codigo_postal, p.id_acceso,Pa.estado
	FROM Pacientes Pa
	INNER JOIN Personas P ON P.dni = Pa.dni
	INNER JOIN Direcciones D ON D.id_direccion = P.id_direccion
	INNER JOIN Planes Pl ON Pa.id_plan = Pl.id_plan
	WHERE P.dni = @DNI
);
GO

--vista para obtener todos los pacientes
CREATE VIEW vw_Lista_Pacientes
AS
SELECT Pa.numero_afiliado,P.dni,P.nombre,P.apellido,P.fecha_nac,P.telefono,
	   P.email, P.id_direccion,D.calle,D.numero,D.localidad,D.codigo_postal,
	   Pa.fecha_alta,Pl.nombre AS plan_pac ,P.id_acceso
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
	@pID_PLAN INT,
	@pID_ACCESO INT
	)AS
BEGIN
	DECLARE @ID_DIRECCION INT
	DECLARE @PASS VARCHAR(4)
	DECLARE @NUM_AFILIADO VARCHAR(100)

	SET @PASS = RIGHT(@pDNI, 4);

	INSERT Direcciones (calle,numero,localidad,codigo_postal)
	VALUES (@pCALLE,@pNUMERO,@pLOCALIDAD,@pCOD_POSTAL)
	
	SELECT @ID_DIRECCION = IDENT_CURRENT('Direcciones')

	INSERT Personas (dni,nombre,apellido,fecha_nac,telefono,email,id_direccion,id_acceso)
	VALUES (@pDNI,@pNOMBRE,@pAPELLIDO,@pFECHA_NAC,@pTELEFONO,@pEMAIL,@ID_DIRECCION,@pID_ACCESO)

	SET @NUM_AFILIADO = dbo.ObtenerNuevoNumeroAfiliado();

	INSERT Pacientes (numero_afiliado,dni,id_plan)
	VALUES (@NUM_AFILIADO,@pDNI,@pID_PLAN)
	
	INSERT Usuarios (Usuario,Pass,id_acceso)
	VALUES (@pDNI,@PASS,@pID_ACCESO)
	
END
GO

-- Creacion de Empleado + direccion asociada + Usuario de la pagina
-- AGREGAR TURNOS
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

	INSERT Personas (dni,nombre,apellido,fecha_nac,telefono,email,id_direccion,id_acceso)
	VALUES (@pDNI,@pNOMBRE,@pAPELLIDO,@pFECHA_NAC,@pTELEFONO,@pEMAIL,@ID_DIRECCION,@pID_ACCESO)

	SET @Legajo = dbo.ObtenerNuevoLegajo();

	INSERT Trabajadores(legajo,dni)
	VALUES (@Legajo,@pDNI)

	INSERT Usuarios (Usuario,Pass,id_acceso)
	VALUES (@pDNI,@PASS,@pID_ACCESO)
END
GO

--BAJA LOGICA TRABAJADOR
CREATE PROCEDURE sp_Baja_Trabajador(
	@pDNI VARCHAR(20)
	)AS
BEGIN
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

EXEC sp_Crear_Paciente '111', 'Juan Carlos','Martinez','1985-03-15','1145678901','juan.martinez85@gmail.com','AV Santa Fe','1234','Buenos Aires','1059',1,1

EXEC sp_Crear_Empleado '222','María Elena','Gomez','1990-07-22','2617891234','maria.gomez90@hotmail.com','Calle 50','789','La Plata','1900',4


INSERT Medico_x_especialidad (legajo,id_especialidad)
VALUES ('7001','4'),('7001','5'),('7001','2')
GO


