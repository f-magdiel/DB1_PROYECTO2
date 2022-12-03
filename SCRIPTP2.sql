-- ########################### INGRESAR CARRERA ###########################
CALL crearcarrera('Sistem@s'); -- nombre inválido
CALL crearcarrera('Sistemas Calificación'); -- ok
CALL crearcarrera('Sistemas Calificación'); -- error duplicado
 
 
-- ########################### CREAR ESTUDIANTE ###########################
CALL registroestudiante(202004765,3024021520101, 'Javier!', 'Gutierrez?', '2001-03-14', 'javier@gmail.com', 42543549, '29 avenida',  1); -- nombre inválido
CALL registroestudiante(202004765, 3024021520101,'Javier', 'Gutierrez', '2001-03-14', 'javiergmail.com', 42543549, '29 avenida',  1); -- correo inválido
CALL registroestudiante(201409335,  53620010101,'Fabian', 'Reyna', '2001-6-13', 'Fabian@gmail.com', 9502001, '7 avenida', 99); -- no existe carrera
CALL registroestudiante(201409335,  53620010101,'Fabian', 'Reyna', '2001-6-13', 'Fabian@gmail.com', 9502001, '7 avenida', -5); -- número inválido / no existe carrera
CALL registroestudiante(201506554, 45119960101,'Angel', 'Marroquin', '1996-1-6', 'Angel@gmail.com', 6401996, '19 avenida',  2); -- ok
CALL registroestudiante(201506554, 45119960101, 'Angel', 'Marroquin', '1996-1-6', 'Angel@gmail.com', 6401996, '19 avenida', 1); -- error duplicado
CALL registroestudiante(201818477, 741220120101,'Diego', 'Arriaga', '2012-12-19', 'Diego@gmail.com', 8712012, '8 avenida',  4); -- ok
CALL registroestudiante(201902238, 3006251851047,'Luis', 'Castellanos', '2001-01-25', 'luis@gmail.com', 42141631, '2 calle',  2); -- ok
 
 
 
 
 
 
 
-- ########################### REGISTRAR DOCENTE ###########################
CALL registrodocente(861220000101,7812000,'Lui$', '_Espino', '2000-12-1', 'Luis@gmail.com', 15054894, '12 avenida'); -- nombre inválido
CALL registrodocente(531019940101, 4501994,'Jorge', 'Alvarez', '1994-10-16', 'Jorgegmail.com', 15186547, '20 avenida'); -- correo inválido
CALL registrodocente(48520030101,1412003,'Arturo', 'Samayoa', '2003-5-4', 'Arturo@gmail.com', 15254587, '4 avenida'); -- ok
CALL registrodocente(48520030101,1412003,'Arturo', 'Samayoa', '2003-5-4', 'Arturo@gmail.com', 15224458, '4 avenida'); -- error duplicado
CALL registrodocente(55720120101,1512012,'William', 'Escobar', '2012-7-10', 'willy@gmail.com',  15374697, '24 avenida'); -- ok
 
 
-- ########################### CREAR CURSO ###########################
    -- Area común
    CALL crearcurso(1, 'Error 1', -25, 3, 1,1); -- número inválido
    CALL crearcurso(1, 'Error 2', 0, -50, 1,1); -- número inválido
    CALL crearcurso(1, 'Error 3', 1, 1, 1,99); -- no existe carrera
    CALL crearcurso(1, 'Error 4!!!!', 1, 1, 1,1); -- nombre inválido
    CALL crearcurso(1, 'Mate 1', 0, 3, 0, 1,1); -- ok
    CALL crearcurso(1, 'Mate 1', 0, 3, 1, 1); -- error duplicado
    CALL crearcurso(2, 'Mate 2', 3, 5, 1, 1); -- ok
    -- Sistemas
    CALL crearcurso(41, 'IPC 1', 0, 3, 1, 2); -- ok
    CALL crearcurso(42, 'Logica de sistemas', 0, 2, 0, 2); -- ok
    CALL crearcurso(43, 'Archivos', 10, 3, 1, 2); -- ok
    CALL crearcurso(44, 'Compi 1', 9, 3, 1, 2); -- ok
    CALL crearcurso(45, 'Bases 1', 12, 3, 1, 2); -- ok
 
 
 
 
 
 
 
 
 
-- ########################### HABILITAR CURSO PARA ASIGNACIÓN 
CALL habilitarcurso('VD', 2,'A', 48520030101, ,1112); -- Habilita Mate 1 con Samayoa con cupo 2 ok
CALL habilitarcurso('2S',  2,'A', 48520030101,1113); -- Habilita Mate 2 con Samayoa con cupo 2 ok
CALL habilitarcurso('VD',  2,'A', 55720120101,41); -- Habilita IPC 1 con William con cupo 2 ok
CALL habilitarcurso('VD',  2, 'A',55720120101,41); -- error duplicado
CALL habilitarcurso('VD',  2,'@',55720120101, 41); -- sección inválida
CALL habilitarcurso('VD',  -32,'A',55720120101, 41); -- cupo inválido
CALL habilitarcurso('',  30,'A', 55720120101,41); -- ciclo vacío
CALL habilitarcurso('1S',  25,'A', 55720120101,999); -- curso no existe
 
 
-- ########################### AGREGAR HORARIO ###########################
CALL agregarhorario(6,'7:00-8:00',999); -- id no existe
CALL agregarhorario(8,'7:00-8:00',1); -- día fuera del rango [1,7]
CALL agregarhorario(4,'???',1); -- horario inválido
CALL agregarhorario(5,'',1); -- horario vacío
CALL agregarhorario(2,'12:00-13:00',1); -- ok
CALL agregarhorario(3,'12:00-13:00',1); -- ok
CALL agregarhorario(1,'18:00-19:00',1); -- ok
CALL agregarhorario(5,'18:00-19:00',1); -- ok
 
 
-- ########################### ASIGNAR CURSO ###########################
CALL asignarcurso(1,'VD','A',777777777); -- carnet no existe
CALL asignarcurso(1,'VD','X',201506554); -- sección no existe
CALL asignarcurso(1,'??','A',201506554); -- ciclo inválido
CALL asignarcurso(9898,'VD','A',201506554); -- curso no existe
CALL asignarcurso(1,'1S','A',201506554); -- no existe esa sección en ese ciclo
CALL asignarcurso(1,'VD','A',201506554); -- ok mate 1
CALL asignarcurso(1,'VD','A',201506554); -- error asignación duplicada
CALL asignarcurso(41,'VD','A',201818477); -- validar curso solo de sistemas
CALL asignarcurso(1,'VD','A',201818477); -- ok mate 1
CALL asignarcurso(1,'VD','A',201902238); -- error ya no hay cupo
CALL asignarcurso(2,'2S','A',201902238); -- error no tiene créditos necesarios
 
