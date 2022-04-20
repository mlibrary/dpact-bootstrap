FROM bitnami/apache

### Change user to perform privileged actions
USER 0

### Install 'vim'
RUN install_packages vim

### Append mlibrary.conf include to httpd.conf
RUN echo 'Include "/opt/bitnami/apache/conf/mlibrary/mlibrary.conf"' >> /opt/bitnami/apache/conf/httpd.conf

### Copy mlibrary.conf
COPY mlibrary /opt/bitnami/apache/conf/mlibrary

### Copy mod_authz_umichlib.so
COPY modules/mod_authz_umichlib.so /opt/bitnami/apache/modules/mod_authz_umichlib.so

### Copy web
COPY app /app

### Revert to the original non-root user
USER 1001