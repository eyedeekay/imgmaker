#! /bin/sh

sudo chroot $IMGMAKER_SYSTEM_DIR bash -c 'wget -qO - https://geti2p.net/_static/i2p-debian-repo.key.asc | apt-key add -'
sudo chroot $IMGMAKER_SYSTEM_DIR bash -c 'wget -qO - https://cmotc.github.io/apt-now/cmotc.github.io.gpg.key | apt-key add -'
sudo chroot $IMGMAKER_SYSTEM_DIR gpg --keyserver keys.gnupg.net --recv 886DDD89
sudo chroot $IMGMAKER_SYSTEM_DIR bash -c 'gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -'
sudo chroot $IMGMAKER_SYSTEM_DIR bash -c 'wget -qO - https://fyrix.github.io/core/fyrix.github.io.gpg.key | apt-key add -'
sudo chroot $IMGMAKER_SYSTEM_DIR bash -c 'wget -qO - https://fyrix.github.io/kernels/fyrix.github.io.kernels.gpg.key | apt-key add -'
sudo chroot $IMGMAKER_SYSTEM_DIR apt-get update
