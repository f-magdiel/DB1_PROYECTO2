-- -----------------------------------------------------
-- Schema FIUSAC
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FIUSAC` DEFAULT CHARACTER SET utf8 ;
USE `FIUSAC` ;

-- -----------------------------------------------------
-- Table `FIUSAC`.`Carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Carrera` (
  `id_carrera` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_carrera`),
  CONSTRAINT CHK_Carrera_nombre CHECK (nombre RLIKE '^([a-z]|[A-Z] )+$'))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Estudiante` (
  `carnet` BIGINT(9) NOT NULL,
  `dpi` BIGINT(13) NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `correo` VARCHAR(50) NOT NULL,
  `telefono` BIGINT(8) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `creditos` INT NOT NULL DEFAULT 0,
  `fecha_creacion` DATE NOT NULL,
  `Carrera_id_carrera` INT NOT NULL,
  PRIMARY KEY (`carnet`),
  CONSTRAINT CHK_Estudiante_correo CHECK(correo RLIKE '[A-Za-z0-9]+@[a-z]+\\.[a-z]+$'),
  INDEX `fk_Estudiante_Carrera_idx` (`Carrera_id_carrera` ASC) VISIBLE,
  CONSTRAINT `fk_Estudiante_Carrera`
    FOREIGN KEY (`Carrera_id_carrera`)
    REFERENCES `FIUSAC`.`Carrera` (`id_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Curso` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `cr_necesarios` INT NOT NULL,
  `cr_otorgados` INT NOT NULL,
  `obligatorio` TINYINT(1) NOT NULL,
  `Carrera_id_carrera` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  CONSTRAINT CHK_Curso_cr_necesarios CHECK (cr_necesarios>0),
  CONSTRAINT CHK_Curso_cr_otorgados CHECK (cr_otorgados>0),
  CONSTRAINT CHK_Curos_obligatorio CHECK (obligatorio In (0,1)),
  INDEX `fk_Curso_Carrera1_idx` (`Carrera_id_carrera` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_Carrera1`
    FOREIGN KEY (`Carrera_id_carrera`)
    REFERENCES `FIUSAC`.`Carrera` (`id_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Docente` (
  `dpi` BIGINT(13) NOT NULL,
  `siif` BIGINT(10) NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `correo` VARCHAR(50) NOT NULL,
  `telefono` BIGINT(8) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`dpi`),
  CONSTRAINT CHK_Docente_correo CHECK(correo RLIKE '[A-Za-z0-9]+@[a-z]+\\.[a-z]+$'))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Curso_Habilitado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Curso_Habilitado` (
  `id_curso_habilitado` INT NOT NULL,
  `ciclos` VARCHAR(50) NOT NULL,
  `cupo` INT NOT NULL,
  `seccion` VARCHAR(1) NOT NULL,
  `periodo` DATE NOT NULL,
  `asignados` INT NOT NULL DEFAULT 0,
  `Docente_dpi` BIGINT(13) NOT NULL,
  `Curso_codigo` INT NOT NULL,
  PRIMARY KEY (`id_curso_habilitado`),
  CONSTRAINT CHK_Curso_obligatorio_ciclos CHECK (ciclos RLIKE '^(1S|2S|VJ|VD)$'),
  CONSTRAINT CHK_Curso_obligatorio_cupo CHECK (cupo > 0),
  INDEX `fk_Curso_Habilitado_Docente1_idx` (`Docente_dpi` ASC) VISIBLE,
  INDEX `fk_Curso_Habilitado_Curso1_idx` (`Curso_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_Habilitado_Docente1`
    FOREIGN KEY (`Docente_dpi`)
    REFERENCES `FIUSAC`.`Docente` (`dpi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Curso_Habilitado_Curso1`
    FOREIGN KEY (`Curso_codigo`)
    REFERENCES `FIUSAC`.`Curso` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Acta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Acta` (
  `id_acta` INT NOT NULL,
  `Curso_Habilitado_id_curso_habilitado` INT NOT NULL,
  PRIMARY KEY (`id_acta`),
  INDEX `fk_Acta_Curso_Habilitado1_idx` (`Curso_Habilitado_id_curso_habilitado` ASC) VISIBLE,
  CONSTRAINT `fk_Acta_Curso_Habilitado1`
    FOREIGN KEY (`Curso_Habilitado_id_curso_habilitado`)
    REFERENCES `FIUSAC`.`Curso_Habilitado` (`id_curso_habilitado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Nota_Estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Nota_Estudiante` (
  `id_nota` INT NOT NULL AUTO_INCREMENT,
  `nota` INT NOT NULL,
  `Estudiante_carnet` BIGINT(9) NOT NULL,
  `Curso_Habilitado_id_curso_habilitado` INT NOT NULL,
  PRIMARY KEY (`id_nota`),
  CONSTRAINT CHK_Nota_Estudiante_nota CHECK (nota>0),
  INDEX `fk_Nota_Estudiante_Estudiante1_idx` (`Estudiante_carnet` ASC) VISIBLE,
  INDEX `fk_Nota_Estudiante_Curso_Habilitado1_idx` (`Curso_Habilitado_id_curso_habilitado` ASC) VISIBLE,
  CONSTRAINT `fk_Nota_Estudiante_Estudiante1`
    FOREIGN KEY (`Estudiante_carnet`)
    REFERENCES `FIUSAC`.`Estudiante` (`carnet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Nota_Estudiante_Curso_Habilitado1`
    FOREIGN KEY (`Curso_Habilitado_id_curso_habilitado`)
    REFERENCES `FIUSAC`.`Curso_Habilitado` (`id_curso_habilitado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Horario_Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Horario_Curso` (
  `dia` INT NOT NULL,
  `horario` VARCHAR(50) NOT NULL,
  `Curso_Habilitado_id_curso_habilitado` INT NOT NULL,
  CONSTRAINT CHK_Horario_Curso_dia CHECK (dia BETWEEN 1 AND 7),
  INDEX `fk_Horario_Curso_Curso_Habilitado1_idx` (`Curso_Habilitado_id_curso_habilitado` ASC) VISIBLE,
  CONSTRAINT `fk_Horario_Curso_Curso_Habilitado1`
    FOREIGN KEY (`Curso_Habilitado_id_curso_habilitado`)
    REFERENCES `FIUSAC`.`Curso_Habilitado` (`id_curso_habilitado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Asignacion_Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Asignacion_Curso` (
  `estado_asignacion` INT NOT NULL,
  `Estudiante_carnet` BIGINT(9) NOT NULL,
  `Curso_Habilitado_id_curso_habilitado` INT NOT NULL,
  INDEX `fk_Asignacion_Curso_Estudiante1_idx` (`Estudiante_carnet` ASC) VISIBLE,
  INDEX `fk_Asignacion_Curso_Curso_Habilitado1_idx` (`Curso_Habilitado_id_curso_habilitado` ASC) VISIBLE,
  CONSTRAINT `fk_Asignacion_Curso_Estudiante1`
    FOREIGN KEY (`Estudiante_carnet`)
    REFERENCES `FIUSAC`.`Estudiante` (`carnet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asignacion_Curso_Curso_Habilitado1`
    FOREIGN KEY (`Curso_Habilitado_id_curso_habilitado`)
    REFERENCES `FIUSAC`.`Curso_Habilitado` (`id_curso_habilitado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FIUSAC`.`Historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIUSAC`.`Historial` (
  `fecha` DATE NOT NULL,
  `descripcion` VARCHAR(50) NOT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  CONSTRAINT CHK_Historial_tipo CHECK(tipo RLIKE '^(INSERT|UPDATE|DELETE)$')
  )
ENGINE = InnoDB;

