\connect "tsundo";

CREATE TABLE public.authors
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT authors_pkey PRIMARY KEY (id)
);

ALTER TABLE public.authors OWNER to tsundo;
