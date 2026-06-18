_default:
    just --list

# Install deps and tools
install:
    git submodule update --init --recursive
    uv python install
    uv sync --frozen

# Update deps and tools
update:
    uv sync --upgrade
    pre-commit autoupdate

alias up := update

# =============================================================================
# Development
# =============================================================================

# Run all checks
ci: lint test

# Autoformat code
format:
    git ls-files --cached --others --exclude-standard '*.sh' \
        | tee /dev/tty \
        | xargs uv run shfmt --write
    uv run ruff format .

alias fmt := format

# Run all linters
lint:
    git ls-files --cached --others --exclude-standard '*.sh' \
        | tee /dev/tty \
        | xargs uv run shellcheck
    uv run ruff check .
    uv run mypy --show-error-codes --pretty .

# Run all tests
test:
    ./test/bats/bin/bats --formatter pretty --verbose-run ./test

# Apply autofixes
fix:
    git ls-files --cached --others --exclude-standard '*.sh' \
        | tee /dev/tty \
        | xargs uv run shfmt --write
    uv run ruff check --fix .
    uv run ruff format .

# Build the Docker image with tag mockbook:local
build:
    docker build --tag mockbook:local .

# Run full application stack (reuses test setup)
run:
    docker compose up --build

# Run FastAPI server only
run-fastapi:
    uv run --frozen uvicorn mockbook.app:app \
        --reload \
        --reload-dir ./mockbook \
        --reload-include '*.ipynb'

alias runf := run-fastapi

# Run Jupyter server only
run-jupyter:
    uv run jupyter lab \
        --allow-root \
        --ServerApp.root_dir ./mockbook \
        --NotebookApp.token=token

alias runj := run-jupyter

# =============================================================================
# Utility
# =============================================================================

# Remove temporary files
clean:
    find . -path '*.log*' -delete
