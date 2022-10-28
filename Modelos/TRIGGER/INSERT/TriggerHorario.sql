DELIMITER $$
CREATE TRIGGER trigger_horario
  AFTER INSERT 
  ON horario_curso FOR EACH ROW
BEGIN
  -- Se registra el update
    INSERT INTO Historial (fecha, descripcion, tipo)
    VALUES (CURDATE(), 'SE CREO UN NUEVO HORARIO', 'INSERT');
END$$
DELIMITER ;