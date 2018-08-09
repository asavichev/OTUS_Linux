ѕри перезапуске системы заходим в систему в simble mode.
ћен€ем параметр монтировани€ файловой системы "ro" на УrwФ,
мен€ем параметры УrhgbФ и УquietФ на  Уrd.break enforcing=0Ф.

chroot /sysroot
passwd root
ѕосле обновлени€ парол€ необходимо обновить информацию с помощью SELinux-команды:
touch /.autorelabel

exit

reboot

ћен€ем им€ VolGroup лог прилогаетс€ lesson04.log

в каталоге /usr/lib/dracut/modules.d
ложим папку 01test и пересобираем initrd


[root@centos-ext3 01test]# mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
Executing: /usr/sbin/dracut -f -v /boot/initramfs-3.10.0-862.el7.x86_64.img 3.10.0-862.el7.x86_64
dracut module 'modsign' will not be installed, because command 'keyctl' could not be found!
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
dracut module 'cifs' will not be installed, because command 'mount.cifs' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsistart' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsi-iname' could not be found!
95nfs: Could not find any command of 'rpcbind portmap'!
dracut module 'modsign' will not be installed, because command 'keyctl' could not be found!
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
dracut module 'cifs' will not be installed, because command 'mount.cifs' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsistart' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsi-iname' could not be found!
95nfs: Could not find any command of 'rpcbind portmap'!
*** Including module: bash ***
*** Including module: test ***
*** Including module: nss-softokn ***
*** Including module: i18n ***
*** Including module: network ***
*** Including module: ifcfg ***
*** Including module: drm ***
*** Including module: plymouth ***
*** Including module: dm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 60-persistent-storage-dm.rules
Skipping udev rule: 55-dm.rules
*** Including module: kernel-modules ***
*** Including module: lvm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 56-lvm.rules
Skipping udev rule: 60-persistent-storage-lvm.rules
*** Including module: resume ***
*** Including module: rootfs-block ***
*** Including module: terminfo ***
*** Including module: udev-rules ***
Skipping udev rule: 40-redhat-cpu-hotplug.rules
Skipping udev rule: 91-permissions.rules
*** Including module: biosdevname ***
*** Including module: systemd ***
*** Including module: usrmount ***
*** Including module: base ***
*** Including module: fs-lib ***
*** Including module: microcode_ctl-fw_dir_override ***
  microcode_ctl module: hacking fw_dir
    microcode_ctl: processing data directory  "/usr/share/microcode_ctl/ucode_with_caveats/intel-06-4f-01"...
    microcode_ctl: Host-Only mode is enabled and ucode name does not match the expected one ("06-3c-03" != "")
*** Including module: shutdown ***
*** Including modules done ***
*** Installing kernel module dependencies and firmware ***
*** Installing kernel module dependencies and firmware done ***
*** Resolving executable dependencies ***
*** Resolving executable dependencies done***
*** Hardlinking files ***
*** Hardlinking files done ***
*** Stripping files ***
*** Stripping files done ***
*** Generating early-microcode cpio image contents ***
*** Constructing GenuineIntel.bin ****
*** Store current command line parameters ***
*** Creating image file ***
*** Creating microcode section ***
*** Created microcode section ***
*** Creating image file done ***
*** Creating initramfs image file '/boot/initramfs-3.10.0-862.el7.x86_64.img' done ***
[