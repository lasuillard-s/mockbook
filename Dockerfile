FROM python:3.14-slim-trixie@sha256:44dd04494ee8f3b538294360e7c4b3acb87c8268e4d0a4828a6500b1eff50061

RUN apt-get update && apt-get install -y \
    curl \
    nginx \
    supervisor \
    inotify-tools \
    && rm --recursive --force /var/lib/apt/lists/*

# Remove NGINX welcome page
RUN rm --recursive --force /etc/nginx/sites-enabled/default

WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.11.17@sha256:03bdc89bb9798628846e60c3a9ad19006c8c3c724ccd2985a33145c039a0577b /uv /uvx /bin/

# Install deps
ENV UV_SYSTEM_PYTHON=1

COPY pyproject.toml uv.lock ./
RUN uv pip install --no-cache --requirement pyproject.toml
COPY ./mockbook /app/mockbook
RUN uv pip install --no-cache --editable .

COPY . .

ENTRYPOINT ["/app/docker-entrypoint.sh"]

EXPOSE 80 8000 8888
