DELIMITER $$
CREATE TRIGGER trigger_acta
  AFTER INSERT 
  ON acta FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE GENERO NUEVO ACTA', 'INSERT');
END$$
DELIMITER ;