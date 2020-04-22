\connect "tsundo";

DROP TABLE IF EXISTS "users";
DROP SEQUENCE IF EXISTS users_id_seq;
CREATE SEQUENCE users_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."users" (
    "id" integer DEFAULT nextval('users_id_seq') NOT NULL,
    "username" text NOT NULL,
    "password" text NOT NULL,
    CONSTRAINT "users_id" PRIMARY KEY ("id")
) WITH (oids = false);

COMMENT ON COLUMN "public"."users"."password" IS 'bcrypt hashed with per instance salt';

INSERT INTO "users" ("id", "username", "password") VALUES
(1,	'admin',	'$2a$04$......................Dww1QeqjiwOTM3OaQI8W.VyN3/1Ur.i');
