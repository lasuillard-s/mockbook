FROM python:3.14-slim-bookworm@sha256:980c03657c7c8bfbce5212d242ffe5caf69bfd8b6c8383e3580b27d028a6ddb3

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
COPY --from=ghcr.io/astral-sh/uv:latest@sha256:555ac94f9a22e656fc5f2ce5dfee13b04e94d099e46bb8dd3a73ec7263f2e484 /uv /uvx /bin/

# Install deps
ENV UV_SYSTEM_PYTHON=1

COPY pyproject.toml uv.lock ./
RUN uv pip install --no-cache --requirement pyproject.toml
COPY ./mockbook /app/mockbook
RUN uv pip install --no-cache --editable .

COPY . .

ENTRYPOINT ["/app/docker-entrypoint.sh"]

EXPOSE 80 8000 8888
