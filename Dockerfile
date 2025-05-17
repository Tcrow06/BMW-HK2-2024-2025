FROM tomcat:8.5-jdk21

# Copy war file ứng dụng
COPY target/FashionWebEcommerce.war /usr/local/tomcat/webapps/ROOT.war

# Copy script tạo keystore
COPY generate-keystore.sh /tmp/generate-keystore.sh

# Cấp quyền chạy cho script
RUN chmod +x /tmp/generate-keystore.sh

# Chạy script tạo keystore
RUN /tmp/generate-keystore.sh

# Copy server.xml cấu hình ssl (server.xml bạn chuẩn bị sẵn, dùng keystore ở /usr/local/tomcat/ssl/keystore.p12)
COPY server.xml /usr/local/tomcat/conf/server.xml

EXPOSE 8080 8443


CMD ["catalina.sh", "run"]
