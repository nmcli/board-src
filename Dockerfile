FROM default-route-openshift-image-registry.apps.ext2.mtp.local/registry/pipelines-git-init-rhel8:latest
WORKDIR /app
COPY target/board-1.0-SNAPSHOT.war board.war
CMD ["java", "-jar", "board.war"]
