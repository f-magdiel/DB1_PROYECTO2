DELIMITER $$
CREATE TRIGGER trigger_asignacion_up
  AFTER UPDATE 
  ON asignacion_curso FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE ACTUALIZO EL ESTADO DE ASIGNACION ESTUDIANTE', 'UPDATE');
END$$
DELIMITER ;