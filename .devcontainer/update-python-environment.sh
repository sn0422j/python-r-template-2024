#!/bin/bash
set -euxo pipefail
cd "$(dirname "$0")/../"

source /tmp/python-venv/.venv/bin/activate
uv sync --extra dev
