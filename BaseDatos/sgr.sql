--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.0
-- Dumped by pg_dump version 9.4.0
-- Started on 2026-11-19 01:42:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 173 (class 3079 OID 11638)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1931 (class 0 OID 0)
-- Dependencies: 173
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 164 (class 1259 OID 60217)
-- Name: material; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE material (
    pk_material integer NOT NULL,
    mat_tipo integer DEFAULT 0,
    mat_descripcion character varying(255) DEFAULT NULL::character varying,
    mat_estado integer DEFAULT 0
);


ALTER TABLE material OWNER TO postgres;

--
-- TOC entry 163 (class 1259 OID 60215)
-- Name: material_pk_material_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE material_pk_material_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE material_pk_material_seq OWNER TO postgres;

--
-- TOC entry 1932 (class 0 OID 0)
-- Dependencies: 163
-- Name: material_pk_material_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE material_pk_material_seq OWNED BY material.pk_material;


--
-- TOC entry 162 (class 1259 OID 60202)
-- Name: puntoacopio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE puntoacopio (
    pk_puntoacopio integer NOT NULL,
    pun_nombre character varying(255) DEFAULT NULL::character varying,
    pun_direccion character varying(255) DEFAULT NULL::character varying,
    pun_telefono character varying(255) DEFAULT NULL::character varying,
    pun_estado integer DEFAULT 0
);


ALTER TABLE puntoacopio OWNER TO postgres;

--
-- TOC entry 161 (class 1259 OID 60200)
-- Name: puntoacopio_pk_puntoacopio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE puntoacopio_pk_puntoacopio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE puntoacopio_pk_puntoacopio_seq OWNER TO postgres;

--
-- TOC entry 1933 (class 0 OID 0)
-- Dependencies: 161
-- Name: puntoacopio_pk_puntoacopio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE puntoacopio_pk_puntoacopio_seq OWNED BY puntoacopio.pk_puntoacopio;


--
-- TOC entry 172 (class 1259 OID 60273)
-- Name: relentregamateriaretiro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE relentregamateriaretiro (
    pk_entregamateriaretiro integer NOT NULL,
    enr_peso integer DEFAULT 0,
    ent_tipo integer DEFAULT 0,
    fk_pkpuntoresponsable integer DEFAULT 0,
    fk_pkmaterial integer DEFAULT 0,
    fk_pkretiro integer DEFAULT 0,
    enr_estado integer DEFAULT 0
);


ALTER TABLE relentregamateriaretiro OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 60271)
-- Name: relentregamateriaretiro_pk_entregamateriaretiro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE relentregamateriaretiro_pk_entregamateriaretiro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE relentregamateriaretiro_pk_entregamateriaretiro_seq OWNER TO postgres;

--
-- TOC entry 1934 (class 0 OID 0)
-- Dependencies: 171
-- Name: relentregamateriaretiro_pk_entregamateriaretiro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE relentregamateriaretiro_pk_entregamateriaretiro_seq OWNED BY relentregamateriaretiro.pk_entregamateriaretiro;


--
-- TOC entry 168 (class 1259 OID 60242)
-- Name: relpuntoresponsable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE relpuntoresponsable (
    pk_puntoresponsable integer NOT NULL,
    rpr_fechaentrega timestamp without time zone,
    fk_pkpuntoacopio integer DEFAULT 0,
    fk_pkresponsable integer DEFAULT 0,
    rpr_estado integer DEFAULT 0
);


ALTER TABLE relpuntoresponsable OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 60240)
-- Name: relpuntoresponsable_pk_puntoresponsable_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE relpuntoresponsable_pk_puntoresponsable_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE relpuntoresponsable_pk_puntoresponsable_seq OWNER TO postgres;

--
-- TOC entry 1935 (class 0 OID 0)
-- Dependencies: 167
-- Name: relpuntoresponsable_pk_puntoresponsable_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE relpuntoresponsable_pk_puntoresponsable_seq OWNED BY relpuntoresponsable.pk_puntoresponsable;


--
-- TOC entry 166 (class 1259 OID 60228)
-- Name: responsable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE responsable (
    pk_responsable integer NOT NULL,
    res_nombre character varying(255) DEFAULT NULL::character varying,
    res_telefono character varying(255) DEFAULT NULL::character varying,
    res_estado integer DEFAULT 0
);


ALTER TABLE responsable OWNER TO postgres;

--
-- TOC entry 165 (class 1259 OID 60226)
-- Name: responsable_pk_responsable_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE responsable_pk_responsable_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE responsable_pk_responsable_seq OWNER TO postgres;

--
-- TOC entry 1936 (class 0 OID 0)
-- Dependencies: 165
-- Name: responsable_pk_responsable_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE responsable_pk_responsable_seq OWNED BY responsable.pk_responsable;


--
-- TOC entry 170 (class 1259 OID 60263)
-- Name: retiro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE retiro (
    pk_retiro integer NOT NULL,
    ret_fecha timestamp without time zone,
    ret_empresatransporte character varying(255) DEFAULT NULL::character varying,
    ret_estado integer DEFAULT 0
);


