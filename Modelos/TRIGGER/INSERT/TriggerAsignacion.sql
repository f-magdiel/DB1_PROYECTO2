DELIMITER $$
CREATE TRIGGER trigger_asignacion
  AFTER INSERT 
  ON asignacion_curso FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE ASIGNO UN ESTUDIANTE', 'INSERT');
END$$
DELIMITER ;