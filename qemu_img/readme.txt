
This directory contains scripts to build and run a vm image suitable to run ebpf tests.

There are two architectures amd64 and arm64.

1. Pull some kernels and kernel modules from public docker images into $ARCH/boot and $ARCH/modules using amd64/kernels makefile target.
2. Build a ext4 disk using debootstrap bookworm (debian) ( $ARCH/disk.ext4 makefile target and bootstrap_disk_0.sh)
3. Do some extra bootstrap (install packages on the disk ( bootstrap_disk_1.sh)
4. Copy extracted modules and extra modules $ARCH/modules and $ARCH/modules_extra to disk
