DELIMITER $$
CREATE PROCEDURE crearcurso (codigo_in int, nombre_in VARCHAR(50), cr_necesarios_in int, cr_otorgados_in int, obligatorio_in TINYINT(1), id_carrera_in int)
BEGIN
	 DECLARE EXIT HANDLER FOR 3819 
		SELECT CONCAT('OCURRIO UN ERROR AL CREAR CURSO') AS MENSAJE;
        
	IF validarcurso(codigo_in)  THEN
		SELECT 'CURSO YA EXISTE' AS MENSAJE;
    ELSE
        IF validarcarrera(id_carrera_in) THEN
			SELECT 'CURSO REGISTRADO' AS MENSAJE;
            INSERT INTO curso (codigo, nombre, cr_necesarios, cr_otorgados, obligatorio, Carrera_id_carrera)
            VALUES (codigo_in, nombre_in, cr_necesarios_in, cr_otorgados_in, obligatorio_in, id_carrera_in);
		ELSE
			SELECT 'CARRERA NO EXISTE' AS MENSAJE;
			
		END IF;
	END IF;
END$$

-- AREA COMUN
CALL crearcurso(101,'MATE BASICA 1',0,7,1,1);
CALL crearcurso(147,'QUIMICA GENERAL',0,5,1,1);
CALL crearcurso(005,'TECNICAS DE INVESTIGACION',0,7,1,1);
CALL crearcurso(017,'HUMANISTICA 1',0,4,1,1);
CALL crearcurso(069,'TECNICA COMPLEMENTARIA',0,4,1,1);

-- SISTEMAS
CALL crearcurso(770,'INTRO A AL PROGA Y COMPU 1',17,4,1,2);
CALL crearcurso(795,'LOGICA DE SISTEMAS',17,2,1,2);
CALL crearcurso(960,'MATE COMPUTO 1',17,5,1,2);
CALL crearcurso(2025,'PRACTICA INICIAL',33,0,1,2);
CALL crearcurso(796,'LENGUAJES FORMALES',33,3,1,2);
-- CIVL
CALL crearcurso(352,'QUIMICA 2',15,4,1,3);
CALL crearcurso(028,'ECOLOGIA',15,3,1,3);
CALL crearcurso(170,'MECANICA ANALITICA',17,5,1,3);
CALL crearcurso(200,'INGENIERIA ELECTRICA',17,5,1,3);
CALL crearcurso(090,'PROGRAMACION COMPUTADORAS',17,3,1,3);
-- QUMICA
CALL crearcurso(354,'QUIMICA 3',0,5,1,4);
CALL crearcurso(356,'QUIMICA 4',5,5,1,4);
CALL crearcurso(362,'ANALISIS CUALITATIVO 1',10,5,1,4);
CALL crearcurso(364,'ANALISIS CUALITATIVO 2',15,5,1,4);
CALL crearcurso(358,'QUIMICA ORGANICA',20,4,1,4);
-- MECANICA
CALL crearcurso(073,'DIBUJO TECNICO MECANICO',15,3,1,5);
CALL crearcurso(250,'MECANICA DE FLUIDOS',15,5,1,5);
CALL crearcurso(390,'TERMODINAMICA 1',17,5,1,5);
CALL crearcurso(300,'RESISTENCIA DE MATERIALES 1',17,5,1,5);
CALL crearcurso(452,'CIENCIA DE LOS MATERIALES',17,5,1,5);

