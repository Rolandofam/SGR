--
-- PostgreSQL database dump
--

\restrict CHD9RlTVgpnJsOzEltFg2mhQEpg0Wq1ssjyXfe4bzbdPmcPFhKUHziSPBt2mKmN

-- Dumped from database version 18.7
-- Dumped by pg_dump version 18.7

-- Started on 2026-11-25 22:33:03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 25334)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 295 (class 1255 OID 25378)
-- Name: cifrado(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cifrado(text, integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
    cadena ALIAS FOR $1;
    tipo ALIAS FOR $2;
    cadenaporcifrar TEXT;
    cadenacifrada TEXT;
    clave TEXT;
    alfabeto_base CONSTANT TEXT := '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    alfabeto_custom CONSTANT TEXT := 'X9#M2@K7!L5$P8&W';
BEGIN
    SELECT cla_contrasenia INTO clave
    FROM clave
    WHERE cla_estado=1;
    IF tipo = 0
    THEN
        cadenaporcifrar := cadena;
    END IF;
    IF tipo = 1
    THEN
        cadenaporcifrar := cadena || '$%&' || TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI:SS.MS');
    END IF;
    cadenacifrada:=encode(pgp_sym_encrypt(cadenaporcifrar, clave), 'hex');
    RETURN translate(cadenacifrada, alfabeto_base, alfabeto_custom);
END;
$_$;


ALTER FUNCTION public.cifrado(text, integer) OWNER TO postgres;

--
-- TOC entry 296 (class 1255 OID 25379)
-- Name: descifrado(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.descifrado(text, integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
    cifrado ALIAS FOR $1;
    tipo ALIAS FOR $2;
    cadenapordescifrar BYTEA;
    cadenadescifrar TEXT;
    clave TEXT;
    alfabeto_base CONSTANT TEXT := '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    alfabeto_custom CONSTANT TEXT := 'X9#M2@K7!L5$P8&W';
BEGIN
    SELECT cla_contrasenia INTO clave
    FROM clave
    WHERE cla_estado=1;
    cadenapordescifrar:=decode(translate(cifrado, alfabeto_custom, alfabeto_base), 'hex');
    IF tipo = 0
    THEN
        cadenadescifrar := pgp_sym_decrypt(cadenapordescifrar, clave);
        
    END IF;
    IF tipo = 1
    THEN
        -- cadenadescifrar := pgp_sym_decrypt(cifrado, clave);
        -- translate(cifrado, alfabeto_custom, alfabeto_base);
        cadenadescifrar := SPLIT_PART(pgp_sym_decrypt(cadenapordescifrar, clave), '$%&', 1);
        -- cadenadescifrar := cadena || '$%&' || TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI:SS.MS');
    END IF;

    -- v_clave_dinamica := p_clave_base || '$%&' || TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD');
    
    RETURN cadenadescifrar;
END;
$_$;


ALTER FUNCTION public.descifrado(text, integer) OWNER TO postgres;

--
-- TOC entry 298 (class 1255 OID 25381)
-- Name: tipoentrega(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tipoentrega(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
    tipo ALIAS FOR $1;
    entrega TEXT;
BEGIN
    IF tipo = 0
    THEN
        entrega := 'Retirado';
    END IF;
    IF tipo = 1
    THEN
        entrega := 'Acopio';
    END IF;
    RETURN entrega;
END;
$_$;


ALTER FUNCTION public.tipoentrega(integer) OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 298
-- Name: FUNCTION tipoentrega(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.tipoentrega(integer) IS 'Muestra El Tipo De Entrega';


--
-- TOC entry 297 (class 1255 OID 25380)
-- Name: tipomaterial(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tipomaterial(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
    tipo ALIAS FOR $1;
    material TEXT;
BEGIN
    IF tipo = 0
    THEN
        material := 'Papel';
    END IF;
    IF tipo = 1
    THEN
        material := 'Plastico';
    END IF;
    IF tipo = 2
    THEN
        material := 'Vidrio';
    END IF;
    IF tipo = 3
    THEN
        material := 'Carton';
    END IF;
    RETURN material;
END;
$_$;


ALTER FUNCTION public.tipomaterial(integer) OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 297
-- Name: FUNCTION tipomaterial(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.tipomaterial(integer) IS 'Muestra El Tipo De Material';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 237 (class 1259 OID 25323)
-- Name: clave; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clave (
    pk_clave bigint NOT NULL,
    cla_contrasenia character varying(255) DEFAULT NULL::character varying,
    cla_estado integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.clave OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 25322)
-- Name: clave_pk_clave_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clave ALTER COLUMN pk_clave ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clave_pk_clave_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 25236)
-- Name: material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material (
    pk_material bigint NOT NULL,
    mat_tipo integer DEFAULT 0,
    mat_descripcion character varying(255) DEFAULT NULL::character varying,
    mat_estado integer DEFAULT 1
);


ALTER TABLE public.material OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25197)
-- Name: puntoacopio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.puntoacopio (
    pk_puntoacopio bigint NOT NULL,
    pun_nombre character varying(100) DEFAULT NULL::character varying,
    pun_direccion character varying(255) DEFAULT NULL::character varying,
    pun_telefono integer DEFAULT 0,
    pun_estado integer DEFAULT 1
);


ALTER TABLE public.puntoacopio OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25256)
-- Name: relpuntousuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relpuntousuario (
    pk_puntousuario bigint NOT NULL,
    rpu_fechaentrega date DEFAULT (now())::date,
    fk_pkpuntoacopio integer DEFAULT 0,
    fk_pkusuario integer DEFAULT 0,
    rpu_estado integer DEFAULT 1
);


ALTER TABLE public.relpuntousuario OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25277)
-- Name: relpuntousuariomaterialretiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relpuntousuariomaterialretiro (
    pk_puntousuariomaterialretiro bigint CONSTRAINT relpuntousuariomateriaretir_pk_puntousuariomateriareti_not_null NOT NULL,
    pmr_peso numeric(5,2) DEFAULT 0,
    pmr_tipo integer DEFAULT 0,
    fk_pkpuntousuario integer DEFAULT 0,
    fk_pkmaterial integer DEFAULT 0,
    fk_pkretiro integer DEFAULT 0,
    pmr_estado integer DEFAULT 1
);


ALTER TABLE public.relpuntousuariomaterialretiro OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25246)
-- Name: retiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.retiro (
    pk_retiro bigint NOT NULL,
    ret_fecha date DEFAULT (now())::date,
    ret_empresatransporte character varying(255) DEFAULT NULL::character varying,
    ret_estado integer DEFAULT 1
);


ALTER TABLE public.retiro OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25208)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    pk_usuario bigint NOT NULL,
    usu_paterno character varying(255) DEFAULT NULL::character varying,
    usu_materno character varying(255) DEFAULT NULL::character varying,
    usu_nombre character varying(255) DEFAULT NULL::character varying,
    usu_telefono integer DEFAULT 0,
    usu_alias character varying(255) DEFAULT NULL::character varying,
    usu_contrasenia character varying(255) DEFAULT NULL::character varying,
    usu_estado integer DEFAULT 1
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 25412)
-- Name: listaacopidmaterialusuarioretiromaterial; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listaacopidmaterialusuarioretiromaterial AS
 SELECT public.cifrado((pun.pk_puntoacopio || ''::text), 1) AS pkpuntoacopio,
    pun.pun_nombre AS nombrepunto,
    pun.pun_direccion AS direccion,
    pun.pun_telefono AS telefonopunto,
    rpu.rpu_fechaentrega AS fechaentrega,
    public.cifrado((usu.pk_usuario || ''::text), 1) AS pkusuario,
    (((((usu.usu_paterno)::text || ' '::text) || (usu.usu_materno)::text) || ' '::text) || (usu.usu_nombre)::text) AS nombrecompleto,
    usu.usu_telefono AS telefonousuario,
    usu.usu_alias AS alias,
    (pmr.pmr_peso || ' Kg'::text) AS peso,
    public.tipoentrega(pmr.pmr_tipo) AS entrega,
    public.cifrado((mat.pk_material || ''::text), 1) AS pkmaterial,
    public.tipomaterial(mat.mat_tipo) AS tipomaterial,
    mat.mat_descripcion AS descripcion,
    public.cifrado((ret.pk_retiro || ''::text), 1) AS pkretiro,
    ret.ret_fecha AS fecha,
    ret.ret_empresatransporte AS empresatransporte
   FROM (((((public.puntoacopio pun
     JOIN public.relpuntousuario rpu ON ((pun.pk_puntoacopio = rpu.fk_pkpuntoacopio)))
     JOIN public.usuario usu ON ((usu.pk_usuario = rpu.fk_pkusuario)))
     JOIN public.relpuntousuariomaterialretiro pmr ON ((pmr.fk_pkpuntousuario = rpu.pk_puntousuario)))
     JOIN public.material mat ON ((mat.pk_material = pmr.fk_pkmaterial)))
     JOIN public.retiro ret ON ((ret.pk_retiro = pmr.fk_pkretiro)))
  WHERE ((pun.pun_estado = 1) AND (rpu.rpu_estado = 1) AND (usu.usu_estado = 1) AND (pmr.pmr_estado = 1) AND (mat.mat_estado = 1) AND (ret.ret_estado = 1))
  ORDER BY pun.pun_nombre, rpu.rpu_fechaentrega, pmr.pmr_tipo, pmr.pmr_peso, mat.mat_tipo, ret.ret_fecha, ret.ret_empresatransporte;


ALTER VIEW public.listaacopidmaterialusuarioretiromaterial OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 245
-- Name: VIEW listaacopidmaterialusuarioretiromaterial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listaacopidmaterialusuarioretiromaterial IS 'Lista Los Puntos De Acopi De Material Por Que Usuario U El Retiro Del Material.';


--
-- TOC entry 246 (class 1259 OID 25417)
-- Name: listacantidadmaterialpuntoacopio; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listacantidadmaterialpuntoacopio AS
 SELECT pun.pun_nombre,
    temp1.materialtipo,
    (temp1.total || ' Kg'::text) AS pesototal
   FROM public.puntoacopio pun,
    ( SELECT pun_1.pk_puntoacopio AS pkpuntoacopio,
            public.tipomaterial(mat.mat_tipo) AS materialtipo,
            sum(pmr.pmr_peso) AS total
           FROM public.puntoacopio pun_1,
            public.relpuntousuario rpu,
            public.relpuntousuariomaterialretiro pmr,
            public.material mat
          WHERE ((pun_1.pk_puntoacopio = rpu.fk_pkpuntoacopio) AND (rpu.pk_puntousuario = pmr.fk_pkpuntousuario) AND (pmr.fk_pkmaterial = mat.pk_material) AND (pun_1.pun_estado = 1) AND (rpu.rpu_estado = 1) AND (pmr.pmr_estado = 1) AND (pmr.pmr_tipo = 1) AND (mat.mat_estado = 1))
          GROUP BY pun_1.pk_puntoacopio, mat.mat_tipo) temp1
  WHERE (pun.pk_puntoacopio = temp1.pkpuntoacopio);


ALTER VIEW public.listacantidadmaterialpuntoacopio OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 246
-- Name: VIEW listacantidadmaterialpuntoacopio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listacantidadmaterialpuntoacopio IS 'Lista Los Puntos De Acopio y el total del material recolentado.';


--
-- TOC entry 240 (class 1259 OID 25390)
-- Name: listamaterial; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listamaterial AS
 SELECT public.cifrado((pk_material || ''::text), 1) AS pkmaterial,
    public.tipomaterial(mat_tipo) AS material,
    mat_descripcion AS descripcion
   FROM public.material
  WHERE (mat_estado = 1)
  ORDER BY mat_tipo, mat_descripcion;


ALTER VIEW public.listamaterial OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 240
-- Name: VIEW listamaterial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listamaterial IS 'Lista Los Materiales';


--
-- TOC entry 238 (class 1259 OID 25382)
-- Name: listapuntoacopio; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listapuntoacopio AS
 SELECT public.cifrado((pk_puntoacopio || ''::text), 1) AS pkpuntoacopio,
    pun_nombre AS nombre,
    pun_direccion AS direccion,
    pun_telefono AS telefono
   FROM public.puntoacopio
  WHERE (pun_estado = 1)
  ORDER BY pun_nombre, pun_direccion;


ALTER VIEW public.listapuntoacopio OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 238
-- Name: VIEW listapuntoacopio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listapuntoacopio IS 'Lista Los Puntos De Acopio';


--
-- TOC entry 243 (class 1259 OID 25402)
-- Name: listapuntoacopiousuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listapuntoacopiousuario AS
 SELECT public.cifrado((pun.pk_puntoacopio || ''::text), 1) AS pkpuntoacopio,
    pun.pun_nombre AS nombrepunto,
    pun.pun_direccion AS direccion,
    pun.pun_telefono AS telefonopunto,
    public.cifrado((rpu.pk_puntousuario || ''::text), 1) AS pkpuntousuario,
    rpu.rpu_fechaentrega AS fechaentrega,
    public.cifrado((usu.pk_usuario || ''::text), 1) AS pkusuario,
    (((((usu.usu_paterno)::text || ' '::text) || (usu.usu_materno)::text) || ' '::text) || (usu.usu_nombre)::text) AS nombrecompleto,
    usu.usu_telefono AS telefono,
    usu.usu_alias AS alias
   FROM ((public.puntoacopio pun
     JOIN public.relpuntousuario rpu ON ((pun.pk_puntoacopio = rpu.fk_pkpuntoacopio)))
     JOIN public.usuario usu ON ((usu.pk_usuario = rpu.fk_pkusuario)))
  WHERE ((pun.pun_estado = 1) AND (rpu.rpu_estado = 1) AND (usu.usu_estado = 1))
  ORDER BY pun.pun_nombre, rpu.rpu_fechaentrega, usu.usu_paterno, usu.usu_materno, usu.usu_nombre;


ALTER VIEW public.listapuntoacopiousuario OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 243
-- Name: VIEW listapuntoacopiousuario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listapuntoacopiousuario IS 'Lista Los los puntos de acopio con los usuarios.';


--
-- TOC entry 241 (class 1259 OID 25394)
-- Name: listaretiro; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listaretiro AS
 SELECT public.cifrado((pk_retiro || ''::text), 1) AS pkretiro,
    ret_fecha AS fecha,
    ret_empresatransporte AS empresatransporte
   FROM public.retiro
  WHERE (ret_estado = 1)
  ORDER BY ret_fecha, ret_empresatransporte;


ALTER VIEW public.listaretiro OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 241
-- Name: VIEW listaretiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listaretiro IS 'Lista Los Retiros';


--
-- TOC entry 225 (class 1259 OID 25224)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    pk_rol bigint NOT NULL,
    rol_descripcion character varying(255) DEFAULT NULL::character varying,
    rol_abreviatura character varying(255) DEFAULT NULL::character varying,
    rol_estado integer DEFAULT 1
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 25398)
-- Name: listarol; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listarol AS
 SELECT public.cifrado((pk_rol || ''::text), 1) AS pkrol,
    rol_abreviatura AS abreviatura,
    rol_descripcion AS descripcion
   FROM public.rol
  WHERE (rol_estado = 1)
  ORDER BY rol_abreviatura, rol_descripcion;


ALTER VIEW public.listarol OWNER TO postgres;

--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 242
-- Name: VIEW listarol; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listarol IS 'Lista Los Roles';


--
-- TOC entry 239 (class 1259 OID 25386)
-- Name: listausuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listausuario AS
 SELECT public.cifrado((pk_usuario || ''::text), 1) AS pkusuario,
    (((((usu_paterno)::text || ' '::text) || (usu_materno)::text) || ' '::text) || (usu_nombre)::text) AS nombrecompleto,
    usu_telefono AS telefono,
    usu_alias AS alias
   FROM public.usuario
  WHERE (usu_estado = 1)
  ORDER BY usu_paterno, usu_materno, usu_nombre;


ALTER VIEW public.listausuario OWNER TO postgres;

--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 239
-- Name: VIEW listausuario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listausuario IS 'Lista Los Usuarios';


--
-- TOC entry 235 (class 1259 OID 25305)
-- Name: relusuariorol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relusuariorol (
    pk_usuariorol bigint NOT NULL,
    rur_estado integer DEFAULT 1,
    fk_pkusuario integer,
    fk_pkrol integer
);


ALTER TABLE public.relusuariorol OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 25407)
-- Name: listausuariorol; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.listausuariorol AS
 SELECT public.cifrado((usu.pk_usuario || ''::text), 1) AS pkusuario,
    (((((usu.usu_paterno)::text || ' '::text) || (usu.usu_materno)::text) || ' '::text) || (usu.usu_nombre)::text) AS nombrecompleto,
    usu.usu_telefono AS telefonousuario,
    usu.usu_alias AS alias,
    public.cifrado((rol.pk_rol || ''::text), 1) AS pkrol,
    rol.rol_abreviatura AS abreviatura,
    rol.rol_descripcion AS descripcion
   FROM ((public.usuario usu
     JOIN public.relusuariorol rur ON ((usu.pk_usuario = rur.fk_pkusuario)))
     JOIN public.rol rol ON ((rol.pk_rol = rur.fk_pkrol)))
  WHERE ((usu.usu_estado = 1) AND (rur.rur_estado = 1) AND (rol.rol_estado = 1))
  ORDER BY usu.usu_paterno, usu.usu_materno, usu.usu_nombre, rol.rol_abreviatura;


ALTER VIEW public.listausuariorol OWNER TO postgres;

--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 244
-- Name: VIEW listausuariorol; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.listausuariorol IS 'Lista Los usuarios con sus roles.';


--
-- TOC entry 226 (class 1259 OID 25235)
-- Name: material_pk_material_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.material ALTER COLUMN pk_material ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.material_pk_material_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 25196)
-- Name: puntoacopio_pk_puntoacopio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.puntoacopio ALTER COLUMN pk_puntoacopio ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.puntoacopio_pk_puntoacopio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 25255)
-- Name: relpuntousuario_pk_puntousuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.relpuntousuario ALTER COLUMN pk_puntousuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.relpuntousuario_pk_puntousuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 25276)
-- Name: relpuntousuariomateriaretiro_pk_puntousuariomateriaretiro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.relpuntousuariomaterialretiro ALTER COLUMN pk_puntousuariomaterialretiro ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.relpuntousuariomateriaretiro_pk_puntousuariomateriaretiro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 25304)
-- Name: relusuariorol_pk_usuariorol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.relusuariorol ALTER COLUMN pk_usuariorol ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.relusuariorol_pk_usuariorol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 25245)
-- Name: retiro_pk_retiro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.retiro ALTER COLUMN pk_retiro ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.retiro_pk_retiro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 25223)
-- Name: rol_pk_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.rol ALTER COLUMN pk_rol ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rol_pk_rol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 25207)
-- Name: usuario_pk_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.usuario ALTER COLUMN pk_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_pk_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4923 (class 2606 OID 25331)
-- Name: clave clave_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clave
    ADD CONSTRAINT clave_pkey PRIMARY KEY (pk_clave);


