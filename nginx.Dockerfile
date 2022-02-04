FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils
ENV RAILS_ROOT /app
WORKDIR $RAILS_ROOT
RUN mkdir log

#this is not needed for this app
COPY public public/

COPY nginx.conf /tmp/docker.nginx

#this line below i dont understand
#i know we have to get rid of conf.d/default.conf
# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
