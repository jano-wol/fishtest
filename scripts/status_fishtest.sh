#!/bin/bash

# Get the server's IP address
server_ip=$(hostname -I | awk '{print $1}')

# Check mongod (if applicable)
mongod_status=$(systemctl is-active mongod.service)
if [ "$mongod_status" = "active" ]; then
    echo "Mongod is running."
else
    echo "Mongod is NOT running."
fi

# Check net-server (if applicable)
net_server_status=$(systemctl is-active net-server.service)
if [ "$net_server_status" = "active" ]; then
    echo "Net server is running."
else
    echo "Net server is NOT running."
fi

# Check net-server (if applicable)
nginx_server_status=$(systemctl is-active nginx.service)
if [ "$nginx_server_status" = "active" ]; then
    echo "Nginx is running."
else
    echo "Nginx is NOT running."
fi

# Check if the Fishtest services are running
for port in {6543..6545}; do
    service_status=$(systemctl is-active "fishtest@$port.service")

    if [ "$service_status" = "active" ]; then
        echo "Fishtest service on port $port is running."
    else
        echo "Fishtest service on port $port is NOT running."
    fi
done

# Display the IP address
echo "Access Fishtest at: http://$server_ip"

