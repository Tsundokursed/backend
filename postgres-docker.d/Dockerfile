FROM postgres

ARG initfiledir=/docker-entrypoint-initdb.d

RUN mkdir -p $initfiledir
COPY ./sql/* $initfiledir