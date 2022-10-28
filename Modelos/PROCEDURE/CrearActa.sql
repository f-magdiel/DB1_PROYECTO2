DELIMITER $$
CREATE PROCEDURE crearacta ( codigo_cur_in int, ciclo_in VARCHAR(50), seccion_in VARCHAR(1))
BEGIN
    DECLARE cont int;
    DECLARE cont_habili int;
    DECLARE cont_asig int;
    DECLARE id_habili int;
    DECLARE cont_stu int;

	IF validarcurso(codigo_cur_in) > 0 THEN
        SELECT COUNT(ch.id_curso_habilitado)
        INTO cont
        FROM curso_habilitado ch
        WHERE ch.ciclos = ciclo_in
        AND ch.Curso_codigo = codigo_cur_in
        AND YEAR(ch.periodo) = YEAR(CURDATE());

        IF cont > 0 THEN
            SELECT COUNT(ch.id_curso_habilitado)
            INTO cont_habili
            FROM curso_habilitado ch
            WHERE ch.Curso_codigo = codigo_cur_in
            AND ch.seccion = seccion_in
            AND ch.ciclos = ciclo_in
            AND YEAR(ch.periodo) = YEAR(CURDATE());

            -- obtener id asignacion 
            SELECT ch.id_curso_habilitado
            INTO id_habili
            FROM curso_habilitado ch
            WHERE ch.Curso_codigo = codigo_cur_in
            AND ch.seccion = seccion_in
            AND ch.ciclos = ciclo_in
            AND YEAR(ch.periodo) = YEAR(CURDATE());

            SELECT COUNT(ac.Estudiante_carnet)
            INTO cont_asig
            FROM asignacion_curso ac
            WHERE ac.Curso_Habilitado_id_curso_habilitado = id_habili
            AND ac.estado_asignacion = 1;
			SELECT 'CONT ASIG',cont_asig,'' AS MENSAJE;
            -- cantidad de estudiante
            SELECT COUNT(nota_estudiante.id_nota)
            INTO cont_stu
            FROM nota_estudiante
            WHERE nota_estudiante.Curso_Habilitado_id_curso_habilitado = id_habili;
			SELECT 'CONT STU',cont_stu,'' AS MENSAJE;
            -- validar si se puede crear acta
            IF cont_asig = cont_stu THEN
                -- se genera acta
                INSERT INTO acta(fecha_acta, Curso_Habilitado_id_curso_habilitado)
                VALUES (CURDATE(), id_habili);
                SELECT 'ACTA GENERADO EXITOSAMENTE' AS MENSAJE;
            ELSE
                SELECT 'NOTAS INCOMPLETAS PARA GENERAR ACTA' AS MENSAJE;
            END IF;

        ELSE
            SELECT 'CURSO NO HABILITADO' AS MENSAJE;
        END IF;
    ELSE
        SELECT 'EL CURSO NO EXISTE' AS MENSAJE;
    END IF;

END$$

CALL crearacta(14,'1S','A');