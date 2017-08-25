echo "Checking for docker"
if [ $(dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -c "ok installed") -eq 0 ];
then

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
: ${release:="stable"}
echo "Adding repo: $release"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   $release"

sudo apt-get update
sudo apt-get install docker-ce

echo "Finished installing docker-ce"
echo "Adding $(whoami) to group docker"

sudo usermod -aG docker $(whoami)

else
echo "docker-ce is already installed"
fi

echo "Checking for docker-compose"
if ! which docker-compose > /dev/null; then
echo "Installing docker-compose ..."
read -p "docker-compose version (1.15.0):" version
: ${version:="1.15.0"}
sudo curl -L https://github.com/docker/compose/releases/download/$version/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
else
echo "docker-compose is already installed"
fi

echo "All set!"