ALTER TABLE retiro OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 60261)
-- Name: retiro_pk_retiro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE retiro_pk_retiro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE retiro_pk_retiro_seq OWNER TO postgres;

--
-- TOC entry 1937 (class 0 OID 0)
-- Dependencies: 169
-- Name: retiro_pk_retiro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE retiro_pk_retiro_seq OWNED BY retiro.pk_retiro;


--
-- TOC entry 1784 (class 2604 OID 60220)
-- Name: pk_material; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY material ALTER COLUMN pk_material SET DEFAULT nextval('material_pk_material_seq'::regclass);


--
-- TOC entry 1779 (class 2604 OID 60205)
-- Name: pk_puntoacopio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY puntoacopio ALTER COLUMN pk_puntoacopio SET DEFAULT nextval('puntoacopio_pk_puntoacopio_seq'::regclass);


--
-- TOC entry 1799 (class 2604 OID 60276)
-- Name: pk_entregamateriaretiro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relentregamateriaretiro ALTER COLUMN pk_entregamateriaretiro SET DEFAULT nextval('relentregamateriaretiro_pk_entregamateriaretiro_seq'::regclass);


--
-- TOC entry 1792 (class 2604 OID 60245)
-- Name: pk_puntoresponsable; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relpuntoresponsable ALTER COLUMN pk_puntoresponsable SET DEFAULT nextval('relpuntoresponsable_pk_puntoresponsable_seq'::regclass);


--
-- TOC entry 1788 (class 2604 OID 60231)
-- Name: pk_responsable; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY responsable ALTER COLUMN pk_responsable SET DEFAULT nextval('responsable_pk_responsable_seq'::regclass);


--
-- TOC entry 1796 (class 2604 OID 60266)
-- Name: pk_retiro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY retiro ALTER COLUMN pk_retiro SET DEFAULT nextval('retiro_pk_retiro_seq'::regclass);


--
-- TOC entry 1809 (class 2606 OID 60225)
-- Name: material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY material
    ADD CONSTRAINT material_pkey PRIMARY KEY (pk_material);


--
-- TOC entry 1807 (class 2606 OID 60214)
-- Name: puntoacopio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY puntoacopio
    ADD CONSTRAINT puntoacopio_pkey PRIMARY KEY (pk_puntoacopio);


--
-- TOC entry 1817 (class 2606 OID 60284)
-- Name: relentregamateriaretiro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY relentregamateriaretiro
    ADD CONSTRAINT relentregamateriaretiro_pkey PRIMARY KEY (pk_entregamateriaretiro);


--
-- TOC entry 1813 (class 2606 OID 60250)
-- Name: relpuntoresponsable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY relpuntoresponsable
    ADD CONSTRAINT relpuntoresponsable_pkey PRIMARY KEY (pk_puntoresponsable);


--
-- TOC entry 1811 (class 2606 OID 60239)
-- Name: responsable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT responsable_pkey PRIMARY KEY (pk_responsable);


--
-- TOC entry 1815 (class 2606 OID 60270)
-- Name: retiro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY retiro
    ADD CONSTRAINT retiro_pkey PRIMARY KEY (pk_retiro);


--
-- TOC entry 1820 (class 2606 OID 60285)
-- Name: relentregamateriaretiro_fk_pkmaterial_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relentregamateriaretiro
    ADD CONSTRAINT relentregamateriaretiro_fk_pkmaterial_fkey FOREIGN KEY (fk_pkmaterial) REFERENCES material(pk_material) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 1821 (class 2606 OID 60290)
-- Name: relentregamateriaretiro_fk_pkpuntoresponsable_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relentregamateriaretiro
    ADD CONSTRAINT relentregamateriaretiro_fk_pkpuntoresponsable_fkey FOREIGN KEY (fk_pkpuntoresponsable) REFERENCES relpuntoresponsable(pk_puntoresponsable) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 1822 (class 2606 OID 60295)
-- Name: relentregamateriaretiro_fk_pkretiro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relentregamateriaretiro
    ADD CONSTRAINT relentregamateriaretiro_fk_pkretiro_fkey FOREIGN KEY (fk_pkretiro) REFERENCES retiro(pk_retiro) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 1818 (class 2606 OID 60251)
-- Name: relpuntoresponsable_fk_pkpuntoacopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relpuntoresponsable
    ADD CONSTRAINT relpuntoresponsable_fk_pkpuntoacopio_fkey FOREIGN KEY (fk_pkpuntoacopio) REFERENCES puntoacopio(pk_puntoacopio) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 1819 (class 2606 OID 60256)
-- Name: relpuntoresponsable_fk_pkresponsable_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relpuntoresponsable
    ADD CONSTRAINT relpuntoresponsable_fk_pkresponsable_fkey FOREIGN KEY (fk_pkresponsable) REFERENCES responsable(pk_responsable) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 1930 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2026-11-19 01:42:33

--
-- PostgreSQL database dump complete
--

