#!/bin/bash
set -euxo pipefail
cd "$(dirname "$0")"

bash ./update-python-environment.sh   
bash ./update-r-environment.sh   
