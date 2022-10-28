DELIMITER $$
CREATE TRIGGER trigger_estudiante
  AFTER INSERT 
  ON estudiante FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE REGISTRO UN NUEVO ESTUDIANTE', 'INSERT');
END$$
DELIMITER ;