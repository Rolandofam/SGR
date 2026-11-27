# Base de Datos del Sistema de Gestión de Residuos Reciclables - SGR

<h2>📋 Tabla de Contenidos</h2>

- [Modelo Conceptual](#1-modelo-conceptual)
- [Modelo Lógico](#2-modelo-lógico)
- [Modelo Físico](#3-modelo-físico)


## 1 Modelo Conceptual

![Foto del proyecto](./SGR.PNG)
## 2 Modelo Lógico
|TABLA                       |ATRIBUTO / COLUMNA          |TIPO DE DATO |RESTRICCIÓN |DESCRIPCIÓN                                                  |
|----------------------------|----------------------------|-------------|------------|-------------------------------------------------------------|
|puntoacopio                 |pk_puntoacopio              |BIGINT       |PK          |Llave Primaria de PuntoAcopio.                               |
|                            |pun_nombre                  |VARCHAR(100) |DEFAULT NULL|Nombre del PuntoAcopio.                                      |
|                            |pun_direccion               |VARCHAR(255) |DEFAULT NULL|Direccion del PuntoAcopio.                                   |
|                            |pun_telefono                |INT          |DEFAULT 0   |Telefono del PuntoAcopio.                                    |
|                            |pun_estado                  |INT          |DEFAULT 1   |Estado del registro (Des-Habilitado=0, Habilitado=1)         |
|usuario                     |pk_usuario                  |BIGINT       |PK          |Llave Primaria de Usuario.                                   |
|                            |usu_paterno                 |VARCHAR(50)  |NOT NULL    |Apellido Paterno del Usuario                                 |
|                            |usu_materno                 |VARCHAR(50)  |NOT NULL    |Apellido Materno del Usuario                                 |
|                            |usu_nombre                  |VARCHAR(50)  |NOT NULL    |Nombre(s) del Usuario                                        |
|                            |usu_telefono                |INT          |DEFAULT 0   |Telefono del Usuario.                                        |
|                            |usu_alias                   |VARCHAR(20)  |NOT NULL    |Alias del Usuario.                                           |
|                            |usu_contrasenia             |VARCHAR(100) |NOT NULL    |Contrasenia del Usuario.                                     |
|                            |usu_estado                  |INT          |DEFAULT 1   |Estado del registro (Des-Habilitado=0, Habilitado=1)         |
|rol                         |pk_rol                      |BIGINT       |PK          |Llave Primaria de Rol                                        |
|                            |rol_abreviatura             |VARCHAR(20)  |NOT NULL    |Abreviatura del Rol ( admin, etc )                           |
|                            |rol_descripcion             |VARCHAR(255) |NOT NULL    |Descripcion del Rol ( Administrador ).                       |
|                            |rol_estado                  |INT          |DEFAULT 1   |Estado del registro (Des-Habilitado=0, Habilitado=1)         |
|material                    |pk_material                 |BIGINT       |PK          |Llave Primaria de Material.                                  |
|                            |mat_tipo                    |INT          |DEFAULT 0   |Tipo de Material ( Papel=0, Plastico=1, Vidrio=2, Carton=3 ).|
|                            |mat_descripcion             |VARCHAR(255) |NOT NULL    |Descripcion del Material  por tipo.                          |
|                            |mat_estado                  |INT          |DEFAULT 1   |Estado del registro (Des-Habilitado=0, Habilitado=1)         |
|retiro                      |pk_retiro                   |BIGINT       |PK          |Llave Primaria de Retiro.                                    |
|                            |ret_fecha                   |DATE         |DEFAULT DATE|Fecha de Retido del Material.                                |
|                            |ret_empresatransporte       |VARCHAR(100) |NOT NULL    |Enpresa o transporte que realizo el retido                   |
|                            |ret_estado                  |INT          |DEFAULT 1   |Estado del registro (Des-Habilitado=0, Habilitado=1)         |
|relpuntousuario             |pk_puntousuario             |BIGINT       |PK          |Llave Primaria de PuntoUsuario.                              |
|                            |rpu_fechaentrega            |DATE         |DEFAULT DATE|Feha del PuntoUsuario.                                       |
|                            |fk_pkpuntoacopio            |INT          |FK, NOT NULL|Llave Foranea ( Llave Primaria de PuntoAcopio ).             |
|                            |fk_pkresponsable            |INT          |FK, NOT NULL|Llave Foranea ( Llave Primaria de Usuario ).                 |
|                            |rpu_estado                  |INT          |DEFAULT 1   |Estado del registro (Des-Habilitado=0, Habilitado=1)         |
|relpuntousuariomateriaretiro|pk_puntousuariomateriaretiro|BIGINT       |PK          |Llave Primaria de PuntoMateriaRetiro.                        |
|                            |pmr_peso                    |DECIMAL(5, 2)|DEFAULT 0   |Peso de la entrega en Kg                                     |
|                            |pmr_tipo                    |INT          |DEFAULT 1   |Tipo de EntregaMateriaRetiro ( En Acopio=1 o Retirado=0 )    |
|                            |fk_pkpuntousuario           |INT          |FK, NOT NULL|Llave Foranea ( Lave Primaria de PuntoUsuario )              |
|                            |fk_pkmaterial               |INT          |FK, NOT NULL|Llave Foranea ( Lave Primaria de Material )                  |
|                            |fk_pkretiro                 |INT          |FK, NOT NULL|Llave Foranea ( Lave Primaria de Retiro )                    |
|                            |enr_estado                  |INT          |DEFAULT 1   |Estado del registro (Des-Habilitado=0, Habilitado=1)         |
|relusuariorol               |pk_usuariorol               |BIGINT       |PK          |Llave Primaria de UsuarioRol.                                |
|                            |rur_estado                  |INT          |DEFAULT 1   |Estado del registro (Des-Habilitado=0, Habilitado=1)         |
|                            |fk_pkusuario                |INT          |FK, NOT NULL|Lleve Foranea ( Llave Primaria de Usuario)                   |
|                            |fk_pkrol                    |INT          |FK, NOT NULL|Lleve Foranea ( Llave Primaria de Rol).                      |

## 3 Modelo Físico
## 3.1 PuntoAcopio
```sql
CREATE TABLE puntoacopio (
    pk_puntoacopio BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pun_nombre CHARACTER VARYING(100) DEFAULT NOT NULL,
    pun_direccion CHARACTER VARYING(255) DEFAULT NOT NULL,
    pun_telefono INTEGER DEFAULT 0,
    pun_estado INTEGER DEFAULT 1
);
```
## 3.2 Usuario
```sql
CREATE TABLE usuario (
    pk_usuario BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usu_paterno CHARACTER VARYING(50) DEFAULT NULL::CHARACTER VARYING,
    usu_materno CHARACTER VARYING(50) DEFAULT NULL::CHARACTER VARYING,
    usu_nombre CHARACTER VARYING(50) DEFAULT NOT NULL::CHARACTER VARYING,
    usu_telefono INTEGER DEFAULT 0,
    usu_alias CHARACTER VARYING(20) DEFAULT NOT NULL::CHARACTER VARYING,
    usu_contrasenia CHARACTER VARYING(100) DEFAULT NOT NULL::CHARACTER VARYING,
    usu_estado INTEGER DEFAULT 1
);
```
## 3.3 Rol
```sql
CREATE TABLE rol (
    pk_rol BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rol_abreviatura CHARACTER VARYING(20) DEFAULT NOT NULL::CHARACTER VARYING,
    rol_descripcion CHARACTER VARYING(255) DEFAULT NOT NULL::CHARACTER VARYING,
    rol_estado INTEGER DEFAULT 1
);
```

## 3.4 Material
```sql
CREATE TABLE material (
    pk_material BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    mat_tipo INTEGER DEFAULT 0,
    mat_descripcion CHARACTER VARYING(255) DEFAULT NOT NULL,
    mat_estado INTEGER DEFAULT 1
);
```
## 3.5. Retiro
```sql
CREATE TABLE retiro (
    pk_retiro BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ret_fecha DATE DEFAULT (NOW())::DATE,
    ret_empresatransporte CHARACTER VARYING(255) DEFAULT NOT NULL,
    ret_estado INTEGER DEFAULT 1
);
```
## 3.6 RelPuntoUsuario
```sql
CREATE TABLE relpuntousuario (
    pk_puntousuario BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rpu_fechaentrega DATE DEFAULT (NOW())::DATE,
    fk_pkpuntoacopio INTEGER NOT NULL,
    fk_pkusuario INTEGER NOT NULL,
    rpu_estado INTEGER DEFAULT 1,
    FOREIGN KEY (fk_pkpuntoacopio) REFERENCES puntoacopio(pk_puntoacopio) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (fk_pkusuario) REFERENCES usuario(pk_usuario) ON UPDATE RESTRICT ON DELETE RESTRICT
);
```
## 3.7 RelPuntoUsuarioMateriaRetiro
```sql
CREATE TABLE relpuntousuariomateriaretiro (
    pk_puntousuariomateriaretiro BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pmr_peso DECIMAL(5, 2) DEFAULT 0,
    pmr_tipo INTEGER DEFAULT 1,
    fk_pkpuntousuario INTEGER NOT NULL,
    fk_pkmaterial INTEGER NOT NULL,
    fk_pkretiro INTEGER NOT NULL,
    enr_estado INTEGER DEFAULT 1,
    FOREIGN KEY (fk_pkpuntousuario) REFERENCES relpuntousuario(pk_puntousuario) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (fk_pkmaterial) REFERENCES material(pk_material) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (fk_pkretiro) REFERENCES retiro(pk_retiro) ON UPDATE RESTRICT ON DELETE RESTRICT
);
```
## 3.8 RelUsuarioRol
```sql
CREATE TABLE relusuariorol (
    pk_usuariorol BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rur_estado INTEGER DEFAULT 1,
    fk_pkusuario INTEGER NOT NULL,
    fk_pkrol INTEGER NOT NULL,
    FOREIGN KEY (fk_pkusuario) REFERENCES usuario(pk_usuario) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (fk_pkrol) REFERENCES rol(pk_rol) ON UPDATE RESTRICT ON DELETE RESTRICT
);
```
