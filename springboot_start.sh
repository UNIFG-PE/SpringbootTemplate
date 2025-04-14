#!/bin/bash

# Nome do projeto vindo como argumento
PROJECT_NAME=$1

# Verifica se foi passado o nome
if [ -z "$PROJECT_NAME" ]; then
  echo "Uso: $0 nome-do-projeto"
  exit 1
fi

DEPENDENCIES="web,lombok,postgresql,data-jpa,flyway,docker-compose,hateoas,devtools,security,websocket,validation"

SPRING_BOOT_VERSION="3.4.4"

curl -G https://start.spring.io/starter.zip \
  --data-urlencode "dependencies=$DEPENDENCIES" \
  --data-urlencode "type=maven-project" \
  --data-urlencode "language=java" \
  --data-urlencode "bootVersion=$SPRING_BOOT_VERSION" \
  --data-urlencode "baseDir=$PROJECT_NAME" \
  -o "$PROJECT_NAME.zip"

if [ $? -ne 0 ] || [ ! -s "$PROJECT_NAME.zip" ]; then
  echo "❌ Falha ao baixar o projeto Spring Boot."
  exit 1
fi

unzip "$PROJECT_NAME.zip" > /dev/null

rm "$PROJECT_NAME.zip"

echo "✅ Projeto '$PROJECT_NAME' criado com sucesso!"

cd "./$PROJECT_NAME"

git init