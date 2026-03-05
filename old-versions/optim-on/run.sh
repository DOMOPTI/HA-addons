#!/bin/bash
set -e

# HA Supervisor mounts /data as a volume at runtime, which wipes any
# directories created at build time. Recreate them before starting the app.
mkdir -p /data/optim-on/database
mkdir -p /data/optim-on/plugins
chmod 755 /data/optim-on/database /data/optim-on/plugins

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
