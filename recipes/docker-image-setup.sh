# This runs *inside* the docker image to configure it
# So it doesn't have the sunzi environment available

set -e

sleep 3 # Wait for parent to attach, probably

export DEBIAN_FRONTEND=noninteractive

echo "Update and upgrade"
apt-get update > /dev/null
apt-get -y upgrade > /dev/null

echo "Ensure required packages are installed"
apt-get install -y sudo ssh git git-annex make curl jekyll > /dev/null

# Create user travis with password "travis"
useradd -m -p '$6$fwW6ZT6i$qhKP.1nFbUadigKW5IIwTvy8I5aYgDTtSch4J5YVcNMKuwGrXsghjGn8cnQArcRSBt01VGwjQVGleInY/zwdD0' travis || true
mkdir -p /home/travis/.ssh
printf "Host *\n\tStrictHostKeyChecking no" > /home/travis/.ssh/config
chown -R travis:travis /home/travis/.ssh
chmod 0700 /home/travis/.ssh
chmod 0600 /home/travis/.ssh/config

mkdir -p /var/run/sshd

# Allow "travis" user to sudo apt-get
echo "travis ALL=(root) NOPASSWD: /usr/bin/apt-get" >> /etc/sudoers.d/10travis-apt-get
chmod 0440 /etc/sudoers.d/10travis-apt-get
