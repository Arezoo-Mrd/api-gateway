FROM nginxinc/nginx-unprivileged:1.27-alpine

# Copy static files
COPY free-api-gateway-guide.html /usr/share/nginx/html/index.html
COPY free-api-gateway-guide.html /usr/share/nginx/html/free-api-gateway-guide.html

# Copy nginx config (port 8080, /tmp writes — OpenShift safe)
COPY nginx.conf /etc/nginx/nginx.conf

# OpenShift runs as random non-root UID — fix permissions
USER 0
RUN chmod -R 755 /usr/share/nginx/html \
 && chown -R nginx:0 /usr/share/nginx/html \
 && chmod -R g+rwX /usr/share/nginx/html
USER 1001

EXPOSE 8080