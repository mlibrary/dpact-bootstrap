FROM bitnami/apache

### Change user to perform privileged actions
USER 0
### Install 'vim'
RUN install_packages vim
### Revert to the original non-root user
USER 1001

RUN echo 'IncludeOptional "/opt/bitnami/apache/conf/m1/m1.conf"' >> /opt/bitnami/apache/conf/httpd.conf

COPY m1 /opt/bitnami/apache/conf/m1

COPY app /app
