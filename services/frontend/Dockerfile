FROM nginx:alpine

# copy our simple HTML app
COPY src/index.html /usr/share/nginx/html/index.html

# copy custom nginx config (routes /api/* to backend services)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]