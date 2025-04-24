# ---- STAGE 1: Build Site ----
FROM node:alpine AS builder

ARG GIT_DIR="site"

# Install system dependencies for sass
RUN apk add --no-cache libc6-compat

# Set work directory
WORKDIR /app

# Copy everything and install dependencies
COPY ${GIT_DIR} .

RUN npm install
RUN npm run build

# ---- STAGE 2: Serve with Nginx ----
FROM nginx:alpine

COPY --from=builder /app/dist  /usr/share/nginx/html
COPY                nginx.conf /etc/nginx/conf.d/default.conf

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://localhost/ || exit 1

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
