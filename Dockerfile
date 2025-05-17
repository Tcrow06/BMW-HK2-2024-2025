# Stage 1: Build WAR
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Setup Tomcat
FROM tomcat:8.5-jdk21

# Cài đặt MySQL client tools
RUN apt-get update && \
    apt-get install -y mariadb-client && \
    apt-get install -y dos2unix bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/target/FashionWebEcommerce.war /usr/local/tomcat/webapps/ROOT.war

COPY generate-keystore.sh /tmp/generate-keystore.sh

RUN dos2unix /tmp/generate-keystore.sh && \
    chmod +x /tmp/generate-keystore.sh && \
    bash /tmp/generate-keystore.sh

COPY server.xml /usr/local/tomcat/conf/server.xml

EXPOSE 8080 8443

COPY wait-for-mysql.sh /wait-for-mysql.sh
RUN chmod +x /wait-for-mysql.sh

CMD ["/wait-for-mysql.sh", "catalina.sh", "run"]