
ARG PULLER_BASE=pyroscope/ebpf-test-vm-image:latest
FROM $PULLER_BASE as puller

FROM scratch as pusher
ADD amd64/boot /amd64/boot
ADD amd64/modules /amd64/modules
ADD arm64/boot /arm64/boot
ADD arm64/modules /arm64/modules

ADD amd64/disk.ext4 /amd64/disk.ext4
ADD arm64/disk.ext4 /arm64/disk.ext4
