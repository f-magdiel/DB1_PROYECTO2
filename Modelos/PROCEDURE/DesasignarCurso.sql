DELIMITER $$
CREATE PROCEDURE deasignarcurso (id_curso_in int, ciclos_in VARCHAR(50), seccion_in VARCHAR(1),carnet_in BIGINT(9))
BEGIN
	
        
    DECLARE id_curso_buscar INT;
    DECLARE cont int;
    DECLARE cont_asignado int;
	DECLARE EXIT HANDLER FOR 3819 
	SELECT CONCAT('OCURRIO UN ERROR AL DESASIGNAR CURSO') AS MENSAJE;
    
-- Validacion que exista curso
    IF validarcurso(id_curso_in)  THEN
		
        -- validar si está habilidato curso
        SELECT
            COUNT(c.codigo)
        INTO cont
        FROM
            curso c
            INNER JOIN curso_habilitado ch ON c.codigo = ch.Curso_codigo
        WHERE
			ch.ciclos = ciclos_in
            AND YEAR(ch.periodo) = YEAR (CURDATE())
            AND c.codigo = id_curso_in;

        -- validar el habilitar curso
        IF cont > 0 THEN
            IF validarestudiante(carnet_in) THEN
                -- EXITE ESTUDIANTE
                -- validar si esta asignado
                SELECT
                    COUNT(e.carnet)
                INTO cont_asignado
                FROM
					estudiante e
                    INNER JOIN asignacion_curso ac ON e.carnet = ac.Estudiante_carnet
                    INNER JOIN curso_habilitado ch ON ac.Curso_Habilitado_id_curso_habilitado = ch.id_curso_habilitado
                    INNER JOIN curso            c ON ch.Curso_codigo = c.codigo
                WHERE
					e.carnet = carnet_in
                    AND ac.estado_asignacion = 1
                    AND ch.seccion = seccion_in
                    AND c.codigo = id_curso_in
                    AND ch.ciclos = ciclos_in
                    AND YEAR (ch.periodo) =YEAR (CURDATE());

                IF cont_asignado > 0 THEN
                    -- SE DESASIGNA ESTUDIANTE
                    -- SE BUSCA EL CURSO EN TABLA CURSO HABILITADO
                    SELECT id_curso_habilitado
                    INTO id_curso_buscar
                    FROM curso_habilitado ch
                    WHERE 
                    ch.Curso_codigo = id_curso_in
                    AND ch.seccion = seccion_in
                    AND ch.ciclos = ciclos_in
                    AND YEAR(ch.periodo) = YEAR(CURDATE());

                    -- SE HACE EL UPDATE
                    UPDATE asignacion_curso ac
                    SET ac.estado_asignacion = 0
                    WHERE ac.Estudiante_carnet = carnet_in;

                    SELECT 'SE DESASGINO EL ESTUDIANTE EXITOSAMENTE' AS MENSAJE;

                ELSE
                    SELECT 'EL ESTUDIANTE YA SE ENCUETRA DESASIGNADO' AS MENSAJE;
                END IF;
            ELSE
                SELECT 'EL ESTUDIANTE NO EXISTE' AS MENSAJE;
            END IF;
        ELSE
            SELECT 'CURSO NO ESTÁ HABILITADO' AS MENSAJE;
        END IF;

    ELSE
		SELECT 'EL CURSO NO EXISTE' AS MENSAJE;
			
	END IF;


END$$

CALL deasignarcurso(14, '1S','A',201801441);

