echo -e "\n### START: Provision CentOS 7 x64 with Docker ###\n\n"

# Update Yum packages list
yum update -y

# Install Docker via Yum
yum install -y docker net-tools

# Updating to Docker latest release
wget https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/bin/docker

# Add Docker service to systemctl
systemctl enable docker.service
systemctl start docker.service
systemctl status docker.service

# Yum cleanup
yum clean all

# Make Docker related directories
mkdir /srv/docker
mkdir /srv/docker_registry
mkdir /srv/docker_registry/images

echo -e "\n### COMPLETED: Provision CentOS 7 x64 Base build with Docker ###\n\n"