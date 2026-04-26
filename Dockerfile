FROM python:3.14-slim-bookworm@sha256:2e256d0381371566ed96980584957ed31297f437569b79b0e5f7e17f2720e53a

RUN apt-get update && apt-get install -y \
    curl \
    nginx \
    supervisor \
    inotify-tools \
    && rm -rf /var/lib/apt/lists/*

# Remove NGINX welcome page
RUN rm -rf /etc/nginx/sites-enabled/default

WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest@sha256:240fb85ab0f263ef12f492d8476aa3a2e4e1e333f7d67fbdd923d00a506a516a /uv /uvx /bin/

# Install deps
ENV UV_SYSTEM_PYTHON=1

COPY pyproject.toml uv.lock ./
RUN uv pip install --no-cache --requirement pyproject.toml
COPY ./mockbook /app/mockbook
RUN uv pip install --no-cache --editable .

COPY . .

ENTRYPOINT ["/app/docker-entrypoint.sh"]

EXPOSE 80 8000 8888
