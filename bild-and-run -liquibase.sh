#!/bin/bash
docker build -t my-liquibase .
mkdir -p changelogs
docker run --rm \
    -v $(pwd)/changelogs:/liquibase/changelogs \
    my-liquibase \
    --url=jdbc:postgresql://localhost:5432/etlop \
    --username=user \
    --password=1234 \
    --changeLogFile=/liquibase/changelogs/dbchangelog.xml \
    generateChangeLog