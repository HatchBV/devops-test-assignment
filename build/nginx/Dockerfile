FROM centos:7

RUN yum clean all && \
    yum install -y epel-release && \
    yum install -y nginx && \
    yum clean all

RUN echo 'daemon off;' >> /etc/nginx/nginx.conf

ENTRYPOINT [ "/usr/sbin/nginx" ]
