# 기본 컨테이너 이미지 사용
FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/eap74-openjdk17-openshift-rhel8:latest

WORKDIR /opt/eap

# ✅ 불필요한 환경 변수 제거
# ✅ activemq-rar.rar 삭제만 유지 (필요 없는 JBoss 설정 변경 제거)
RUN rm -f /opt/eap/standalone/deployments/activemq-rar.rar

# ✅ HTTP → HTTPS 리디렉션 제거
RUN sed -i 's/redirect-socket="https"//g' /opt/eap/standalone/configuration/standalone-openshift.xml

COPY target/board-app.war /opt/eap/standalone/deployments/

# ✅ 기본 실행 방식 유지 (JBoss EAP 기본 실행 방식 유지)
CMD ["/opt/jboss/container/wildfly/s2i/run.sh"]