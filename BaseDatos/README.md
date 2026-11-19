# Base de Datos del Sistema de Gestión de Residuos Reciclables - SGR

<h2>📋 Tabla de Contenidos</h2>

- [Modelo Conceptual](#1-modelo-conceptual)
- [Modelo Lógico](#2-modelo-lógico)
- [Modelo Físico](#3-modelo-físico)


## 1 Modelo Conceptual

![Foto del proyecto](./SGR.PNG)
## 2 Modelo Lógico
|Tabla          |Atributo / Columna|Tipo de Dato |Restricción |Descripción                                      |
|---------------|------------------|-------------|------------|-------------------------------------------------|
|puntoacopio    |pk_puntoacopio    |SERIAL       |PK          |Llave Primaria de PuntoAcopio.                   |
|               |pun_nombre        |VARCHAR(100) |NOT NULL    |Nombre del PuntoAcopio.                          |
|               |pun_direccion     |VARCHAR(200) |NOT NULL    |Direccion del PuntoAcopio.                       |
|               |pun_telefono      |VARCHAR(20)  |NULL        |Telefono del PuntoAcopio.                        |
|               |pun_estado        |INT          |NOT NULL    |Estado del registro (Des-Habilitado=0, Habilitado=1)|
|responsable    |pk_responsable    |SERIAL       |PK          |Llave Primaria de Responsble.                    |
|               |res_nombre        |VARCHAR(150) |NOT NULL    |Nombre del Responsable.                          |
|               |res_telefono      |VARCHAR(20)  |NULL        |Telefono del Responsable.                        |
|               |res_estado        |INT          |NOT NULL    |Estado del registro (Des-Habilitado=0, Habilitado=1)|
|material       |pk_material       |SERIAL       |PK          |Llave Primaria de Material.                      |
|               |mat_tipo          |VARCHAR(50)  |UNIQUE      |Tipo de Material ( Papel=0, Plastico=1, Vidrio=2, Carton=3 ).|
|               |mat_descripcion   |TEXT         |NULL        |Descripcion del Material  por tipo.              |
|               |mat_estado        |INT          |NOT NULL    |Estado del registro (Des-Habilitado=0, Habilitado=1)|
|retiro         |pk_retiro         |SERIAL       |PK          |Llave Primaria de Retiro.                        |
|               |ret_fecha         |DATE         |NOT NULL    |Fecha de Retido del Material.                    |
|               |ret_empresatransporte|VARCHAR(100) |NOT NULL    |Enpresa o transporte que realizo el retido       |
|               |ret_estado        |INT          |NOT NULL    |Estado del registro (Des-Habilitado=0, Habilitado=1)|
|relpuntoresponsable – entrega|pk_puntoresponsable|SERIAL       |PK          |Llave Primaria de PuntoResponsable.              |
|               |rpr_fechaentrega  |DATE         |NOT NULL    |Feha del PuntoResponsable.                       |
|               |fk_pkpuntoacopio  |INT          |FK, NOT NULL|Llave Foranea ( Llave Primaria de PuntoAcopio ). |
|               |fk_pkresponsable  |INT          |FK, NOT NULL|Llave Foranea ( Llave Primaria de Responsable ). |
|               |rpr_estado        |INT          |NOT NULL    |Estado del registro (Des-Habilitado=0, Habilitado=1)|
|relentregamaterialretiro - detalle_entrega|pk_entregamateriaretiro|SERIAL       |PK          |Llave Primaria de EntregaMateriaRetiro.          |
|               |enr_peso          |NUMERIC(3,2) |NOT NULL    |Peso de la entrega en Kg                         |
|               |enr_tipo          |INT          |NOT NULL    |Tipo de EntregaMateriaRetiro ( En Acopio=1 o Retirado=0 )|
|               |fk_pkpuntoresponsable|INT          |FK, NOT NULL|Llave Foranea ( Lave Primaria de PuntoResponsable )|
|               |fk_pkmaterial     |INT          |FK, NOT NULL|Llave Foranea ( Lave Primaria de Material )      |
|               |fk_pkretiro       |INT          |FK, NOT NULL|Llave Foranea ( Lave Primaria de Retiro )        |
|               |enr_estado        |INT          |NOT NULL    |Estado del registro (Des-Habilitado=0, Habilitado=1)|
## 3 Modelo Físico
## 3.1 PuntoAcopio
```sql
CREATE TABLE puntoacopio
(
  pk_puntoacopio serial NOT NULL,
  pun_nombre character varying(255) DEFAULT NULL::character varying,
  pun_direccion character varying(255) DEFAULT NULL::character varying,
  pun_telefono character varying(255) DEFAULT NULL::character varying,
  pun_estado integer DEFAULT 0,
  CONSTRAINT puntoacopio_pkey PRIMARY KEY (pk_puntoacopio)
```
## 3.2 Responsable
```sql
CREATE TABLE responsable
(
  pk_responsable serial NOT NULL,
  res_nombre character varying(255) DEFAULT NULL::character varying,
  res_telefono character varying(255) DEFAULT NULL::character varying,
  res_estado integer DEFAULT 0,
  CONSTRAINT responsable_pkey PRIMARY KEY (pk_responsable)
)
```
## 3.3 Material
```sql
CREATE TABLE material
(
  pk_material serial NOT NULL,
  mat_tipo integer DEFAULT 0,
  mat_descripcion character varying(255) DEFAULT NULL::character varying,
  mat_estado integer DEFAULT 0,
  CONSTRAINT material_pkey PRIMARY KEY (pk_material)
)
```
## 3.4. Retiro
```sql
CREATE TABLE retiro
(
  pk_retiro serial NOT NULL,
  ret_fecha timestamp without time zone,
  ret_empresatransporte character varying(255) DEFAULT NULL::character varying,
  ret_estado integer DEFAULT 0,
  CONSTRAINT retiro_pkey PRIMARY KEY (pk_retiro)
)
```
## 3.5 RelPuntoResponsable - Entrega
```sql
CREATE TABLE relpuntoresponsable
(
  pk_puntoresponsable serial NOT NULL,
  rpr_fechaentrega timestamp without time zone,
  fk_pkpuntoacopio integer DEFAULT 0,
  fk_pkresponsable integer DEFAULT 0,
  rpr_estado integer DEFAULT 0,
  CONSTRAINT relpuntoresponsable_pkey PRIMARY KEY (pk_puntoresponsable),
  CONSTRAINT relpuntoresponsable_fk_pkpuntoacopio_fkey FOREIGN KEY (fk_pkpuntoacopio)
      REFERENCES puntoacopio (pk_puntoacopio) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT relpuntoresponsable_fk_pkresponsable_fkey FOREIGN KEY (fk_pkresponsable)
      REFERENCES responsable (pk_responsable) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
```
## 3.6 RelEntregaMateriaRetiro - Detalle_Entrega
```sql
CREATE TABLE relentregamateriaretiro
(
  pk_entregamateriaretiro serial NOT NULL,
  enr_peso integer DEFAULT 0,
  ent_tipo integer DEFAULT 0,
  fk_pkpuntoresponsable integer DEFAULT 0,
  fk_pkmaterial integer DEFAULT 0,
  fk_pkretiro integer DEFAULT 0,
  enr_estado integer DEFAULT 0,
  CONSTRAINT relentregamateriaretiro_pkey PRIMARY KEY (pk_entregamateriaretiro),
  CONSTRAINT relentregamateriaretiro_fk_pkmaterial_fkey FOREIGN KEY (fk_pkmaterial)
      REFERENCES material (pk_material) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT relentregamateriaretiro_fk_pkpuntoresponsable_fkey FOREIGN KEY (fk_pkpuntoresponsable)
      REFERENCES relpuntoresponsable (pk_puntoresponsable) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT relentregamateriaretiro_fk_pkretiro_fkey FOREIGN KEY (fk_pkretiro)
      REFERENCES retiro (pk_retiro) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
)
```
