SELECT pk_puntoacopio AS pkpuntoacopio, pun_nombre AS nombre, pun_direccion AS direccion, pun_telefono AS telefono
FROM puntoacopio
WHERE pun_estado=1
ORDER BY pun_nombre, pun_direccion;

SELECT pk_usuario AS pkusuario, (usu_paterno||' '||usu_materno||' '||usu_nombre) AS nombrecompleto, usu_telefono AS telefono, usu_alias AS alias
FROM usuario
WHERE usu_estado=1
ORDER BY usu_paterno, usu_materno, usu_nombre;

SELECT pk_material AS pkmaterial, tipomaterial(mat_tipo) AS material, mat_descripcion AS descripcion
FROM material
WHERE mat_estado=1
ORDER BY mat_tipo, mat_descripcion;

SELECT pk_retiro AS pkretiro, ret_fecha AS fecha, ret_empresatransporte AS empresatransporte
FROM retiro
WHERE ret_estado=1
ORDER BY ret_fecha, ret_empresatransporte;

SELECT pk_rol AS pkrol, rol_abreviatura AS abreviatura, rol_descripcion AS descripcion
FROM rol
WHERE rol_estado=1
ORDER BY rol_abreviatura, rol_descripcion;

SELECT pun.pk_puntoacopio AS pkpuntoacopio, pun.pun_nombre AS nombrepunto, pun.pun_direccion AS direccion, pun.pun_telefono AS telefonopunto, rpu.pk_puntousuario AS pkpuntousuario, rpu.rpu_fechaentrega AS fechaentrega, usu.pk_usuario AS pkusuario, (usu.usu_paterno||' '||usu.usu_materno||' '||usu.usu_nombre) AS nombrecompleto, usu.usu_telefono AS telefono, usu.usu_alias AS alias
FROM puntoacopio AS pun
INNER JOIN relpuntousuario AS rpu ON pun.pk_puntoacopio=rpu.fk_pkpuntoacopio
INNER JOIN usuario AS usu ON usu.pk_usuario=rpu.fk_pkusuario
WHERE pun.pun_estado=1 AND rpu.rpu_estado=1 AND usu.usu_estado=1
ORDER BY pun.pun_nombre, rpu.rpu_fechaentrega, usu.usu_paterno, usu.usu_materno, usu.usu_nombre;

SELECT usu.pk_usuario AS pkusuario, (usu.usu_paterno||' '||usu.usu_materno||' '||usu.usu_nombre) AS nombrecompleto, usu.usu_telefono AS telefonousuario, usu.usu_alias AS alias, rol.pk_rol AS pkrol, rol.rol_abreviatura AS abreviatura, rol.rol_descripcion AS descripcion
FROM usuario AS usu
INNER JOIN relusuariorol AS rur ON usu.pk_usuario=rur.fk_pkusuario
INNER JOIN rol AS rol ON rol.pk_rol=rur.fk_pkrol
WHERE usu.usu_estado=1 AND rur.rur_estado=1 AND rol.rol_estado=1
ORDER BY usu.usu_paterno, usu.usu_materno, usu.usu_nombre, rol.rol_abreviatura;

SELECT pun.pk_puntoacopio AS pkpuntoacopio, pun.pun_nombre AS nombrepunto, pun.pun_direccion AS direccion, pun.pun_telefono AS telefonopunto, rpu.rpu_fechaentrega AS fechaentrega, usu.pk_usuario AS pkusuario, (usu.usu_paterno||' '||usu.usu_materno||' '||usu.usu_nombre) AS nombrecompleto, usu.usu_telefono AS telefonousuario, usu.usu_alias AS alias, (pmr.pmr_peso||' Kg') AS peso, tipoentrega(pmr.pmr_tipo) AS entrega, mat.pk_material AS pkmaterial, tipomaterial(mat.mat_tipo) AS tipomaterial, mat.mat_descripcion AS descripcion, ret.pk_retiro AS pkretiro, ret.ret_fecha AS fecha, ret.ret_empresatransporte AS empresatransporte
FROM puntoacopio AS pun
INNER JOIN relpuntousuario AS rpu ON pun.pk_puntoacopio=rpu.fk_pkpuntoacopio
INNER JOIN usuario AS usu ON usu.pk_usuario=rpu.fk_pkusuario
INNER JOIN relpuntousuariomaterialretiro AS pmr ON pmr.fk_pkpuntousuario=rpu.pk_puntousuario
INNER JOIN material AS mat ON mat.pk_material=pmr.fk_pkmaterial
INNER JOIN retiro AS ret ON ret.pk_retiro=pmr.fk_pkretiro
WHERE pun.pun_estado=1 AND rpu.rpu_estado=1 AND usu.usu_estado=1 AND pmr.pmr_estado=1 AND mat.mat_estado=1 AND ret.ret_estado=1
ORDER BY pun.pun_nombre, rpu.rpu_fechaentrega, pmr.pmr_tipo, pmr.pmr_peso, mat.mat_tipo, ret.ret_fecha, ret.ret_empresatransporte;


SELECT pun.pk_puntoacopio, pun.pun_nombre, pun.pun_direccion, pun.pun_telefono, rpu.pk_puntousuario, rpu.rpu_fechaentrega, pmr.pk_puntousuariomaterialretiro, tipoentrega(pmr.pmr_tipo) AS entrega, pmr.pmr_peso, tipomaterial(mat.mat_tipo) AS tipomaterial
FROM puntoacopio AS pun, relpuntousuario AS rpu, relpuntousuariomaterialretiro AS pmr, material AS mat
WHERE pun.pk_puntoacopio=rpu.fk_pkpuntoacopio AND rpu.pk_puntousuario=pmr.fk_pkpuntousuario AND pmr.fk_pkmaterial=mat.pk_material AND pun.pun_estado=1 AND rpu.rpu_estado=1 AND pmr.pmr_estado=1 AND pmr.pmr_tipo=1 AND mat.mat_estado=1
ORDER BY pun.pk_puntoacopio, rpu.pk_puntousuario, pmr.pk_puntousuariomaterialretiro, pmr.pmr_tipo, mat.mat_tipo

SELECT pun.pun_nombre, temp1.materialtipo, (temp1.total||' Kg') pesototal
FROM puntoacopio AS pun,
    (SELECT pun.pk_puntoacopio AS pkpuntoacopio, tipomaterial(mat.mat_tipo) AS materialtipo, SUM(pmr.pmr_peso) AS total
    FROM puntoacopio AS pun, relpuntousuario AS rpu, relpuntousuariomaterialretiro AS pmr, material AS mat
    WHERE pun.pk_puntoacopio=rpu.fk_pkpuntoacopio AND rpu.pk_puntousuario=pmr.fk_pkpuntousuario AND pmr.fk_pkmaterial=mat.pk_material AND pun.pun_estado=1 AND rpu.rpu_estado=1 AND pmr.pmr_estado=1 AND pmr.pmr_tipo=1 AND mat.mat_estado=1
    GROUP BY pun.pk_puntoacopio, mat.mat_tipo) AS temp1
WHERE pun.pk_puntoacopio=temp1.pkpuntoacopio;


