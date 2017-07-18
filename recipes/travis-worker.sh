if add_source travisci_worker 'deb https://packagecloud.io/travisci/worker/ubuntu/ precise main'; then
	curl -sL https://packagecloud.io/travisci/worker/gpgkey | apt-key add -
	sunzi.mute "apt-get update"
fi

if sunzi.install travis-worker; then
	usermod -a -G docker travis
fi

cat files/default-travis-worker > /etc/default/travis-worker

mkdir -p /var/lib/travis-worker/queue
# chown may fail if re-provisioning while mounted
chown travis:travis /var/lib/travis-worker/queue || true

echo "Setting up travis to run on boot"
if grep travis-worker /etc/rc.local > /dev/null; then
	sed -ie 's/^.*travis-worker.*$/( sudo -u travis sh -c "umask 0012 \&\& rm -f /var/lib/travis-worker/queue/.write-test \&\& . \/etc\/default\/travis-worker \&\& travis-worker" \& ) \&/' /etc/rc.local
else
	sed -ie 's/^exit 0$/( sudo -u travis sh -c "umask 0012 \&\& rm -f /var/lib/travis-worker/queue/.write-test \&\& . \/etc\/default\/travis-worker \&\& travis-worker" \& ) \&\nexit 0/' /etc/rc.local
fi
