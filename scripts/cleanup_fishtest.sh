#!/bin/bash

# Elevate privileges for the entire script
sudo bash <<EOF

# Check if the user 'fishtest' exists before proceeding
if id "fishtest" &>/dev/null; then

    # Kill all processes for the user
    echo "Killing all processes for user 'fishtest'..."
    pkill -u fishtest

    # Delete the user and their home directory
    echo "Deleting user 'fishtest' and their home directory..."
    deluser --remove-home --remove-all-files fishtest

    # Delete the user's group
    echo "Deleting user 'fishtest' group..."
    delgroup fishtest

    # Stop and disable the fishtest services
    for service_id in 6543 6544 6545; do
        echo "Stopping and disabling fishtest@$service_id.service..."
        systemctl stop fishtest@$service_id.service || echo "Service fishtest@$service_id not running."
        systemctl disable fishtest@$service_id.service || echo "Service fishtest@$service_id not enabled."
    done

    # Remove the service files
    for service_id in 6543 6544 6545; do
        service_file="/etc/systemd/system/fishtest@$service_id.service"
        if [ -f "$service_file" ]; then
            echo "Removing $service_file..."
            rm "$service_file"
        else
            echo "Service file $service_file not found."
        fi
    done

    # Reload systemd to apply changes
    echo "Reloading systemd daemon..."
    systemctl daemon-reload

    echo "Cleanup complete: User 'fishtest' and services have been removed."

else
    echo "User 'fishtest' does not exist. Nothing to clean up."
fi

EOF
