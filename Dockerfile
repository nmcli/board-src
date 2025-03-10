#FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/pipelines-git-init-rhel8:latest
#WORKDIR /app
#COPY target/board-1.0-SNAPSHOT.war board.war
#CMD ["java", "-jar", "board.war"]

# 기존 Tekton Git Clone 이미지 기반
#FROM image-registry.openshift-image-registry.svc:5000/registry/pipelines-git-init-rhel8:latest
FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/pipelines-git-init-rhel8:latest

# root에서 NFS 권한을 설정 (nobody 권한 부여)
USER root
RUN mkdir -p /workspace/output && \
    chown -R nobody:nobody /workspace/output && \
    chmod -R 777 /workspace/output

# 다시 nobody 사용자로 실행
USER nobody

# 작업 디렉토리 설정
WORKDIR /workspace/output

# 기본 실행 명령어 유지
ENTRYPOINT ["/ko-app/git-init"]
