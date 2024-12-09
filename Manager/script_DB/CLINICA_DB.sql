USE MASTER
GO
CREATE DATABASE CLINICA_DB
GO
USE CLINICA_DB
GO

-- Configurar el idioma para la sesiÃ³n actual
SET LANGUAGE Spanish;
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
    especialidad VARCHAR(100) NOT NULL,
	estado BIT DEFAULT 1
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
    CONSTRAINT CHK_Dia CHECK (dia IN ('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 's?bado', 'domingo'))
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

CREATE TABLE Turnos(
    id_turno INT PRIMARY KEY IDENTITY(1000,1),
	id_sanatorio int default null,
	legajo VARCHAR(100),
	num_afiliado varchar(100) default null,
	dia varchar(20) not null,
	id_especialidad INT not null,
	Fecha DATE NOT NULL,
	hora TIME NOT NULL,
	estado VARCHAR(20) DEFAULT 'sin asignar',
	motivo VARCHAR(255) default null,
    observaciones TEXT default null,

	CONSTRAINT CHK_Estado CHECK (estado IN ('sin asignar', 'pendiente', 'cancelado','realizado'))
);
GO

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
CREATE PROCEDURE sp_Actualizar_Persona(
    @dni VARCHAR(20),    
    @nombre VARCHAR(100), 
    @apellido VARCHAR(100),  
    @fecha_nac DATE,         
    @telefono VARCHAR(20), 
    @email VARCHAR(100),      
    @id_direccion INT,
    @calle VARCHAR(100),       
    @numero VARCHAR(10),     
    @localidad VARCHAR(100),   
    @codigo_postal VARCHAR(10),
    @id_plan INT
)
AS
BEGIN
    BEGIN TRANSACTION; 
    BEGIN TRY
        UPDATE Direcciones
        SET 
            calle = @calle,
            numero = @numero,
            localidad = @localidad,
            codigo_postal = @codigo_postal
        WHERE id_direccion = @id_direccion;

        UPDATE Personas
        SET 
            nombre = @nombre,
            apellido = @apellido,
            fecha_nac = @fecha_nac,
            telefono = @telefono,
            email = @email,
            id_direccion = @id_direccion 
        WHERE dni = @dni;

        UPDATE Pacientes
        SET id_plan = @id_plan
        WHERE dni = @dni;

        UPDATE Usuarios
        SET id_acceso = '1' 
        WHERE Usuario = @dni;

        COMMIT TRANSACTION; 
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

--PARA EDITAR TURNO
CREATE PROCEDURE sp_Modificar_Turno(
    @ID_TURNO INT,               
    @LEGAJO NVARCHAR(100),       
    @NUM_AFILIADO VARCHAR(100),   
    @DIA VARCHAR(20),             
    @ID_ESPECIALIDAD INT,        
    @FECHA DATE,                  
    @HORA TIME,                   
    @ESTADO VARCHAR(20),          
    @MOTIVO VARCHAR(255),         
    @OBSERVACIONES TEXT        
	)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Turnos WHERE id_turno = @ID_TURNO AND estado IN ('sin asignar', 'pendiente'))
        BEGIN
            UPDATE Turnos
            SET
                legajo = @LEGAJO,                  
                num_afiliado = @NUM_AFILIADO,      
                dia = @DIA,                        
                id_especialidad = @ID_ESPECIALIDAD, 
                Fecha = @FECHA,                    
                hora = @HORA,                     
                estado = @ESTADO,                
                motivo = @MOTIVO,                  
                observaciones = @OBSERVACIONES     
            WHERE id_turno = @ID_TURNO;
        END
        ELSE
        BEGIN
            RAISERROR('No se puede modificar un turno con el estado actual.', 16, 1);
            RETURN;
        END
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
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


-- CAMBIAR CONTRASEï¿½A
CREATE PROCEDURE sp_Cambiar_Contrasena(
    @Usuario VARCHAR(50),
    @NuevaContrasena VARCHAR(50)
)
AS
BEGIN
    -- Actualizar la contraseï¿½a del usuario
    UPDATE Usuarios
    SET Pass = @NuevaContrasena
    WHERE Usuario = @Usuario;
END;
GO


--  AGREGAR UNA ESPECIALIDAD NUEVA
CREATE PROCEDURE sp_crear_especialidad
    @pNOMBRE_ESPECIALIDAD VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
		BEGIN TRANSACTION;
        IF EXISTS (
            SELECT 1
            FROM Especialidades
            WHERE especialidad = @pNOMBRE_ESPECIALIDAD
        )
        BEGIN
            RAISERROR ('La especialidad ya existe ', 16, 1)
            RETURN;
        END
        INSERT INTO Especialidades (especialidad)
        VALUES (@pNOMBRE_ESPECIALIDAD)
        PRINT 'Especialidad creada exitosamente'
		COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
		ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorLine INT = ERROR_LINE();

        RAISERROR (
            'Error al intentar crear una especialidad. Error %d en la lÃ­nea %d: %s', 
            16, 1, @ErrorNumber, @ErrorLine, @ErrorMessage
        )
    END CATCH
END
GO

--EXEC sp_crear_especialidad Clinica


-- REALIZO LA RELACION DE LA ESPECIALIDAD CON EL MEDICO - FUNCIÃ“N DE ADMIN O RECEPCIONISTA
CREATE PROCEDURE sp_asignar_especialidad_Medico(
    @pLEG_MEDICO VARCHAR(100),
    @pID_ESPECIALIDAD INT
	)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF NOT EXISTS (
            SELECT 1
            FROM Especialidades
            WHERE id_especialidad = @pID_ESPECIALIDAD
        )
        BEGIN
            RAISERROR ('La especialidad especificada no existe', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END
        IF EXISTS (
            SELECT 1
            FROM Medico_x_especialidad
            WHERE legajo = @pLEG_MEDICO
              AND id_especialidad = @pID_ESPECIALIDAD
        )
        BEGIN
            RAISERROR ('Ya existe una relaciÃ³n entre el mÃ©dico y esta especialidad', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END
        INSERT INTO Medico_x_especialidad (legajo, id_especialidad)
        VALUES (@pLEG_MEDICO, @pID_ESPECIALIDAD)
        COMMIT TRANSACTION
        PRINT 'RelaciÃ³n mÃ©dico-especialidad creada exitosamente.'
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorLine INT = ERROR_LINE();
        RAISERROR (
            'Error al intentar asignar una especialidad al mÃ©dico. Error %d en la lÃ­nea %d: %s', 
            16, 1, @ErrorNumber, @ErrorLine, @ErrorMessage
        );
    END CATCH
END
GO


CREATE PROCEDURE sp_baja_alta_especialidad(
    @pID_ESPECIALIDAD INT,       
    @pESTADO BIT  
	)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Especialidades
        SET estado = @pESTADO
        WHERE id_especialidad = @pID_ESPECIALIDAD

        IF @pESTADO = 1
        BEGIN
            UPDATE Horarios_Trabajador
            SET id_especialidad = @pID_ESPECIALIDAD
            WHERE id_especialidad IS NULL;

            INSERT INTO Medico_x_especialidad (legajo, id_especialidad)
            SELECT legajo, @pID_ESPECIALIDAD
            FROM (SELECT DISTINCT legajo FROM Horarios_Trabajador WHERE id_especialidad = @pID_ESPECIALIDAD) AS MedicosRelacionados
            WHERE NOT EXISTS (
                SELECT 1 FROM Medico_x_especialidad WHERE legajo = MedicosRelacionados.legajo AND id_especialidad = @pID_ESPECIALIDAD
            );

            UPDATE Turnos
            SET estado = 'pendiente', motivo = NULL
            WHERE id_especialidad = @pID_ESPECIALIDAD AND estado = 'cancelado';
        END

        IF @pESTADO = 0
        BEGIN
            UPDATE Horarios_Trabajador
            SET id_especialidad = NULL
            WHERE id_especialidad = @pID_ESPECIALIDAD

            DELETE FROM Medico_x_especialidad
            WHERE id_especialidad = @pID_ESPECIALIDAD

            UPDATE Turnos
            SET estado = 'cancelado', motivo = 'Especialidad dada de baja'
            WHERE id_especialidad = @pID_ESPECIALIDAD
        END
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END
GO
--EXEC sp_baja_alta_especialidad 101, 1
--SELECT * FROM Especialidades WHERE id_especialidad =101

CREATE PROCEDURE GenerarHorariosDisponibles(
    @legajo VARCHAR(100)
	)AS
BEGIN
    SET NOCOUNT ON;

    -- Variables para los datos del horario del trabajador
    DECLARE @fecha_inicio DATE = CAST(GETDATE() AS DATE);
    DECLARE @fecha_fin DATE = DATEADD(MONTH, 2, @fecha_inicio);

    DECLARE @dia VARCHAR(20);
    DECLARE @id_especialidad INT;
    DECLARE @hora_inicio TIME;
    DECLARE @hora_fin TIME;

    -- Cursor para recorrer los horarios del trabajador
    DECLARE horarios_cursor CURSOR FOR
    SELECT dia, id_especialidad, hora_inicio, hora_fin
    FROM Horarios_Trabajador
    WHERE legajo = @legajo;

    OPEN horarios_cursor;
    FETCH NEXT FROM horarios_cursor INTO @dia, @id_especialidad, @hora_inicio, @hora_fin;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Generar turnos para el rango de fechas
        DECLARE @fecha_actual DATE = @fecha_inicio;

        WHILE @fecha_actual <= @fecha_fin
        BEGIN
            -- Verificar si la fecha actual corresponde al dÃ­a de la semana
            IF UPPER(DATENAME(WEEKDAY, @fecha_actual)) = UPPER(@dia)
            BEGIN
                -- Generar turnos por cada hora en el rango de horario
                DECLARE @hora_actual TIME = @hora_inicio;

                WHILE @hora_actual < @hora_fin
                BEGIN
                    -- Verificar si el turno ya existe antes de insertarlo
                    IF NOT EXISTS (
                        SELECT 1
                        FROM Turnos
                        WHERE legajo = @legajo
                          AND id_especialidad = @id_especialidad
                          AND Fecha = @fecha_actual
                          AND hora = @hora_actual
                    )
                    BEGIN
                        INSERT INTO Turnos(legajo,dia, id_especialidad, Fecha, hora, estado)
                        VALUES (@legajo,@dia, @id_especialidad,  @fecha_actual, @hora_actual, 'sin asignar');
                    END
                    -- Incrementar la hora actual en 1 hora
                    SET @hora_actual = DATEADD(HOUR, 1, @hora_actual);
                END
            END
            -- Avanzar al dÃ­a siguiente
            SET @fecha_actual = DATEADD(DAY, 1, @fecha_actual);
        END
        FETCH NEXT FROM horarios_cursor INTO @dia, @id_especialidad, @hora_inicio, @hora_fin;
    END
    CLOSE horarios_cursor;
    DEALLOCATE horarios_cursor;
END;
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

		EXEC GenerarHorariosDisponibles @pLEGAJO 
	END
END
GO

--Traer el turno 
CREATE PROCEDURE ObtenerTurnoPorID
    @id_turno INT
AS
BEGIN
    SELECT 
        t.id_turno,
        t.id_sanatorio,
        t.legajo,
        t.num_afiliado,
        t.dia,
        t.id_especialidad,
        t.Fecha,
        t.hora,
        t.estado,
        t.motivo,
        t.observaciones,
        e.especialidad,
        p.nombre + ' ' + p.apellido AS medico_nombre,
        s.nombre AS sanatorio_nombre
    FROM Turnos t
    INNER JOIN Trabajadores tr ON t.legajo = tr.legajo
    INNER JOIN Especialidades e ON t.id_especialidad = e.id_especialidad
    INNER JOIN Personas p ON tr.dni = p.dni
    LEFT JOIN Sanatorios s ON t.id_sanatorio = s.id_sanatorio
    WHERE t.id_turno = @id_turno;
END
GO
--EXEC ObtenerTurnoPorID @id_turno = 1000;

CREATE PROCEDURE sp_buscar_gmail(
	@pUSUARIO VARCHAR(50)
)
AS
BEGIN
	BEGIN TRY
		SELECT p.Email 
		FROM Personas p 
		INNER JOIN Usuarios u 
		ON p.Dni = u.Usuario 
		WHERE u.Usuario = @pUSUARIO;
	END TRY
	BEGIN CATCH
		RAISERROR('SE PRODUJO ESTE USUARIO NO EXISTE.', 16, 10)
	END CATCH
END
GO



CREATE FUNCTION obtenerFechasDisponibles(@LEGAJO VARCHAR(100), @DIA VARCHAR(100))
RETURNS TABLE
RETURN(
	SELECT DISTINCT Fecha FROM Turnos 
	WHERE legajo = @LEGAJO AND 
		  UPPER(dia) = UPPER(@DIA) AND
		  estado = 'sin asignar' AND
		  Fecha > GETDATE()
);
GO

-- Obtener horarios para la fecha seleccionada
CREATE FUNCTION obtenerHorariosDisponibles(@FECHA DATE,@LEGAJO VARCHAR(100))
RETURNS TABLE
RETURN(
	SELECT legajo,id_turno,hora FROM Turnos
	WHERE Fecha = @FECHA AND estado = 'sin asignar' AND legajo = @LEGAJO
);
GO
--SELECT * FROM obtenerHorariosDisponibles('2024-12-09', 'E7002');
--SELECT * FROM Turnos WHERE estado = 'sin asignar' AND Fecha = '2024-12-09' AND legajo = 'E7002';

--aSIGNACION DE TURNO AL PACIENTE

CREATE PROCEDURE asignarTurno(
    @pID_TURNO INT,
    @pNUM_AFIL VARCHAR(100),
    @pMOTIVO VARCHAR(255),
    @pID_SANATORIO INT
)
AS
BEGIN
    -- Verificar si el turno ya está ocupado
    IF EXISTS (
        SELECT 1 
        FROM Turnos 
        WHERE id_turno = @pID_TURNO AND num_afiliado IS NOT NULL
    )
    BEGIN
        RAISERROR('El turno ya está ocupado.', 16, 1);
        RETURN;
    END

    -- Asignar el turno si está disponible
    UPDATE Turnos 
    SET 
        num_afiliado = @pNUM_AFIL, 
        motivo = @pMOTIVO, 
        id_sanatorio = @pID_SANATORIO
    WHERE id_turno = @pID_TURNO;
END
GO


-- MEDICO ACTUALIZA ESTADO DEL TURNO
CREATE PROCEDURE actualizarTurno(
	@pID_TURNO INT,
	@pOBS TEXT,
	@pESTADO VARCHAR(100)
	)AS
BEGIN
	UPDATE	Turnos SET estado = @pESTADO, observaciones = @pOBS
	WHERE id_turno = @pID_TURNO
END
GO
--select* from Turnos
--USE CLINICA_DB
CREATE VIEW vwTodosTurnos
AS
SELECT Tu.id_turno,Tu.num_afiliado,p.apellido,Tu.id_especialidad,E.especialidad,Tu.Fecha,Tu.hora,tu.estado FROM Turnos Tu
INNER JOIN Trabajadores T ON Tu.legajo = T.legajo
INNER JOIN Personas P ON T.dni = P.dni
INNER JOIN Especialidades E ON Tu.id_especialidad = E.id_especialidad
GO

--SELECT id_turno,num_afiliado,apellido,id_especialidad,especialidad,Fecha,hora,estado FROM vwTodosTurnos
--SELECT*FROM vwTodosTurnos
--use CLINICA_DB
-- Modificar persona
CREATE PROCEDURE sp_Modificar_Persona (
    @dni VARCHAR(20),    
    @nombre VARCHAR(100), 
    @apellido VARCHAR(100),  
    @fecha_nac DATE,         
    @telefono VARCHAR(20), 
    @email VARCHAR(100),      
    @calle VARCHAR(100),       
    @numero VARCHAR(10),     
    @localidad VARCHAR(100),   
    @codigo_postal VARCHAR(10) 
)
AS
BEGIN
    DECLARE @id_direccion INT;
    BEGIN TRANSACTION;

    BEGIN TRY
        SELECT @id_direccion = id_direccion 
        FROM Personas 
        WHERE dni = @dni;

        IF @id_direccion IS NULL
        BEGIN
            RAISERROR('No se encontró la dirección para la persona con dni: %s', 16, 1, @dni);
            ROLLBACK TRANSACTION
            RETURN;
        END
        UPDATE Personas
        SET 
            nombre = @nombre,
            apellido = @apellido,
            fecha_nac = @fecha_nac,
            telefono = @telefono,
            email = @email
        WHERE dni = @dni;

        UPDATE Direcciones
        SET 
            calle = @calle,
            numero = @numero,
            localidad = @localidad,
            codigo_postal = @codigo_postal
        WHERE id_direccion = @id_direccion;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
--EXEC sp_Actualizar_Persona @dni, @nombre, @apellido, @fecha_nac, @telefono, @email, @email, @calle, @numero, @localidad, @codigo_postal

--------------------------------------------------------- INSERT DATOS ----------------------------------


INSERT Niveles_acceso(nivel_acceso)
VALUES ('PACIENTE'),('RECEPCIONISTA'),('MEDICO'),('ADMIN')
GO

INSERT Especialidades (especialidad)
VALUES 
('Clinica'),('Pediatria'),('Dermatologia'),('Cardiologia'),
('Oncologia'),('Neumologia')
GO

--SELECT * FROM Usuarios
INSERT Planes (nombre)
VALUES ('STANDARD'),('BRONCE'),('PLATINUM'),('GOLD')

EXEC sp_Crear_Paciente '11111111', 'Juan Carlos','Martinez','1985-03-15','1145678901','juan.martinez85@gmail.com','AV Santa Fe','1234','Buenos Aires','1059',1
EXEC sp_Crear_Paciente '66666666', 'Aylin Daiana','Paniagua','1985-03-15','1145678901','dai83r2@gmail.com','AV Santa Fe','1234','Buenos Aires','1059',1

--Creo Recepcionista
EXEC sp_Crear_Empleado '22222222','Marï¿½a Elena','Gomez','1990-07-22','2617891234','maria.gomez90@hotmail.com','Calle 50','789','La Plata','1900',2

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

SELECT * FROM Usuarios
SELECT * FROM Trabajadores
SELECT * FROM Personas
SELECT * FROM Pacientes
SELECT* FROM Sanatorios
SELECT* FROM Planes
SELECT * FROM Turnos
select* from Sanatorios_x_planes
