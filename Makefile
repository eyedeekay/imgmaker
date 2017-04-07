dummy:
	echo "do make install to install the imgmaker script to your system."
	echo "do make uninstall to uninstall the imgmaker script from your system."

install:
	mkdir -p /usr/lib/imgmaker/
	cp loop-debootstrap-common.conf \
	loop-debootstrap-common \
	mke2fs.conf \
	/usr/lib/imgmaker/
	mkdir -p /etc/imgmaker/
	cp loop-debootstrap.conf \
	/etc/imgmaker/imgmakrc

uninstall:
	rm -rf /etc/imgmaker/imgmakrc \
	/usr/lib/imgmaker/

deb-pkg:
