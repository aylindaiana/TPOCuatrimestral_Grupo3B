USE MASTER
GO
CREATE DATABASE CLINICA_DB
GO
USE CLINICA_DB
GO



CREATE TABLE Direcciones (
    id_direccion INT PRIMARY KEY IDENTITY(1000,1),
    calle VARCHAR(100),
    numero VARCHAR(10),
    localidad VARCHAR(100),
    codigo_postal VARCHAR(10)
);
GO
CREATE TABLE Niveles_acceso (
    id_acceso INT PRIMARY KEY IDENTITY(1,1),
    nivel_acceso VARCHAR(50)
);
GO

CREATE TABLE Personas (
    dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nac DATE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    id_direccion INT,
    id_acceso INT,
    FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion),
    FOREIGN KEY (id_acceso) REFERENCES Niveles_acceso(id_acceso)
);
GO
CREATE TABLE Pacientes (
    numero_afiliado VARCHAR(20) PRIMARY KEY,
    dni VARCHAR(20),
    estado bit default 1,
    FOREIGN KEY (dni) REFERENCES Personas(dni)
);
GO
CREATE TABLE Trabajadores (
    legajo INT PRIMARY KEY,
    dni VARCHAR(20),
    turno VARCHAR(50),
    estado BIT DEFAULT 1,
    FOREIGN KEY (dni) REFERENCES Personas(dni)
);
GO
CREATE TABLE Especialidades (
    id_especialidad INT PRIMARY KEY IDENTITY(1,1),
    especialidad VARCHAR(100)
);
GO
CREATE TABLE Medico_x_especialidad (
    legajo INT,
    id_especialidad INT,
    PRIMARY KEY (legajo, id_especialidad),
    FOREIGN KEY (legajo) REFERENCES Trabajadores(legajo),
    FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad)
);
GO
CREATE TABLE Planes (
    id_plan INT PRIMARY KEY,
    nombre VARCHAR(100)
);
GO
CREATE TABLE Sanatorios (
    id_sanatorio INT PRIMARY KEY,
    id_direccion INT unique,
    telefono VARCHAR(20),
    email VARCHAR(100),
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
    numero_afiliado VARCHAR(20),
    --id_plan INT, -- MODIFICAR
    id_medico INT,
    especialidad VARCHAR(100),
    fecha_hora DATETIME,
    motivo VARCHAR(255),
    observaciones TEXT,
    estado VARCHAR(50),
    FOREIGN KEY (numero_afiliado) REFERENCES Pacientes(numero_afiliado),
    FOREIGN KEY (id_medico) REFERENCES Trabajadores(legajo)
);
GO

CREATE TABLE Usuarios(
	Usuario VARCHAR(20),
	Pass VARCHAR(50),
	id_acceso INT,
	estado bit default 1

	PRIMARY KEY (Usuario,Pass),
	FOREIGN KEY(Usuario) REFERENCES Personas(dni)
)
GO

CREATE FUNCTION dbo.Obtener_Empleado(@DNI VARCHAR(20))
RETURNS TABLE
RETURN(
	SELECT P.dni, P.nombre, P.apellido, P.fecha_nac, P.telefono,P.email,T.legajo,T.turno,
		   D.id_direccion,D.calle, D.numero,D.localidad,D.codigo_postal, p.id_acceso,T.estado
	FROM Trabajadores T
	INNER JOIN Personas P ON P.dni = T.dni
	INNER JOIN Direcciones D ON D.id_direccion = P.id_direccion
	WHERE P.dni = @DNI
);
GO

CREATE FUNCTION dbo.Obtener_Paciente(@DNI VARCHAR(20))
RETURNS TABLE
RETURN(
	--modificar para que traiga plan
	SELECT P.dni, P.nombre, P.apellido, P.fecha_nac, P.telefono,P.email,Pa.numero_afiliado,
		   D.id_direccion,D.calle, D.numero,D.localidad,D.codigo_postal, p.id_acceso,Pa.estado
	FROM Pacientes Pa
	INNER JOIN Personas P ON P.dni = Pa.dni
	INNER JOIN Direcciones D ON D.id_direccion = P.id_direccion
	WHERE P.dni = @DNI
);
GO

INSERT Niveles_acceso(nivel_acceso)
VALUES ('PACIENTE'),('RECEPCIONISTA'),('MEDICO'),('ADMIN')
GO

INSERT Direcciones (calle,numero,localidad,codigo_postal)
VALUES ('CALLE PRUEBA','1111','PRUEBA','2222')
GO
INSERT Personas (dni,nombre,apellido,fecha_nac,telefono,email,id_direccion,id_acceso)
VALUES ('111','TEST','TEST','1999-01-01','1234567890','TEST@GMAIL.COM',1000,1)
GO
INSERT Personas (dni,nombre,apellido,fecha_nac,telefono,email,id_direccion,id_acceso)
VALUES ('222','TEST2','TEST2','1999-01-02','1234567890','TEST2@GMAIL.COM',1000,4)
GO
INSERT Trabajadores (legajo,dni,turno,estado)
VALUES ('7001','222','TARDE',1)
GO
INSERT Pacientes(numero_afiliado,dni,estado)
VALUES ('1001','111',1)
GO
INSERT Usuarios(Usuario,Pass,id_acceso,estado)
VALUES ('111','PACIENTE',1,1)
GO
INSERT Usuarios(Usuario,Pass,id_acceso,estado)
VALUES ('222','ADMIN',4,1)
GO
