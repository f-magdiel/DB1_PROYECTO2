DELIMITER $$
CREATE PROCEDURE asignarcurso (id_curso_in int, ciclos_in VARCHAR(50), seccion_in VARCHAR(1),carnet_in BIGINT(9))
BEGIN
	 
    -- PARA EXEPTION
    
    DECLARE cont int;
    DECLARE cont_asignado int;
    DECLARE v_crs_est int;
    DECLARE v_crs_req int;
    DECLARE carrera_estu int;
    DECLARE carrera_curs int;
    DECLARE cont_s int;
    DECLARE cupo_d int;
    DECLARE asignados_d int;
    DECLARE curso_h int;
    DECLARE carnet_buscar BIGINT(13);
    DECLARE v_contar int;
    DECLARE id_habili int;
    DECLARE EXIT HANDLER FOR 3819 
			SELECT CONCAT('OCURRIO UN ERROR AL ASIGNAR CURSO') AS MENSAJE;

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
            -- validar que si existe el estudiante
            IF validarestudiante(carnet_in) THEN
                -- EXITE ESTUDIANTE

            -- validar creditos
                SELECT creditos
                INTO v_crs_est
                FROM
                estudiante e
                WHERE
                e.carnet = carnet_in;

                SELECT cr_necesarios
                INTO v_crs_req
                FROM
                curso c
                WHERE
                c.codigo = id_curso_in;

                IF v_crs_est >= v_crs_req THEN
                    -- ESTUDIANTE POSEE CREDITOS 
                    --  VALIDAR compatible
                    SELECT e.Carrera_id_carrera
                    INTO carrera_estu
                    FROM estudiante e
                    WHERE e.carnet = carnet_in;

                    SELECT c.Carrera_id_carrera
                    INTO carrera_curs
                    FROM curso c
                    WHERE c.codigo = id_curso_in;
                    
                    IF carrera_curs IN (1, carrera_estu) THEN
                        -- CURSO Y  CARRERA SI FUNCA
                        -- VALIDAR QUE SI EXISTA CURSO
                        SELECT COUNT(c.codigo)
                        INTO cont_s
                        FROM
                        curso c
                        INNER JOIN curso_habilitado ch
                        ON c.codigo = ch.Curso_codigo
                        WHERE c.codigo = id_curso_in AND
                        ch.seccion = seccion_in AND
                        ch.ciclos = ciclos_in AND
                        YEAR (ch.periodo) = YEAR(CURDATE());

                        IF cont_s > 0 THEN
                            -- SI EXISTE CURSO
                            -- Obtener curso habilitado
                            SELECT id_curso_habilitado
                            INTO curso_h
                            FROM curso_habilitado ch
                            WHERE ch.Curso_codigo = id_curso_in
                            AND ch.seccion = seccion_in
                            AND ch.ciclos = ciclos_in
                            AND YEAR(ch.periodo) = YEAR(CURDATE());
                            
                            -- validar que si asignaciones en las tablas
                            SELECT COUNT(ac.Estudiante_carnet)
                            INTO carnet_buscar
                            FROM asignacion_curso ac
                            INNER JOIN curso_habilitado ch ON ac.Curso_Habilitado_id_curso_habilitado = ch.id_curso_habilitado
                            WHERE
                            ac.Estudiante_carnet = carnet_in
                            AND ch.seccion = seccion_in
                            AND ch.ciclos = ciclos_in
                            AND ch.Curso_codigo = id_curso_in
                            AND YEAR(ch.periodo) = YEAR(CURDATE());

                            IF carnet_buscar = 0 THEN
                                    -- VALIDAR CUPO Y ASIGNACION
                                SELECT cupo, asignados
                                INTO cupo_d,asignados_d
                                FROM curso_habilitado ch
                                WHERE ch.Curso_codigo = id_curso_in AND
                                ch.ciclos = ciclos_in AND
                                ch.seccion = seccion_in AND
                                YEAR(ch.periodo) = YEAR(CURDATE()) ;

                                IF asignados_d < cupo_d THEN
                                    -- CUPO DISPONIBLE
                                    -- REALIZAR INSERT
                                    
                                    INSERT INTO asignacion_curso (estado_asignacion, Estudiante_carnet, Curso_Habilitado_id_curso_habilitado)
                                    VALUES (1, carnet_in, curso_h);

                                    UPDATE curso_habilitado ch 
                                    SET ch.asignados = ch.asignados + 1 
                                    WHERE ch.Curso_codigo = id_curso_in;
                                    SELECT 'CURSO ASIGNADO EXITOSAMENTE' AS MENSAJE;

                                ELSE
                                    SELECT 'CUPO NO DISPONIBLE EN SECCION ',seccion_in,'.' AS MENSAJE;
                                END IF;
                                
                            ELSE
                                
                                    -- SE VUELVE A ASIGNAR
                                SELECT ac.estado_asignacion
                                INTO  v_contar
                                FROM asignacion_curso ac
                                INNER JOIN curso_habilitado ch ON ac.Curso_Habilitado_id_curso_habilitado = ch.id_curso_habilitado
                                WHERE
                                ac.Estudiante_carnet = carnet_in
                                AND ch.Curso_codigo = id_curso_in
                                AND ch.seccion = seccion_in
                                AND ch.ciclos = ciclos_in
                                AND YEAR(ch.periodo) = YEAR(CURDATE());

                                IF v_contar = 0 THEN

                                    -- obtner id habilitado
                                    SELECT id_curso_habilitado
                                    INTO id_habili
                                    FROM curso_habilitado
                                    WHERE curso_habilitado.Curso_codigo = id_curso_in;

                                    UPDATE asignacion_curso ac
                                    SET estado_asignacion = 1
                                    WHERE 
                                    ac.Estudiante_carnet = carnet_in
                                    AND ac.Curso_Habilitado_id_curso_habilitado = id_habili;
                                    SELECT 'SE VOLVIO A ASIGNAR EL ESTUDIANTE' AS MENSAJE;
                                ELSE
                                    SELECT 'ESTUDIANTE YA ESTÁ ASIGNADO' AS MENSAJE;
                                END IF;

                            END IF;
                            

                        ELSE
                            SELECT 'SECCION NO EXISTE ' AS MENSAJE;
                        END IF;

                    ELSE
                        SELECT 'CARRERA Y CURSO  ES INCOMPATIBLE' AS MENSAJE;
                    END IF;

                ELSE
                    SELECT 'ESTUDIANTE NO POSEE CREDITOS SUFICIENTES' AS MENSAJE;
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

CALL  asignarcurso(14, '1S','A',201801442);



