
FROM --platform=linux/amd64 debian:12 as kernel_builder_deb12
RUN apt-get update && apt-get -y install linux-image-6.1.0-18-amd64

FROM --platform=linux/amd64 debian:11 as kernel_builder_deb11
RUN apt-get update && apt-get -y install linux-image-5.10.0-28-amd64

FROM --platform=linux/amd64 debian:10 as kernel_builder_deb10
RUN apt-get update && apt-get -y install linux-image-4.19.0-26-amd64

FROM --platform=linux/amd64 ubuntu:18.04 as kernel_builder_amd64_ubuntu1804
RUN apt-get update && apt-get -y install linux-image-5.4.0-150-generic

FROM --platform=linux/amd64 ubuntu:22.04 as kernel_builder_amd64_ubuntu2204
RUN apt-get update && apt-get -y install    linux-image-5.15.0-94-generic

# TODO 6.6, bpf-next

FROM --platform=linux/amd64 scratch as kernel_amd64
COPY --from=kernel_builder_deb12            /boot/ /boot
COPY --from=kernel_builder_deb11            /boot/ /boot
COPY --from=kernel_builder_deb10            /boot/ /boot
COPY --from=kernel_builder_amd64_ubuntu1804 /boot/ /boot
COPY --from=kernel_builder_amd64_ubuntu2204 /boot/ /boot
COPY --from=kernel_builder_deb12            /lib/modules/6.1.0-18-amd64/           /modules/6.1.0-18-amd64/
COPY --from=kernel_builder_deb11            /lib/modules/5.10.0-28-amd64/          /modules/5.10.0-28-amd64/
COPY --from=kernel_builder_deb10            /lib/modules/4.19.0-26-amd64/          /modules/4.19.0-26-amd64/
COPY --from=kernel_builder_amd64_ubuntu1804 /lib/modules/5.4.0-150-generic/        /modules/5.4.0-150-generic/
COPY --from=kernel_builder_amd64_ubuntu2204 /lib/modules/5.15.0-94-generic/        /modules/5.15.0-94-generic/



FROM --platform=linux/amd64 debian:bookworm as image_builder
RUN apt-get update && apt-get -y install debootstrap schroot genext2fs fakechroot rsync
COPY bootstrap_disk_1.sh bootstrap_disk_0.sh  /
