# ❤️‍🔥 Contributing to this project

Thank you for your interest in contributing to **mockbook**.

## 🐛 Reporting issues

Please report issues in our [GitHub repository](https://github.com/lasuillard-s/mockbook/issues). Before submitting an issue, please search for existing issues to avoid duplicates.

## 🏗️ Project overview

This project consists of the following components:

- Python package (`mockbook`), a FastAPI application serving mock endpoints with live reloading on file changes (`/app/mockbook`)
- Preconfigured JupyterLab for writing mock endpoints
- Preconfigured NGINX reverse proxy for full mocking flexibility
- NGINX reloader triggered by configuration file changes (`/app/mockbook/nginx`)

### 🛠️ Tech stack

This project uses the following tech stack:

- [Python](https://www.python.org) 3.14
- [uv](https://docs.astral.sh/uv/) for dependency management and configuration
- [NGINX](https://nginx.org) for reverse proxy
- [JupyterLab](https://jupyter.org) for writing mock endpoints
- [FastAPI](https://fastapi.tiangolo.com) for serving mock endpoints
- [Supervisor](https://supervisord.org) for running services
- [Ruff](https://docs.astral.sh/ruff/) to format and lint Python code, and [Mypy](https://mypy-lang.org) for type checking
- [BATS](https://github.com/bats-core/bats-core) for testing shell scripts

### 📂 Key directory structure

- `docs/`: Documentation resources
- `examples/`: Usage examples
- `jupyterlab/`: JupyterLab configuration
- `mockbook/`: The project's Python package source code
- `mockbook/nginx/`: NGINX configuration files
- `scripts/`: Shell scripts for running services
- `supervisord/`: Supervisor configuration files
- `test/`: Project tests
- `docker-compose.yaml`: Docker Compose configuration for local development and testing
- `docker-entrypoint.sh`: Docker entrypoint script
- `Dockerfile`: Docker image definition
- `flake.nix`: Nix Flakes development environment
- `Justfile`: Commands for development
- `pyproject.toml`: Project dependencies and configuration

## 🔧 Set up the development environment

For development, the following tools are required:

### ❄️ Tools managed via Nix Flakes

This repository uses [Nix Flakes](https://nix.dev/concepts/flakes.html) to manage development tools. The following tools are installed automatically when `nix` is available:

- `pre-commit`
- `just`
- `uv`

Simply run `nix develop` to enter the development environment, then run `just install` to set up dependencies. The Nix shell also installs the pre-commit hooks automatically.

If you prefer using a [Dev Container](https://containers.dev), an example configuration file ([`devcontainer.json`](./.devcontainer.example/devcontainer.json)) is provided with Nix and Docker-in-Docker pre-installed.

## ✅ Verifying changes

Before pushing your code, run `just ci` to verify that your changes adhere to the project's coding standards and pass all linters, formatters, and tests.

Alternatively, use the `pre-commit` hooks to handle formatting, linting, type checking, and quick test feedback automatically.

## ✨ Submitting changes

Please feel free to submit pull requests on GitHub. Before opening a PR, ensure your changes pass all checks by running `just ci`.

## 🚀 Release process

The Docker image is published to Docker Hub automatically on pushes to the `main` branch. To release a new version, create a release in GitHub Releases with a `v*` tag, which will trigger the [publish.yaml](./.github/workflows/publish.yaml) workflow to build and push the Docker image with semantic version tags.
