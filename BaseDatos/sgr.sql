-- PostgreSQL v18.7

CREATE TABLE puntoacopio (
    pk_puntoacopio SERIAL NOT NULL PRIMARY KEY,
    pun_nombre CHARACTER VARYINg(100) DEFAULT NULL,
    pun_direccion CHARACTER VARYINg(255) DEFAULT NULL,
    pun_telefono INTEGER DEFAULT 0,
    pun_estado INTEGER DEFAULT 1
);

CREATE TABLE responsable (
    pk_responsable SERIAL NOT NULL PRIMARY KEY,
    res_nombre CHARACTER VARYINg(100) DEFAULT NULL,
    res_telefono INTEGER DEFAULT 0,
    res_estado INTEGER DEFAULT 1
);

CREATE TABLE material (
    pk_material SERIAL NOT NULL PRIMARY KEY,
    mat_tipo INTEGER DEFAULT 0,
    mat_descripcion CHARACTER VARYINg(255) DEFAULT NULL,
    mat_estado INTEGER DEFAULT 1
);

CREATE TABLE retiro (
    pk_retiro SERIAL NOT NULL PRIMARY KEY,
    ret_fecha DATE DEFAULT (NOW())::DATE,
    ret_empresatransporte CHARACTER VARYINg(255) DEFAULT NULL,
    ret_estado INTEGER DEFAULT 1
);

CREATE TABLE relpuntoresponsable (
    pk_puntoresponsable SERIAL NOT NULL PRIMARY KEY,
    rpr_fechaentrega DATE DEFAULT (NOW())::DATE,
    fk_pkpuntoacopio INTEGER DEFAULT 0,
    fk_pkresponsable INTEGER DEFAULT 0,
    rpr_estado INTEGER DEFAULT 1,
    FOREIGN KEY (fk_pkpuntoacopio) REFERENCES puntoacopio(pk_puntoacopio) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (fk_pkresponsable) REFERENCES responsable(pk_responsable) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE relentregamateriaretiro (
    pk_entregamateriaretiro SERIAL NOT NULL PRIMARY KEY,
    enr_peso DECIMAL(5, 2) DEFAULT 0,
    enr_tipo INTEGER DEFAULT 0,
    fk_pkpuntoresponsable INTEGER DEFAULT 0,
    fk_pkmaterial INTEGER DEFAULT 0,
    fk_pkretiro INTEGER DEFAULT 0,
    enr_estado INTEGER DEFAULT 1,
    FOREIGN KEY (fk_pkpuntoresponsable) REFERENCES relpuntoresponsable(pk_puntoresponsable) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (fk_pkmaterial) REFERENCES material(pk_material) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (fk_pkretiro) REFERENCES retiro(pk_retiro) ON UPDATE RESTRICT ON DELETE RESTRICT
);

