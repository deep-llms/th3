#1
#th3-setup-env-20260821-185655
set -euo pipefail

echo '=== th3 environment setup ==='
date -u
hostname

bash scripts/setup_env.sh

echo 'TH3 ENVIRONMENT SETUP DONE'
