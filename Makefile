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
	cp imgmaker \
	/usr/bin/imgmaker

uninstall:
	rm -rf /etc/imgmaker/imgmakrc \
	/usr/lib/imgmaker/

clean:
	rm ../imgmaker_0.4-1_amd64.deb

deb-pkg:
	checkinstall --default \
		--install=no \
		--pkgname="imgmaker" \
		--pkgversion="0.4" \
		--pkglicense="mit" \
		--pakdir=../ \
		--deldoc=yes \
		--deldesc=yes \
		--delspec=yes \
		--backup=no
