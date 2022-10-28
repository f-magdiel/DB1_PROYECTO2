DELIMITER $$
CREATE TRIGGER trigger_notas
  AFTER INSERT 
  ON nota_estudiante FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE INGRESO NOTA', 'INSERT');
END$$
DELIMITER ;