-- ########################### DESASIGNACIONES ##########################
CALL deasignarcurso(1,'VD','A',777777777); -- carnet no existe
CALL deasignarcurso(1,'VD','X',201506554); -- sección no existe
CALL deasignarcurso(1,'??','A',201506554); -- ciclo inválido
CALL deasignarcurso(9898,'VD','A',201506554); -- curso no existe
CALL deasignarcurso(1,'1S','A',201506554); -- no existe esa sección en ese ciclo
CALL deasignarcurso(1,'VD','A',201506554); -- ok
CALL deasignarcurso(1,'VD','A',201506554); -- error ya se encuentra desasignado
 
-- YA SE PUEDE ASIGNAR OTRO PORQUE YA HAY CUPO
CALL asignarcurso(1,'VD','A',201902238); -- OK
 
-- NO SE DEBE PODER GENERAR ACTA SIN NOTAS
CALL crearacta(1,'VD','A'); -- error no hay notas ingresadas
 
 
 
 
-- ########################## INGRESO DE NOTAS ##########################
CALL ingresarnotas(1,'VD','A',201818477,-35); -- error nota inválida
CALL ingresarnotas(1,'1S','A',987988787,87); -- error carnet no existe
CALL ingresarnotas(1,'VD','Z',201818477,20.1); -- error seccion no existe
CALL ingresarnotas(1,'??','A',201818477,20.1); -- error ciclo inválido / no existe
CALL ingresarnotas(598,'VD','A',201818477,20.1); -- error curso no existe
CALL ingresarnotas(1,'VD','A',201818477,20.1); -- ok
CALL ingresarnotas(1,'VD','A',201902238,60.5); -- ok
CALL ingresarnotas(1,'VD','A',201818477,49.5); -- error ya tiene nota (o actualizarla pero no duplicarla)
CALL ingresarnotas(1,'VD','A',201818477,200); -- error nota inválida
CALL ingresarnotas(1,'VD','A',201506554,99.45); -- error no se encuentra asignado al curso
 
 
-- ########################## GENERAR ACTA ##########################
CALL crearacta(1,'VD','Y'); -- error no existe sección
CALL crearacta(1,'VJ','A'); -- error no existe ciclo
CALL crearacta(8989,'VD','A'); -- error no existe curso
CALL crearacta(1,'VD','A'); -- ok
CALL crearacta(1,'VD','A'); -- error acta duplicada
 
 
/*************************** PROCESAMIENTO ***************************/
-- PENSUM
CALL consulta1(95959); -- error no existe carrera
CALL consulta1(2); -- ok
 
-- ESTUDIANTE
CALL consulta2(988989); -- error no existe estudiante
CALL consulta2(201902238); -- ok
 
-- DOCENTE
CALL consulta3(988989); -- error no existe docente
CALL consulta3(152); -- ok
 
-- ASIGNADOS
CALL consulta4(1,'VD',2022,'Z'); -- no existe sección
CALL consulta4(1,'VD',2023,'A'); -- no hay datos del año 2023
CALL consulta4(1,'VJ',2023,'A'); -- no hay en ese ciclo
CALL consulta4(4545,'VJ',2023,'A'); -- curso no existe
CALL consulta4(1,'VD',2022,'A'); -- ok
 
-- APROBACIONES
CALL consulta5(1,'VD',2022,'Z'); -- no existe sección
CALL consulta5(1,'VD',2023,'A'); -- no hay datos del año 2023
CALL consulta5(1,'VJ',2023,'A'); -- no hay en ese ciclo
CALL consulta5(4545,'VJ',2023,'A'); -- curso no existe
CALL consulta5(2,'2S',2022,'A'); -- no tiene
CALL consulta5(1,'VD',2022,'A'); -- ok
 
 
-- ACTAS
CALL consulta6(4648); -- error no existe curso
CALL consulta6(2); -- no tiene
CALL consulta6(1); -- ok
 
-- ConsultarDesasignacion
CALL consulta7(1,'VD',2022,'Z'); -- no existe sección
CALL consulta7(1,'VD',2023,'A'); -- no hay datos del año 2023
CALL consulta7(1,'VJ',2023,'A'); -- no hay en ese ciclo
CALL consulta7(4545,'VJ',2023,'A'); -- curso no existe
CALL consulta7(2,'2S',2022,'A'); -- no tiene
CALL consulta7(1,'VD',2022,'A'); -- ok
 
 
 
 
 
/* TABLA HISTORIAL */
-- debe tener los tres tipos de trigger para cada evento (insert, update, delete)
SELECT * FROM historial;
