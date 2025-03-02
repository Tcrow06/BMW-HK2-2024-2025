FROM tomcat:8.5-jdk21
COPY target/FashionWebEcommerce.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
# Chạy ứng dụng với Java
CMD ["catalina.sh", "run"]

