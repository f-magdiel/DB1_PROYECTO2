DELIMITER $$
CREATE TRIGGER trigger_estudiante_up
  AFTER UPDATE 
  ON estudiante FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE ACTUALIZO DATOS ESTUDIANTE', 'UPDATE');
END$$
DELIMITER ;
