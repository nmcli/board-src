# 기존 Tekton Git Clone 이미지 기반
FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/eap74-openjdk17-openshift-rhel8:latest
WORKDIR /opt/jboss
RUN ls -l /opt/jboss/container/wildfly/s2i/

# ✅ 2️⃣ JBoss 실행 파일이 존재하는지 확인 (디버깅용)
RUN echo "Checking JBoss files..." && ls -l /opt/jboss/wildfly/bin/ || echo "JBoss EAP is missing!"

# ✅ 3️⃣ 소스 코드 복사 (애플리케이션 코드가 있을 경우)
COPY . /opt/eap/

# ✅ 4️⃣ OpenShift S2I 빌드 프로세스 실행 (assemble 단계 수행)
RUN /opt/jboss/container/wildfly/s2i/assemble.sh

# ✅ 5️⃣ JBoss 실행 파일이 유지되는지 다시 확인 (디버깅)
RUN echo "Post-assemble check" && ls -l /opt/jboss/wildfly/bin/

# ✅ 6️⃣ 컨테이너 실행 시 OpenShift용 `run.sh` 실행
CMD ["/bin/sh", "-c", "/opt/jboss/container/wildfly/s2i/run.sh"]