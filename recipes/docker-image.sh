echo "Provision docker image"

sunzi.mute "sudo -u travis docker pull debian" || true
IMAGE="$(sudo -u travis docker images -q travis:default)"

if [ -z "$IMAGE" ]; then
	IMAGE="debian:latest"
fi

CONTAINER="$(sudo -u travis docker run -a STDIN -i "$IMAGE" /bin/sh < recipes/docker-image-setup.sh)"
sudo -u travis docker attach "$CONTAINER"
IMAGE="$(sudo -u travis docker commit -m "Provision" "$CONTAINER")"
sudo -u travis docker rm "$CONTAINER"
sudo -u travis docker tag -f "$IMAGE" travis:default
