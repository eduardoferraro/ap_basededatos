-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio` DEFAULT CHARACTER SET utf8 ;
USE `portfolio` ;

-- -----------------------------------------------------
-- Table `portfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `fechaNacimiento` DATE NULL,
  `telefono` VARCHAR(15) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idPersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`tipoTrabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`tipoTrabajo` (
  `idTipoTrabajo` INT NOT NULL AUTO_INCREMENT,
  `nombreTipoTrabajo` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoTrabajo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experiencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experiencia` (
  `idExperiencia` INT NOT NULL AUTO_INCREMENT,
  `nombreEmpresa` VARCHAR(45) NULL,
  `fechaDesde` DATE NULL,
  `fechaHasta` DATE NULL,
  `descripcion` VARCHAR(200) NULL,
  `esActual` TINYINT NULL,
  `tipoTrabajo_idTipoTrabajo` INT NOT NULL,
  PRIMARY KEY (`idExperiencia`),
  INDEX `fk_experiencia_tipo_trabajo1_idx` (`tipoTrabajo_idTipoTrabajo` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_tipo_trabajo1`
    FOREIGN KEY (`tipoTrabajo_idTipoTrabajo`)
    REFERENCES `portfolio`.`tipoTrabajo` (`idTipoTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`tipoEducacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`tipoEducacion` (
  `idTipoEducacion` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoEducacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`titulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`titulo` (
  `idTitulo` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idTitulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`educacion` (
  `idEducacion` INT NOT NULL AUTO_INCREMENT,
  `nombreInstitucion` VARCHAR(45) NULL,
  `fechaDesde` DATE NULL,
  `fechaHasta` DATE NULL,
  `tipoEducacion_idTipoEducacion` INT NOT NULL,
  `titulo_idTitulo` INT NOT NULL,
  PRIMARY KEY (`idEducacion`),
  INDEX `fk_educacion_tipoEdcacion1_idx` (`tipoEducacion_idTipoEducacion` ASC) VISIBLE,
  INDEX `fk_educacion_titulo1_idx` (`titulo_idTitulo` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_tipoEdcacion1`
    FOREIGN KEY (`tipoEducacion_idTipoEducacion`)
    REFERENCES `portfolio`.`tipoEducacion` (`idTipoEducacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_educacion_titulo1`
    FOREIGN KEY (`titulo_idTitulo`)
    REFERENCES `portfolio`.`titulo` (`idTitulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`habilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`habilidad` (
  `idHabilidad` INT NOT NULL AUTO_INCREMENT,
  `nombreHabilidad` VARCHAR(45) NULL,
  `porcentajeHabilidad` DECIMAL(5) NULL,
  PRIMARY KEY (`idHabilidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto` (
  `idProyecto` INT NOT NULL AUTO_INCREMENT,
  `nombreProyecto` VARCHAR(45) NULL,
  `descripcionProyecto` VARCHAR(200) NULL,
  `anioProyecto` DATE NULL,
  `persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idProyecto`),
  INDEX `fk_proyecto_persona1_idx` (`persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_idPersona`)
    REFERENCES `portfolio`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`textoSecciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`textoSecciones` (
  `idTextoSecciones` INT NOT NULL AUTO_INCREMENT,
  `textoEducacion` VARCHAR(200) NULL,
  `textoHabilidades` VARCHAR(200) NULL,
  `textoProyectos` VARCHAR(200) NULL,
  `persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idTextoSecciones`, `persona_idPersona`),
  INDEX `fk_textoSecciones_persona1_idx` (`persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_textoSecciones_persona1`
    FOREIGN KEY (`persona_idPersona`)
    REFERENCES `portfolio`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`imagen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`imagen` (
  `idImagen` INT NOT NULL AUTO_INCREMENT,
  `urlImagenPersona` VARCHAR(45) NULL,
  `urlImagenEducacion` VARCHAR(45) NULL,
  `urlImagenHabilidades` VARCHAR(45) NULL,
  `urlImagenProyectos` VARCHAR(45) NULL,
  `urlImagenCabecera` VARCHAR(45) NULL,
  `persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idImagen`, `persona_idPersona`),
  INDEX `fk_imagen_persona1_idx` (`persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_imagen_persona1`
    FOREIGN KEY (`persona_idPersona`)
    REFERENCES `portfolio`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona_habilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona_habilidad` (
  `persona_idPersona` INT NOT NULL,
  `habilidad_idHabilidad` INT NOT NULL,
  PRIMARY KEY (`persona_idPersona`, `habilidad_idHabilidad`),
  INDEX `fk_persona_has_habilidad_habilidad1_idx` (`habilidad_idHabilidad` ASC) VISIBLE,
  INDEX `fk_persona_has_habilidad_persona1_idx` (`persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_persona_has_habilidad_persona1`
    FOREIGN KEY (`persona_idPersona`)
    REFERENCES `portfolio`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_habilidad_habilidad1`
    FOREIGN KEY (`habilidad_idHabilidad`)
    REFERENCES `portfolio`.`habilidad` (`idHabilidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona_experiencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona_experiencia` (
  `persona_idPersona` INT NOT NULL,
  `experiencia_idExperiencia` INT NOT NULL,
  PRIMARY KEY (`persona_idPersona`, `experiencia_idExperiencia`),
  INDEX `fk_persona_has_experiencia_experiencia1_idx` (`experiencia_idExperiencia` ASC) VISIBLE,
  INDEX `fk_persona_has_experiencia_persona1_idx` (`persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_persona_has_experiencia_persona1`
    FOREIGN KEY (`persona_idPersona`)
    REFERENCES `portfolio`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_experiencia_experiencia1`
    FOREIGN KEY (`experiencia_idExperiencia`)
    REFERENCES `portfolio`.`experiencia` (`idExperiencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona_educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona_educacion` (
  `persona_idPersona` INT NOT NULL,
  `educacion_idEducacion` INT NOT NULL,
  PRIMARY KEY (`persona_idPersona`, `educacion_idEducacion`),
  INDEX `fk_persona_has_educacion_educacion1_idx` (`educacion_idEducacion` ASC) VISIBLE,
  INDEX `fk_persona_has_educacion_persona1_idx` (`persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_persona_has_educacion_persona1`
    FOREIGN KEY (`persona_idPersona`)
    REFERENCES `portfolio`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_educacion_educacion1`
    FOREIGN KEY (`educacion_idEducacion`)
    REFERENCES `portfolio`.`educacion` (`idEducacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
