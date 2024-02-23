
This directory contains scripts to build and run a vm image suitable to run ebpf tests.

There are two architectures amd64 and arm64.

1. Pull some kernels and kernel modules from public docker images into $ARCH/boot and $ARCH/modules using amd64/kernels makefile target.
2. Build a ext4 disk using debootstrap bookworm (debian) ( $ARCH/disk.ext4 makefile target and bootstrap_disk_0.sh)
3. Do some extra bootstrap (install packages on the disk ( bootstrap_disk_1.sh)
4. Copy extracted modules and extra modules $ARCH/modules and $ARCH/modules_extra to disk

You can commit extra kernels and modukes into boot_extra and modules_extra. _extra directories are not gitingored.

Here's an example how to pull them from aws for example

rsync -avz -e "ssh  -i ~/Downloads/grafana-pyroscope-aws-sandbox.pem"  ec2-user@ec2-54-91-28-178.compute-1.amazonaws.com:/boot/ ./amd64/boot_extra
rsync -avz -e "ssh  -i ~/Downloads/grafana-pyroscope-aws-sandbox.pem"  ec2-user@ec2-54-91-28-178.compute-1.amazonaws.com:/usr/lib/modules/ ./amd64/modules_extra

This pulls a lot of modules and in theory we only need few of them (bridge, br_netfilter and its depdendcnies, but idk
how to find all the deps automatically so pulling all of them for now.

You may need to update initramfs to be able to boot in qemu from virtio device

modify /etc/dracut.conf.d/ec2.conf
-omit_dracutmodules+="dm dmraid i18n plymouth crypt lvm mdraid qemu terminfo kernel-modules"
+omit_dracutmodules+="dm dmraid i18n plymouth crypt lvm mdraid qemu terminfo "
+add_drivers+=" virtio_blk "

Regenerate initramfs with dracut -f -v

Run amazon kernel in qemu
export KERNEL=amd64/boot_extra/vmlinuz-5.10.205-195.807.amzn2.x86_64
export INITRD=amd64/boot_extra/initramfs-5.10.205-195.807.amzn2.x86_64.img
make qemu/start


To rebuild docker image, do
make amd64/disk.ext4
make arm64/disk.ext4
make dist/
