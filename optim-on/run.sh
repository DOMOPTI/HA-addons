#!/bin/bash
set -e

# HA Supervisor mounts /data as a volume at runtime, wiping any directories
# created during the image build. Recreate them here before starting the app.
mkdir -p /data/optim-on/database
mkdir -p /data/optim-on/plugins
chmod 755 /data/optim-on/database /data/optim-on/plugins

# Bridge the `reset_admin` addon option to OPTIMON_RESET_ADMIN. When true, the
# Python worker wipes the dashboard `users` + `sessions` tables on boot so the
# onboarding flow can recreate the admin (see local-agent README).
if [ -f /data/options.json ] && python3 -c "import json,sys; sys.exit(0 if json.load(open('/data/options.json')).get('reset_admin') else 1)"; then
    echo "[run.sh] reset_admin=true — exporting OPTIMON_RESET_ADMIN=1 for this boot"
    export OPTIMON_RESET_ADMIN=1
fi

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
