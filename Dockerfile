FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/eap74-openjdk17-openshift-rhel8:latest

WORKDIR /opt/eap

# 불필요한 환경 변수 제거 및 ActiveMQ RAR 삭제
RUN rm -f /opt/eap/standalone/deployments/activemq-rar.rar

# ✅ JBoss 보안 도메인 수정
RUN sed -i 's/default-security-domain="other"//g' /opt/eap/standalone/configuration/standalone-openshift.xml
RUN sed -i '/<security-domain name="ApplicationDomain"/d' /opt/eap/standalone/configuration/standalone-openshift.xml
RUN sed -i '/<application-security-domain name="other"/d' /opt/eap/standalone/configuration/standalone-openshift.xml

# ✅ `application-security-domains`가 비어있지 않도록 필수 요소 추가
RUN sed -i '/<application-security-domains>/a\ \ \ \ <application-security-domain name="other" security-domain="ApplicationDomain"/>' /opt/eap/standalone/configuration/standalone-openshift.xml

# ✅ HTTPS 리디렉션 제거
RUN sed -i 's/redirect-socket="https"//g' /opt/eap/standalone/configuration/standalone-openshift.xml

# `.war` 파일 복사
COPY target/board-1.0-SNAPSHOT.war /opt/eap/standalone/deployments/

# JBoss 기본 실행 방식 유지
CMD ["/opt/jboss/container/wildfly/s2i/run.sh"]
