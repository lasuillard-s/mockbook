FROM python:3.14-slim-bookworm@sha256:f21c0d5a44c56805654c15abccc1b2fd576c8d93aca0a3f74b4aba2dc92510e2

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
COPY --from=ghcr.io/astral-sh/uv:latest@sha256:90bbb3c16635e9627f49eec6539f956d70746c409209041800a0280b93152823 /uv /uvx /bin/

# Install deps
ENV UV_SYSTEM_PYTHON=1

COPY pyproject.toml uv.lock ./
RUN uv pip install --no-cache --requirement pyproject.toml
COPY ./mockbook /app/mockbook
RUN uv pip install --no-cache --editable .

COPY . .

ENTRYPOINT ["/app/docker-entrypoint.sh"]

EXPOSE 80 8000 8888
