imgmaker
--------

This is a script used to generate an image file containing a Debian image for a
tablet which can be booted from an SD card.

What does it do?
================

It combines a few things to enable you to generate a custom SD card image for
an Allwinner tablet, right now just a couple of Allwinner A33 generic cheap
tablets but there's no reason that you can't swap a few parts to make it work
with any tablet capable of booting from an SD card, which I guess is all the
Allwinner tablets, and probably a couple of others. Right now

###How do I adapt it to support my tablet?

There are a few files and folders used to configure what goes into the image.
They are subject to change, but for now, here are what they are and what they
do.

  * **imgmaker/kernel**

This folder contains the files that install the kernel for your tablet system.
*For now, this folder expects at least:* a zImage, and the debs built when
you build a Linux kernel with the command:

        make deb-pkg

The zImage is copied directly into the boot partition, and the debs are copied
into the system partition and installed by dpkg. Alternatively, the debs can
be installed from a repository or you can copy the kernel files manually with
a script in the hooks directory(see below.)

  * **imgmaker/firmware**

This folder contains the files related to the firmware you may or may not need
to operate the tablet. They will be copied directly into the system partition
at the /lib/firmware/ folder, maintaining the same structure as in the
imgmaker/firmware folder.

  * **imgmaker/dtb**

This file contains device trees. Soon, the device trees will be selectable
interactively, but for now you need to set the DTFILE file variable which is
just the name of the file(not the folder).

        export DTFILE='sun8i-a33-q8-tablet.dtb'

  * **imgmaker/hooks**

This file contains scripts which can be customized in just about any way you
like, because they're just scripts that are run right before the system is
bootstrapped. imgmaker runs all the scripts ending in ".d.sh" in the hooks
folder.

###How do I use it?

It's pretty simple, and it'll get simpler soon. I'm in the process of making an
interactive version of the script which imitates the Debian system installer,
as similar to installing from a Live CD or USB Stick as possible. If you've set
a few [environment variables](https://github.com/cmotc/imgmaker/blob/master/loop-debootstrap.conf),
it will just prompt you for your sudo password a couple times as it creates
loopback devices and runs debootstrap. If you have not set those environment
variables.

Resources
---------

  * [How to build an SD card image without an SD Card, Super User](http://superuser.com/questions/830733/how-to-build-an-sd-card-image-without-an-sd-card)
  * [How to create an image file and use it like a block device](https://web2.clarkson.edu/projects/itl/honeypot/ddtutorial.txt)
  * [Mainline Debian Howto, but with no simplefb](https://linux-sunxi.org/Mainline_Debian_HowTo)
  * [Linux Sunxi Mainline Kernel Howto, includes simplefb instructions](https://linux-sunxi.org/Mainline_Kernel_Howto#simplefb)
  * [Touchscreens in General from linux-sunxi](https://linux-sunxi.org/Touchscreen) [Silead gslx Series Touchscreen](https://linux-sunxi.org/GSL1680)
  * [Installing Debian on Allwinner](https://wiki.debian.org/InstallingDebianOn/Allwinner)
  * [Details on how Allwinner SOC's boot](https://linux-sunxi.org/Boot)
  * [Building mainline u-boot for Allwinner SOC's](https://linux-sunxi.org/Mainline_U-Boot)
  * [Some stuff about configuring LCD's with u-boot, but I think for an old version. Boot.scr and the device tree are doing it here.](https://linux-sunxi.org/LCD)
  * [An excellent reason to take control of your device and update your kernel](https://www.rapid7.com/db/modules/post/multi/escalate/allwinner_backdoor)
  * I have a bunch more I'm pretty sure, but they're harder for me to remember
  at the moment.

