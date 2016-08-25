imgmaker
--------

This is a script used to generate an image file containing a Debian image for a
tablet which can be booted from an SD card. It is written the way it is for one
specific purpose, to emulate as closely as possible the experience of installing
Debian from a CD image on PC hardware in order to approximate a Debian, Devuan,
or Ubuntu based GNU/Linux Image. Technically it's a little flexible on the GNU
but it'll probably be easier to start with the standard Debian stuff which is
frequently GNU and I personally like GNU, but do what you like with it.

Please keep in mind that these readme's(And also my blog) are the notes of an
aimless, underachieving, untrained amateur. I've tried to be detailed enough to
be perfectly clear to me. I probably make mistakes, I probably say things that
are unnecessary. But I think it'll probably be helpful as long as you're mindful
of who wrote it.

What does it do?
================

It combines a few things to enable you to generate a custom SD card image for
an Allwinner tablet, right now just a couple of Allwinner A33 generic cheap
tablets but there's no reason that you can't swap a few parts to make it work
with any tablet capable of booting from an SD card, which I guess is all the
Allwinner tablets, and probably a couple of others. I read alot of news and if
I had to guess, I'd say that most of these dudes selling no-name Allwinner
tablets are pretty lazy and minimally competent alot of the time. They modify
the devices fairly little and take the path of least resistance to a minimum
viable product, part of which means that they're left pretty easy to manipulate.
I've had several and the only trouble I've ever had booting an alternate system
from an SD card was finding an alternate system to use(Hence, literally
everything I've put on or looked at on github, to one end or another. And all
the forks do serve a purpose, for when I return to whatever I was trying to
learn, in case the project has progressed, I can determine the differences
without having to host all that code locally. Which I would do if it were an
option, but I just don't have the storage space.). They seem to be pretty
generic most of the time. On my tablet, for instance, there is a truly startling
amount of firmware for devices that are not contained on the system.

So, step by step

  1. First, it makes sure that the loopback devices it needs are unmounted,
  and creates the folders that will be used to bootstrap the system.
  2. Second, it designates a large section of the disk and sets it to 0, naming
  that section $DISTRO\_NAME-$VERSION\_NAME.img, and then mounts the newly
  created img file as a loopback device at /dev/loop0.
  3. Third, it writes u-boot directly to the first part of the newly created img
  file using the loopback device.
  4. Fourth, it takes the loopback device and partitions it automatically with
  fdisk. This process uses up all of the space on the device by default and
  currently doesn't have any way to change the behavior, but that is planned.
  5. Fifth, it mounts those partitions block-device style at /dev/loop0p1 for
  the boot partition and at /dev/loop0p2 for the system partition.
  6. Sixth, it sets up a complete Debian system in a chroot using qemu to
  complete the process with binaries for an ARM architecture.
  7. Seventh, it runs scripts to customize the chrooted system's settings.
  8. Eighth, it installs custom packages in the chrooted system from a simple
  user-defined list.
  9. Ninth, it creates a user and exits the chroot.

It also contains a set of functions you could include in your own script.

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

This file contains device trees.  If you do not set the $DTFILE variable in
advance, you will be presented with an interactive menu which lists all the
.dtb file in this folder.

  * **imgmaker/hooks**

This file contains scripts which can be customized in just about any way you
like, because they're just scripts that are run right after the system is
bootstrapped. imgmaker runs all the scripts ending in ".d.sh" in the hooks
folder.

###How do I use it?

It's pretty simple, and it'll get simpler soon. I'm in the process of making an
interactive version of the script which imitates the Debian system installer,
as similar to installing from a Live CD or USB Stick as possible. If you've set
a few [environment variables](https://github.com/cmotc/imgmaker/blob/master/loop-debootstrap.conf),
it will just prompt you for your sudo password a couple times as it creates
loopback devices and runs debootstrap. If you have not set those environment
variables, then you'll be prompted with an interactive menu that will make sure
that all the minimum required information is known while you're building.

Per usual, firmware seems to be the sticking point, but much less than you'd
think. Ultimately, I'd prefer to handle this by packaging, and the firmware
directory's existence is pretty tenuous on that basis. What I'd prefer is to
make a sort of "Crude tablet firmware packaging kit" which makes some educated
guesses at the firmware on a tablet, checks if they seem to be sane, extracts
the firmware and generates a non-free binary .deb package(And a useful amount of
documentation to allow for culling/replacing unnecessary firmware)according to
some set of rules. That way, a person could generate a package with minimal
skill, sign it, store it, and so on. Then, admittedly with a few complications
on the road, you could put that firmware package onto a USB Armory stick, make
that stick non-writable without your key, and have your tablet load the firmware
from that stick a' la Joanna Rutkowska and Invisible Things Lab's outlook on
verified firmware. Also simpler things like being able to give out updates on
the off chance your device gets one. So I'm on the fence about the firmware
directory's very existence. I'm convinced that a better way is to package the
firmware.

Resources
---------

  * [Igor Pecovnik's Armbian build system](https://github.com/igorpecovnik/lib)
  * [Linux-Sunxi Github](https://github.com/linux-sunxi/)
  * [Sunxi Mainline Status](https://linux-sunxi.org/Linux_mainlining_effort)
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

To-do
-----

These will be done in this order, unless something needs to be added to the
list, in which case if I'm too tired to do it at the time I'll put it here so I
don't forget.

  * Execute fun-sounding /etc/skel idea!
  * Add Kernel Selection Support.
  * Add custom partitions support.
  * Add getopts mode
  * Create more advanced way of hooking into the build process with scripts.
  * Make it possible to use more keyboards and display/login managers(right now
  only XDM and xvkbd are used)
  * Remove bash-non-dashisms
  * Add $HOME encryption by default.
  * Add Full-Disk Encryption option.
