DELIMITER $$
CREATE TRIGGER trigger_habilitar
  AFTER INSERT 
  ON curso_habilitado FOR EACH ROW
BEGIN
  -- Se registra el insert en la tabla
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE HABILITO UN CURSO', 'INSERT');
END$$
DELIMITER ;