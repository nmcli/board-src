# 기존 Tekton Git Clone 이미지 기반
FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/eap74-openjdk17-openshift-rhel8:latest

WORKDIR /opt/eap

# ✅ JBoss 실행 파일이 있는지 확인
RUN ls -l /opt/eap/bin/ || echo "JBoss is missing!"

EXPOSE 8080

# ✅ 컨테이너 실행 시 `/opt/eap/bin/standalone.sh` 실행
CMD ["/bin/sh", "-c", "/opt/jboss/container/wildfly/s2i/run.sh"]
#CMD ["/bin/sh", "-c", "/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0"]