--
-- TOC entry 4913 (class 2606 OID 25244)
-- Name: material material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_pkey PRIMARY KEY (pk_material);


--
-- TOC entry 4907 (class 2606 OID 25206)
-- Name: puntoacopio puntoacopio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puntoacopio
    ADD CONSTRAINT puntoacopio_pkey PRIMARY KEY (pk_puntoacopio);


--
-- TOC entry 4917 (class 2606 OID 25265)
-- Name: relpuntousuario relpuntousuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relpuntousuario
    ADD CONSTRAINT relpuntousuario_pkey PRIMARY KEY (pk_puntousuario);


--
-- TOC entry 4919 (class 2606 OID 25288)
-- Name: relpuntousuariomaterialretiro relpuntousuariomateriaretiro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relpuntousuariomaterialretiro
    ADD CONSTRAINT relpuntousuariomateriaretiro_pkey PRIMARY KEY (pk_puntousuariomaterialretiro);


--
-- TOC entry 4921 (class 2606 OID 25311)
-- Name: relusuariorol relusuariorol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relusuariorol
    ADD CONSTRAINT relusuariorol_pkey PRIMARY KEY (pk_usuariorol);


--
-- TOC entry 4915 (class 2606 OID 25254)
-- Name: retiro retiro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retiro
    ADD CONSTRAINT retiro_pkey PRIMARY KEY (pk_retiro);


