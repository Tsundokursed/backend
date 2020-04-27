\connect "tsundo";

CREATE TABLE public.users
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    username text COLLATE pg_catalog."default" NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_id PRIMARY KEY (id),
    CONSTRAINT users_username_unique UNIQUE (username)
);

ALTER TABLE public.users OWNER to tsundo;
