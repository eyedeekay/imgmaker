echo "# deb http://us.mirror.devuan.org/merged/ jessie main

deb http://us.mirror.devuan.org/merged/ jessie main
deb-src http://us.mirror.devuan.org/merged/ jessie main

# jessie-security, previously known as 'volatile'
deb http://us.mirror.devuan.org/merged/ jessie-security main
deb-src http://us.mirror.devuan.org/merged/ jessie-security main

# jessie-updates, previously known as 'volatile'
deb http://us.mirror.devuan.org/merged/ jessie-updates main
deb-src http://us.mirror.devuan.org/merged/ jessie-updates main
" | sudo tee $IMGMAKER_APT_DIR/sources.list

echo "# Tor Project Repositories
deb http://deb.torproject.org/torproject.org stable main
deb-src http://deb.torproject.org/torproject.org stable main

deb http://deb.torproject.org/torproject.org unstable main
deb-src http://deb.torproject.org/torproject.org unstable main
" | sudo tee $IMGMAKER_APT_SRCS_DIR/tor.list

echo "# Pull packages from unstable as needed.
deb http://us.mirror.devuan.org/merged/ ceres main
deb-src http://us.mirror.devuan.org/merged/ ceres main

deb http://ftp.us.debian.org/debian unstable main
deb-src http://ftp.us.debian.org/debian unstable main
" | sudo tee $IMGMAKER_APT_SRCS_DIR/sid.list

echo "#i2p Package Repository
deb http://deb.i2p2.no/ sid main
deb-src http://deb.i2p2.no/ sid main
" | sudo tee $IMGMAKER_APT_SRCS_DIR/i2p.list

echo "# autogenerated by devuan-baseconf
# decomment following lines to  enable the developers devuan repository
#deb http://packages.devuan.org/devuan jessie main
#deb-src http://packages.devuan.org/devuan jessie main
" | sudo tee $IMGMAKER_APT_SRCS_DIR/devuandevel.list

echo "#! cmotc.github.io/apt-now repositories
deb https://cmotc.github.io/apt-now/debian rolling main
deb-src https://cmotc.github.io/apt-now/debian rolling main
" | sudo tee $IMGMAKER_APT_SRCS_DIR/cmotc.github.io.apt-now.list

echo "#! fyrix.github.io/kernels repositories
#deb https://fyrix.github.io/kernels/debian rolling main
deb https://fyrix.github.io/arm-kernel-frozen/debian rolling main
deb https://fyrix.github.io/core/debian rolling main
deb-src https://fyrix.github.io/core/debian rolling main
#deb-src https://fyrix.github.io/kernels/debian rolling main
" | sudo tee $IMGMAKER_APT_SRCS_DIR/fyrix.github.io.kernels.list
