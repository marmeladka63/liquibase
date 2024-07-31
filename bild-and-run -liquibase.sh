#!/bin/bash

#Создание директории
mkdir -p changelogs

#Создание образа liquibase
docker build -t my-liquibase .

# Генерация changelog
docker run --rm -v $(pwd):/liquibase -w /liquibase my-liquibase-image \
    generateChangeLog --changeLogFile=changelogs/dbchangelog.xml
