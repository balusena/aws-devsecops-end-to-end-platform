#FROM            docker.io/nginx
#RUN             rm -rf /usr/share/nginx/html/*
#ADD             ./ /usr/share/nginx/html/
#COPY            nginx.conf /etc/nginx/nginx.conf


FROM            docker.io/redhat/ubi9
RUN             dnf module disable nginx -y && dnf module enable nginx:1.24 -y && dnf install nginx -y && dnf clean all && rm -rf /usr/share/nginx/html/*
ADD             ./ /usr/share/nginx/html/
COPY            nginx.conf /etc/nginx/nginx.conf
USER            nginx
ENTRYPOINT      ["nginx", "-g", "daemon off;", "-e", "/dev/stderr"]
