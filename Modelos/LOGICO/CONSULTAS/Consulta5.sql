DELIMITER $$
CREATE PROCEDURE consulta5 (codigo_in int, ciclos_in VARCHAR(50), year_in int ,seccion_in VARCHAR(1))
BEGIN
    IF validarcurso(codigo_in) THEN
        -- CONSULTA LISTA
        SELECT ch.Curso_codigo, es.carnet, CONCAT(es.nombres,' ',es.apellidos) as 'nombre completo', 
        CASE 
        WHEN nes.nota >= 62 THEN 'APROBADO'
        ELSE 'REPROBADO'
        END AS 'estado'
        FROM estudiante es
        INNER JOIN nota_estudiante nes 
        ON es.carnet = nes.Estudiante_carnet
        INNER JOIN curso_habilitado ch
        ON nes.Curso_Habilitado_id_curso_habilitado = ch.id_curso_habilitado
        WHERE ch.ciclos = ciclos_in
        AND ch.seccion = UPPER(seccion_in)
        AND ch.Curso_codigo = codigo_in
        AND YEAR(ch.periodo) = year_in;

    ELSE
        SELECT 'CURSO NO EXISTE' AS MENSAJE;
    END IF;    
END$$
-- PARAM: CODIGO CURSO, CICLO, AÑO, SECCION
CALL consulta5(14, '1S',2022,'A');

