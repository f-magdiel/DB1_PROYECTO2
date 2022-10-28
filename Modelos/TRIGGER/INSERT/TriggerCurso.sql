DELIMITER $$
CREATE TRIGGER trigger_curso
  AFTER INSERT 
  ON curso FOR EACH ROW
BEGIN
  -- Se registra el insert del curso
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE CREO UN CURSO', 'INSERT');
END$$
DELIMITER ;