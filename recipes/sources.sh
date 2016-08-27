add_source() {
	if [ -f /etc/apt/sources.list.d/"$1".list ]; then
		echo "$1 source already exists"
		return 1
	else
		echo "Adding $1 to the apt source list"
		echo "$2" > /etc/apt/sources.list.d/"$1".list
		return 0
	fi
}
