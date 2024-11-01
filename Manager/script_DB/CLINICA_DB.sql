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

DECLARE @Usuario varchar(20) = '42832435'
DECLARE @Pass varchar(50) = '123456'

SELECT Usuario,Pass,id_acceso,estado FROM Usuarios WHERE Usuario = @Usuario AND Pass = @Pass

