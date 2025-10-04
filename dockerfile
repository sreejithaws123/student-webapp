from maven:3.9.11-amazoncorretto-17
run yum install -y wget
run wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.109/bin/apache-tomcat-9.0.109.tar.gz && tar -xzvf apache-tomcat-9.0.109.tar.gz && mv apache-tomcat-9.0.109 /usr/local/tomcat
workdir /app
copy . .
run mvn clean package
run cp target/student-reg-webapp.war /usr/local/tomcat/webapps
from alpine
env home=/usr/local/tomcat
label maintainer="Sreejith"
label email="sreejithaws123@gmail.com"
run apk add --no-cache openjdk17
copy --from=0 ${home} ${home}
run adduser tomcat -h ${home} -D -s /bin/sh && chown -R tomcat:tomcat ${home} && chmod -R 755 ${home}
user tomcat
entrypoint ["/usr/local/tomcat/bin/catalina.sh"]
cmd ["run"]
