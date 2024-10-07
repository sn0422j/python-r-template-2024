#!/bin/bash
set -euxo pipefail
cd "$(dirname "$0")/../"

rig run --script install.R
