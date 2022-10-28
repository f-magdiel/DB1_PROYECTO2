DELIMITER $$
CREATE TRIGGER trigger_habilitar_up
  AFTER UPDATE 
  ON curso_habilitado FOR EACH ROW
BEGIN
  -- Se registra el aumento de asignados en la tabla 
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'AUMENTO LA CANTIDAD DE ASIGNADOS', 'UPDATE');
END$$
DELIMITER ;