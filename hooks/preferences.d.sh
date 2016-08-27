echo "
Package: linux-*
Pin: release a=rolling
Pin-Priority: 910
Package: *
Pin: release a=stable
Pin-Priority: 700
Package: *
Pin: release a=testing
Pin-Priority: 250
Package: *
Pin: release a=unstable
Pin-Priority: 200
Package: *
Pin: release a=nightly
Pin-Priority: 100
" | sudo tee $IMGMAKER_APT_PREF_DIR/be-stable

echo "Package: systemd
Pin: release o=Debian
Pin-Priority: -1
Package: systemd-*
Pin: release o=Debian
Pin-Priority: -1
Package: systemd-sysv
Pin: release o=Debian
Pin-Priority: -1
" | sudo tee $IMGMAKER_APT_PREF_DIR/avoid-systemd
