FROM bitnami/apache

ARG UNAME=dpact
ARG UID=1001
ARG GID=1001

### Change user to perform privileged actions
USER 0

### Install 'vim' and 'build-essential'
RUN install_packages vim build-essential

### Add Group and User
RUN groupadd -g ${GID} -o ${UNAME}
RUN useradd -m -d /${UNAME} -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}

### Append m1.conf include to httpd.conf
RUN echo 'IncludeOptional "/opt/bitnami/apache/conf/m1/m1.conf"' >> /opt/bitnami/apache/conf/httpd.conf

### Copy m1.conf
COPY m1 /opt/bitnami/apache/conf/m1

### Append mlibrary.conf include to httpd.conf
RUN echo 'Include "/opt/bitnami/apache/conf/mlibrary/mlibrary.conf"' >> /opt/bitnami/apache/conf/httpd.conf

### Copy mlibrary.conf
COPY mlibrary /opt/bitnami/apache/conf/mlibrary

### Copy mod_authz_umichlib.so
COPY modules/authz_umichlib/.libs/mod_authz_umichlib.so /opt/bitnami/apache/modules/mod_authz_umichlib.so

### Revert to the original non-root user
USER ${UID}

WORKDIR /${UNAME}

CMD ["tail", "-f", "/dev/null"]