--
-- TOC entry 4911 (class 2606 OID 25234)
-- Name: rol rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (pk_rol);


--
-- TOC entry 4909 (class 2606 OID 25222)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (pk_usuario);


--
-- TOC entry 4924 (class 2606 OID 25266)
-- Name: relpuntousuario relpuntousuario_fk_pkpuntoacopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relpuntousuario
    ADD CONSTRAINT relpuntousuario_fk_pkpuntoacopio_fkey FOREIGN KEY (fk_pkpuntoacopio) REFERENCES public.puntoacopio(pk_puntoacopio) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4925 (class 2606 OID 25271)
-- Name: relpuntousuario relpuntousuario_fk_pkusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relpuntousuario
    ADD CONSTRAINT relpuntousuario_fk_pkusuario_fkey FOREIGN KEY (fk_pkusuario) REFERENCES public.usuario(pk_usuario) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4926 (class 2606 OID 25294)
-- Name: relpuntousuariomaterialretiro relpuntousuariomateriaretiro_fk_pkmaterial_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relpuntousuariomaterialretiro
    ADD CONSTRAINT relpuntousuariomateriaretiro_fk_pkmaterial_fkey FOREIGN KEY (fk_pkmaterial) REFERENCES public.material(pk_material) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4927 (class 2606 OID 25289)
