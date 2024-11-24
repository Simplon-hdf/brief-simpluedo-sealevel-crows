--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.2)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ajout_objet(character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.ajout_objet(IN nom_objets character varying, IN id_salles integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO objets (nom_objets, id_salles) VALUES (nom_objets, id_salles);
END;
$$;


ALTER PROCEDURE public.ajout_objet(IN nom_objets character varying, IN id_salles integer) OWNER TO postgres;

--
-- Name: ajout_objet(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.ajout_objet(IN var_nom_objets character varying, IN var_nom_salles character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insérer directement l'objet en liant la salle par son nom
    INSERT INTO objets (nom_objets, id_salles)
    SELECT var_nom_objets, salles.id_salles
    FROM salles
    WHERE salles.nom_salles = var_nom_salles;

    -- Vérification si aucune salle ne correspond
    IF NOT FOUND THEN
        RAISE EXCEPTION 'La salle "%" n''existe pas.', var_nom_salles;
    END IF;
END;
$$;


ALTER PROCEDURE public.ajout_objet(IN var_nom_objets character varying, IN var_nom_salles character varying) OWNER TO postgres;

--
-- Name: lister_objet(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.lister_objet(nom_salle character varying) RETURNS TABLE(nom_objets character varying)
    LANGUAGE sql
    AS $$
    SELECT nom_objets
    FROM objets
    INNER JOIN salles ON salles.id_salles = objets.id_salles
    WHERE nom_salles = nom_salle;
 $$;


ALTER FUNCTION public.lister_objet(nom_salle character varying) OWNER TO postgres;

--
-- Name: maj_position_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.maj_position_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Complète l'heure de sortie dans visiter
    UPDATE visiter
    SET heure_sortie = NEW.heure_arrivee
    WHERE id_personnages = NEW.id_personnages
      AND heure_sortie IS NULL;

    -- Met à jour ou insère dans position
    INSERT INTO position (id_personnages, id_salles, heure_arrivee)
    VALUES (NEW.id_personnages, NEW.id_salles, NEW.heure_arrivee)
    ON CONFLICT (id_personnages)
    DO UPDATE SET id_salles = EXCLUDED.id_salles, heure_arrivee = EXCLUDED.heure_arrivee;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.maj_position_trigger() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: objets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.objets (
    id_objets integer NOT NULL,
    nom_objets character varying(50) NOT NULL,
    id_salles integer
);


ALTER TABLE public.objets OWNER TO postgres;

--
-- Name: objets_id_objets_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.objets ALTER COLUMN id_objets ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.objets_id_objets_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: personnages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personnages (
    id_personnages integer NOT NULL,
    nom_personnages character varying(50) NOT NULL
);


ALTER TABLE public.personnages OWNER TO postgres;

--
-- Name: personnages_id_personnages_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.personnages ALTER COLUMN id_personnages ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personnages_id_personnages_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."position" (
    id_personnages integer NOT NULL,
    id_salles integer NOT NULL,
    heure_arrivee time without time zone NOT NULL
);


ALTER TABLE public."position" OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_roles integer NOT NULL,
    nom_roles character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_roles_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ALTER COLUMN id_roles ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.roles_id_roles_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: salles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salles (
    id_salles integer NOT NULL,
    nom_salles character varying(50) NOT NULL
);


ALTER TABLE public.salles OWNER TO postgres;

--
-- Name: salles_id_salles_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.salles ALTER COLUMN id_salles ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.salles_id_salles_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateurs (
    uuid_utilisateurs uuid DEFAULT gen_random_uuid() NOT NULL,
    pseudo_utilisateurs character varying(50) NOT NULL,
    id_roles integer,
    id_personnages integer
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- Name: visiter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visiter (
    id_personnages integer NOT NULL,
    id_salles integer NOT NULL,
    heure_arrivee time without time zone NOT NULL,
    heure_sortie time without time zone
);


ALTER TABLE public.visiter OWNER TO postgres;

--
-- Data for Name: objets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.objets (id_objets, nom_objets, id_salles) FROM stdin;
1	Poignard	4
2	Revolver	6
3	Chandelier	5
4	Corde	4
5	Clé anglaise	8
6	Matraque	8
7	Fusil à pompe	9
8	Fusil à pompe	4
\.


--
-- Data for Name: personnages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personnages (id_personnages, nom_personnages) FROM stdin;
1	Colonel Moutarde
2	Docteur OLIVE
3	Professeur VIOLET
4	Madame PERVENCHE
5	Mademoiselle ROSE
6	Madame LEBLANC
\.


--
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."position" (id_personnages, id_salles, heure_arrivee) FROM stdin;
1	3	10:30:00
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id_roles, nom_roles) FROM stdin;
1	observateur
2	utilisateur
3	maitre du jeu
\.


--
-- Data for Name: salles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salles (id_salles, nom_salles) FROM stdin;
1	Cuisine
2	Grand Salon
3	Petit Salon
4	Bureau
5	Bibliothèque
6	Studio
7	Hall
8	Véranda
9	Salle à manger
\.


--
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateurs (uuid_utilisateurs, pseudo_utilisateurs, id_roles, id_personnages) FROM stdin;
c8a93b39-7867-432e-be6c-d3488c883317	MessaKami	3	1
ffddc981-9453-4a6d-a4a9-d0e49cc0889b	GETAMAZIGHT	2	3
0c2caa8b-9713-4fc4-98bd-b4eaa3cf15b5	Srekaens	2	2
d0a6d4f9-1b30-46cd-8ec4-b8e13b079728	Kuro	2	5
92656978-f097-40cd-af2f-78117a46b47c	Shotax	2	6
314eb5c7-e22d-4dd7-8d4f-09dc653b66fe	Jegoro	2	4
b651abc4-ae7b-4ee4-814e-13a4ba47f50e	Martial	1	\N
1befb624-1123-4e91-a252-c05f5337e0a6	Aurore	1	\N
e1a99c1e-9ba2-48ef-badd-cc497bd746cf	Julien	1	\N
e7d3bd98-b9ae-4531-9f1a-b512e771f5a7	Boris	1	\N
d9b339c4-64c2-46a4-8477-575762218828	Gabriel	1	\N
03cd35b9-b91e-4314-a5fb-542710eb1797	Yohan	1	\N
626ddc0e-14ca-44ac-8480-3ed0c4bd2211	Franck	1	\N
\.


--
-- Data for Name: visiter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visiter (id_personnages, id_salles, heure_arrivee, heure_sortie) FROM stdin;
1	2	08:30:00	09:00:00
1	2	09:30:00	09:30:00
1	3	10:30:00	10:30:00
\.


--
-- Name: objets_id_objets_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.objets_id_objets_seq', 8, true);


--
-- Name: personnages_id_personnages_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personnages_id_personnages_seq', 6, true);


--
-- Name: roles_id_roles_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_roles_seq', 3, true);


--
-- Name: salles_id_salles_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salles_id_salles_seq', 9, true);


--
-- Name: objets objets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.objets
    ADD CONSTRAINT objets_pkey PRIMARY KEY (id_objets);


--
-- Name: personnages personnages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personnages
    ADD CONSTRAINT personnages_pkey PRIMARY KEY (id_personnages);


--
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (id_personnages);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_roles);


--
-- Name: salles salles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salles
    ADD CONSTRAINT salles_pkey PRIMARY KEY (id_salles);


--
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (uuid_utilisateurs);


--
-- Name: visiter visiter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT visiter_pkey PRIMARY KEY (id_personnages, id_salles, heure_arrivee);


--
-- Name: visiter trigger_maj_position; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_maj_position AFTER INSERT OR UPDATE ON public.visiter FOR EACH ROW EXECUTE FUNCTION public.maj_position_trigger();


--
-- Name: objets objets_id_salles_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.objets
    ADD CONSTRAINT objets_id_salles_fkey FOREIGN KEY (id_salles) REFERENCES public.salles(id_salles);


--
-- Name: position position_id_personnages_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_id_personnages_fkey FOREIGN KEY (id_personnages) REFERENCES public.personnages(id_personnages);


--
-- Name: position position_id_salles_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_id_salles_fkey FOREIGN KEY (id_salles) REFERENCES public.salles(id_salles);


--
-- Name: utilisateurs utilisateurs_id_personnages_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_id_personnages_fkey FOREIGN KEY (id_personnages) REFERENCES public.personnages(id_personnages);


--
-- Name: utilisateurs utilisateurs_id_roles_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_id_roles_fkey FOREIGN KEY (id_roles) REFERENCES public.roles(id_roles);


--
-- Name: visiter visiter_id_personnages_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT visiter_id_personnages_fkey FOREIGN KEY (id_personnages) REFERENCES public.personnages(id_personnages);


--
-- Name: visiter visiter_id_salles_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT visiter_id_salles_fkey FOREIGN KEY (id_salles) REFERENCES public.salles(id_salles);


--
-- Name: TABLE objets; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.objets TO simpluedo_admin;


--
-- Name: TABLE personnages; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.personnages TO simpluedo_admin;


--
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.roles TO simpluedo_admin;


--
-- Name: TABLE salles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.salles TO simpluedo_admin;


--
-- Name: TABLE utilisateurs; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.utilisateurs TO simpluedo_admin;


--
-- Name: TABLE visiter; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.visiter TO simpluedo_admin;


--
-- PostgreSQL database dump complete
--

