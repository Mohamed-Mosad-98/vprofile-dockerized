#!/bin/bash
set -euxo pipefail

exec > >(tee /var/log/userdata.log | logger -t userdata -s 2>/dev/console) 2>&1

apt-get update -y
apt-get install -y ca-certificates curl gnupg git

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
| tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y

apt-get install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

cd /home/ubuntu

git clone --branch main ${github_repo}

cd vprofile-dockerized

cat > .env <<EOF
DB_PASS=${db_password}
RMQ_USER=${rabbitmq_user}
RMQ_PASS=${rabbitmq_password}
EOF

docker compose version

docker compose up -d

docker ps -a