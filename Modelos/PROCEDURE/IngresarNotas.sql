DELIMITER $$
CREATE PROCEDURE ingresarnotas (codigo_curso_in int, ciclos_in VARCHAR(50), seccion_in VARCHAR(1), carnet_in BIGINT(13), nota_in int)
BEGIN
	 
        
    DECLARE cont_es int;
    DECLARE id_habili int;
    DECLARE cr_oto int;
    DECLARE EXIT HANDLER FOR 3819 
		SELECT CONCAT('OCURRIO UN ERROR AL INGRESAR NOTAS') AS MENSAJE;

    IF validarcurso(codigo_curso_in)THEN
        IF validarestudiante(carnet_in)  THEN
            SELECT COUNT(ac.Estudiante_carnet)
            INTO cont_es
            FROM asignacion_curso ac
            INNER JOIN curso_Habilitado ch ON ac.Curso_Habilitado_id_curso_habilitado = ch.id_curso_habilitado 
            WHERE 
            ac.Estudiante_carnet = carnet_in
            AND ac.estado_asignacion = 1
            AND ch.Curso_codigo = codigo_curso_in
            AND ch.ciclos = ciclos_in
            AND ch.seccion = seccion_in
            AND YEAR(ch.periodo) = YEAR(CURDATE());

            -- validar que si este asignado estudiante
            IF cont_es > 0 THEN
                -- para obtener el id del curso
                SELECT ch.id_curso_habilitado
                INTO id_habili
                FROM curso_habilitado ch
                WHERE ch.Curso_codigo = codigo_curso_in
                AND ch.seccion = seccion_in
                AND ch.ciclos = ciclos_in
                AND YEAR(ch.periodo) = YEAR(CURDATE());

                -- se inserta la nota 
                INSERT INTO nota_estudiante (nota, Estudiante_carnet, Curso_Habilitado_id_curso_habilitado)
                VALUES (nota_in, carnet_in, id_habili); 

                SELECT 'NOTA INGRESADA EXITOSAMENTE' AS MENSAJE;

                -- validar NOTA Y AGREGAR CREDITOS
                IF nota_in >= 61 THEN
                    SELECT c.cr_otorgados 
                    INTO cr_oto
                    FROM curso c
                    WHERE c.codigo = codigo_curso_in;

                    -- se realiza un UPDATE
                    UPDATE estudiante 
                    SET estudiante.creditos = estudiante.creditos + cr_oto
                    WHERE estudiante.carnet = carnet_in;

                ELSE
                    SELECT 'CREDITOS NO FUERON OTORGADOS POR NOTA < 61' AS MENSAJE;
                END IF;


            ELSE
                SELECT 'ESTUDIANTE NO ESTA ASIGNADO' AS MENSAJE;
            END IF;

        ELSE
            SELECT 'EL ESTUDIANTE NO EXISTE' AS MENSAJE;
        END IF;
    ELSE
        SELECT 'EL CURSO NO EXISTE' AS MENSAJE;
    END IF;

END$$

CALL ingresarnotas(14, '1S','A',201801442, 70);
