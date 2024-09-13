#!/bin/bash
sudo systemctl start mongod
sudo systemctl start net-server
sudo systemctl restart nginx.service
sudo systemctl start fishtest@{6543..6545}.service



