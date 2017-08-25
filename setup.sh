echo "Installing Docker ..."
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Verify fingerprint"
sudo apt-key fingerprint 0EBFCD88
read  -n 1 -p "All good? [Y/n]: "
read -p "Release repository? (stable, edge, test): " release
echo "Adding repo: $release"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   $release"

sudo apt-get update
sudo apt-get install docker-ce

echo "Installing docker-compose ..."
read -p "docker-compose version (1.15.0):" version
: ${version:="1.15.0"}
sudo curl -L
https://github.com/docker/compose/releases/download/$version/docker-compose-`uname
-s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "All set!"
