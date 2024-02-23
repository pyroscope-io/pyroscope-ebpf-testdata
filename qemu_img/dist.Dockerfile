
ARG PULLER_BASE=pyroscope/ebpf-test-vm-image:latest
FROM $PULLER_BASE as puller

#FROM ubuntu:22.04 as pusher_builder
#RUN apt-get update && apt-get -y install xz-utils
#ADD amd64/disk.ext4 amd64/disk.ext4
#ADD arm64/disk.ext4 arm64/disk.ext4
#RUN xz amd64/disk.ext4 && xz arm64/disk.ext4

FROM scratch as pusher
#ADD amd64/boot amd64/boot_extra amd64/modules amd64/modules_extra amd64/disk.ext4 /amd64/
#ADD arm64/boot arm64/boot_extra arm64/modules arm64/modules_extra arm64/disk.ext4 /arm64/
ADD amd64/boot /amd64/boot
ADD amd64/modules /amd64/modules
ADD amd64/disk.ext4 /amd64/disk.ext4
ADD arm64/boot /arm64/boot
ADD arm64/modules /arm64/modules
ADD arm64/disk.ext4 /arm64/disk.ext4


