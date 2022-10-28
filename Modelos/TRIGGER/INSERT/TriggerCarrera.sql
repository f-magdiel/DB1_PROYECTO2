DELIMITER $$
CREATE TRIGGER trigger_carrera
  AFTER INSERT 
  ON carrera FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE CREO UNA CARRERA', 'INSERT');
END$$
DELIMITER ;
