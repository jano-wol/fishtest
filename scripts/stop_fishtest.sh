#!/bin/bash
sudo systemctl stop mongod
sudo systemctl stop net-server
sudo systemctl stop nginx.service
sudo systemctl stop fishtest@{6543..6545}.service

