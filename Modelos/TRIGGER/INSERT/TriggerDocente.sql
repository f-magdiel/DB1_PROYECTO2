DELIMITER $$
CREATE TRIGGER trigger_docente
  AFTER INSERT 
  ON docente FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE REGISTRO UN NUEVO DOCENTE', 'INSERT');
END$$
DELIMITER ;