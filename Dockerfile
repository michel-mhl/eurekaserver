#Criando o build do projeto automaticamente
FROM maven:3.8.5-openjdk-11 as build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests


FROM openjdk:11

# Define o diretório de trabalho no contêiner
WORKDIR /app
# Copia o jar da aplicação para o diretório de trabalho no contêiner
#COPY ./target/eurekaserver-0.0.1-SNAPSHOT.jar app.jar   --nesse caso copia o jar criado manualmente.

# Copiando o jar da aplicacao que foi gerado automaticamente acima
COPY --from=build ./app/target/*.jar ./app.jar

# Expõe a porta 8761
EXPOSE 8761

# Comando de entrada para executar a aplicação
ENTRYPOINT java -jar app.jar
