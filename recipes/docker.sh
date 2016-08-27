for PACKAGE in apt-transport-https ca-certificates; do
	sunzi.install "$PACKAGE" || true
done

if add_source docker 'deb https://apt.dockerproject.org/repo debian-jessie main'; then
	sunzi.mute "apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D"
	sunzi.mute "apt-get update"
fi

sunzi.install docker-engine=1.9.1-0~jessie || true
