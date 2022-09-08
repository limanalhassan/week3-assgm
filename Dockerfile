FROM tomee
WORKDIR /usr/local/tomee/
COPY ./*.war /usr/local/tomee/webapps/
EXPOSE 8080
