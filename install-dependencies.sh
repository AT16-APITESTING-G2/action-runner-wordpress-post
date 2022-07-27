#!/bin/bash

# Install Java
apt update && apt upgrade -y
apt install default-jdk -y
# Install pip python
apt install python3-pip -y
# Install docker-compose
apt install docker-compose -y