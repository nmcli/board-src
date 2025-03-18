FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/eap74-openjdk17-openshift-rhel8:latest

WORKDIR /opt/eap

# 불필요한 기본 환경 변수 제거 및 ActiveMQ RAR 커넥터 삭제
RUN rm -f /opt/eap/standalone/deployments/activemq-rar.rar

# 불필요한 보안 설정 제거
RUN sed -i 's/default-security-domain="other"//g' /opt/eap/standalone/configuration/standalone-openshift.xml
RUN sed -i '/<security-domain name="ApplicationDomain"/d' /opt/eap/standalone/configuration/standalone-openshift.xml
RUN sed -i '/<application-security-domains>/,/<\/application-security-domains>/d' /opt/eap/standalone/configuration/standalone-openshift.xml

# 애플리케이션 WAR 파일 복사하여 배포
COPY target/board-1.0-SNAPSHOT.war /opt/eap/standalone/deployments/

# 기본 실행 명령 유지 (JBoss EAP 서버 기동)
CMD ["/opt/jboss/container/wildfly/s2i/run.sh"]
