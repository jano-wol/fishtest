#!/bin/bash

# Elevate privileges for the entire script
sudo bash <<EOF

# Kill all processes for the user
sudo pkill -u fishtest

# Delete the user and their home directory
sudo deluser --remove-home --remove-all-files fishtest

# Delete the user's group
sudo delgroup fishtest

# Stop and disable the services (example service names)
sudo systemctl stop fishtest@6543.service
sudo systemctl stop fishtest@6544.service
sudo systemctl stop fishtest@6545.service
sudo systemctl disable fishtest@6543.service
sudo systemctl disable fishtest@6544.service
sudo systemctl disable fishtest@6545.service

# Remove the service files
sudo rm /etc/systemd/system/fishtest@6543.service
sudo rm /etc/systemd/system/fishtest@6544.service
sudo rm /etc/systemd/system/fishtest@6545.service

# Reload systemd to reflect the changes
sudo systemctl daemon-reload

echo "User 'fishtest' and their associated services have been removed successfully."

EOF
