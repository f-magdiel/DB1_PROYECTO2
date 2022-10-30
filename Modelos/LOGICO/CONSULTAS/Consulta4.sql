DELIMITER $$
CREATE PROCEDURE consulta4 (codigo_in int, ciclos_in VARCHAR(50), year_in int ,seccion_in VARCHAR(1))
BEGIN
    DECLARE cont_habili int;

    IF validarcurso(codigo_in) > 0 THEN

        SELECT COUNT(ch.id_curso_habilitado)
        INTO cont_habili
        FROM curso_habilitado ch
        WHERE ch.Curso_codigo = codigo_in
        AND ch.ciclos = ciclos_in
        AND YEAR(ch.periodo) = year_in
        AND ch.seccion = UPPER(seccion_in);

        IF cont_habili > 0 THEN
            -- Realizar consulsta entera
            SELECT es.carnet, CONCAT(es.nombres,' ',es.apellidos) as 'nombre completo',
            es.creditos
            FROM estudiante es
            INNER JOIN asignacion_curso ac
            ON es.carnet = ac.Estudiante_carnet
            INNER JOIN curso_habilitado ch
            ON ac.Curso_Habilitado_id_curso_habilitado = ch.id_curso_habilitado
            WHERE ac.estado_asignacion = 1
            AND ch.ciclos = ciclos_in
            AND ch.seccion = UPPER(seccion_in)
            AND YEAR(ch.periodo) = year_in
            AND ch.Curso_codigo = codigo_in;

        ELSE
            SELECT 'SECCION Y AÑO NO SE ENCUENTRAN' AS MENSAJE;
        END IF;
    ELSE
        SELECT 'CURSO NO EXISTE' AS MENSAJE;
    END IF;
END$$
-- PARA: ID CURSO, CICLOS, AÑO, SECCION
CALL consulta4(14, '1S', 2022, 'A');