-- Name: relpuntousuariomaterialretiro relpuntousuariomateriaretiro_fk_pkpuntousuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relpuntousuariomaterialretiro
    ADD CONSTRAINT relpuntousuariomateriaretiro_fk_pkpuntousuario_fkey FOREIGN KEY (fk_pkpuntousuario) REFERENCES public.relpuntousuario(pk_puntousuario) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4928 (class 2606 OID 25299)
-- Name: relpuntousuariomaterialretiro relpuntousuariomateriaretiro_fk_pkretiro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relpuntousuariomaterialretiro
    ADD CONSTRAINT relpuntousuariomateriaretiro_fk_pkretiro_fkey FOREIGN KEY (fk_pkretiro) REFERENCES public.retiro(pk_retiro) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4929 (class 2606 OID 25317)
-- Name: relusuariorol relusuariorol_fk_pkrol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relusuariorol
    ADD CONSTRAINT relusuariorol_fk_pkrol_fkey FOREIGN KEY (fk_pkrol) REFERENCES public.rol(pk_rol) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4930 (class 2606 OID 25312)
-- Name: relusuariorol relusuariorol_fk_pkusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relusuariorol
    ADD CONSTRAINT relusuariorol_fk_pkusuario_fkey FOREIGN KEY (fk_pkusuario) REFERENCES public.usuario(pk_usuario) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2026-11-25 22:33:03

--
-- PostgreSQL database dump complete
--

\unrestrict CHD9RlTVgpnJsOzEltFg2mhQEpg0Wq1ssjyXfe4bzbdPmcPFhKUHziSPBt2mKmN

