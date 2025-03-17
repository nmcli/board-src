# 기본 컨테이너 이미지 사용
FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/eap74-openjdk17-openshift-rhel8:latest

WORKDIR /opt/eap

# ✅ 불필요한 환경 변수 제거
# ✅ activemq-rar.rar 삭제만 유지 (필요 없는 JBoss 설정 변경 제거)
RUN rm -f /opt/eap/standalone/deployments/activemq-rar.rar

# ✅ HTTP → HTTPS 리디렉션 제거
RUN sed -i 's/redirect-socket="https"//g' /opt/eap/standalone/configuration/standalone-openshift.xml

# 기존 보안 설정 제거 (security-domain, authentication 설정 비활성화)
RUN sed -i 's/<default-security-domain value="other"\/>//g' /opt/eap/standalone/configuration/standalone-openshift.xml && \
    sed -i '/<security-domain name="ApplicationDomain"/d' /opt/eap/standalone/configuration/standalone-openshift.xml && \
    sed -i '/<application-security-domain name="other"/d' /opt/eap/standalone/configuration/standalone-openshift.xml

COPY target/board-1.0-SNAPSHOT.war /opt/eap/standalone/deployments/

# ✅ 기본 실행 방식 유지 (JBoss EAP 기본 실행 방식 유지)
CMD ["/opt/jboss/container/wildfly/s2i/run.sh"]