# Используем базовый образ с Ubuntu
FROM ubuntu:20.04

# Установка переменной окружения для версии Liquibase
ENV LIQUIBASE_VERSION=4.29.0

# Установка необходимых пакетов
RUN apt-get update && \
    apt-get install -y wget unzip openjdk-11-jre

# Установка рабочей директории
WORKDIR /liquibase

# Загрузка и распаковка Liquibase
RUN wget https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip && \
    unzip liquibase-${LIQUIBASE_VERSION}.zip && \
    rm liquibase-${LIQUIBASE_VERSION}.zip && \
    mv liquibase-${LIQUIBASE_VERSION} /opt/liquibase && \
    ln -s /opt/liquibase/liquibase /usr/local/bin/liquibase && \
    ln -s /opt/liquibase/internal/lib/liquibase-core.jar /usr/local/bin/liquibase-core.jar
	



# Загрузка драйвера PostgreSQL
RUN wget https://jdbc.postgresql.org/download/postgresql-42.6.2.jar -P /usr/local/lib/

# Копирование скриптов Liquibase
COPY ./changelogs /liquibase/changelogs
COPY liquibase.properties /liquibase/liquibase.properties



# Установка точки входа
ENTRYPOINT ["liquibase"]

# Установка команды по умолчанию 
CMD ["--defaultsFile=/liquibase/liquibase.properties", "update"]