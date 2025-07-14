#!/usr/bin/env bash
# =============================================================================
# install_alertmanager.sh
#
# Purpose:
#   Automated installation of Prometheus Alertmanager as a systemd service on Ubuntu.
#   Installs binaries, prepares directories, writes config, creates service unit,
#   enables and starts Alertmanager under its own user.
#
# Usage:
#   sudo bash install_alertmanager.sh [<version>]
#   e.g.: sudo bash install_alertmanager.sh v0.28.1
#
# Prerequisites:
#   - wget, tar, systemd
#   - Should be run as root (or via sudo)
#
# Variables:
VERSION="${1:-v0.28.1}"
USER="alertmanager"
GROUP="alertmanager"
BIN_DIR="/usr/local/bin"
CONFIG_DIR="/etc/alertmanager"
DATA_DIR="/var/lib/alertmanager"
SERVICE_FILE="/etc/systemd/system/alertmanager.service"
DOWNLOAD_URL="https://github.com/prometheus/alertmanager/releases/download/${VERSION}/alertmanager-${VERSION#v}.linux-amd64.tar.gz"

echo "🛠️ Installing Alertmanager version ${VERSION}"

# 1. Create system user & group
if ! id -u "$USER" >/dev/null 2>&1; then
  groupadd --system "$GROUP"
  useradd --system --no-create-home \
          --shell /sbin/nologin \
          --gid "$GROUP" \
          "$USER"
  echo "✅ Created system user & group: $USER"
else
  echo "ℹ️ User '$USER' already exists"
fi

# 2. Prepare directories
for DIR in "$CONFIG_DIR" "$DATA_DIR"; do
  mkdir -p "$DIR"
  chown "$USER:$GROUP" "$DIR"
  chmod 750 "$DIR"
done

echo "✅ Created & secured directories: $CONFIG_DIR, $DATA_DIR"

# 3. Download and install binaries
TMPDIR="$(mktemp -d)"
cd "$TMPDIR" || exit 1

echo "🔽 Downloading Alertmanager from $DOWNLOAD_URL"
wget -q "$DOWNLOAD_URL" -O alertmanager.tar.gz || {
  echo "❌ Download failed"; exit 1; }

tar -xzf alertmanager.tar.gz
cd alertmanager-*.linux-amd64 || exit 1

install -m 0755 alertmanager amtool "$BIN_DIR/"
echo "✅ Installed binaries to $BIN_DIR"

# 4. Create default configuration file
cat > "$CONFIG_DIR/alertmanager.yml" <<EOF
global:
  resolve_timeout: 5m

route:
  receiver: 'email'

receivers:
  - name: 'email'
    email_configs:
      - to: 'you@example.com'
        from: 'alertmanager@example.com'
        smarthost: 'smtp.example.com:587'
        auth_username: 'alertmanager@example.com'
        auth_password: 'your-password'
        send_resolved: true
EOF

chown "$USER:$GROUP" "$CONFIG_DIR/alertmanager.yml"
chmod 640 "$CONFIG_DIR/alertmanager.yml"

echo "✅ Created default config at $CONFIG_DIR/alertmanager.yml"

# 5. Create systemd service file
cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Prometheus Alertmanager Service
Wants=network-online.target
After=network-online.target

[Service]
User=${USER}
Group=${GROUP}
Type=simple
ExecStart=${BIN_DIR}/alertmanager \
  --config.file=${CONFIG_DIR}/alertmanager.yml \
  --storage.path=${DATA_DIR}
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

chmod 644 "$SERVICE_FILE"
echo "✅ Created systemd unit file at $SERVICE_FILE"

# 6. Reload systemd, enable and start service
systemctl daemon-reload
systemctl enable alertmanager
systemctl start alertmanager

# 7. Final check
sleep 2
if systemctl is-active --quiet alertmanager; then
  echo "🎉 Alertmanager is now running and enabled at boot!"
  echo "Access it at http://localhost:9093"
else
  echo "⚠️ Alertmanager failed to start. Check logs with: systemctl status alertmanager"
fi

# 8. Cleanup
rm -rf "$TMPDIR"
