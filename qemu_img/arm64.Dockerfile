
FROM debian:12 as kernel_deb12
RUN apt-get update && apt-get -y install linux-image-6.1.0-18-arm64

FROM debian:11 as kernel_deb11
RUN apt-get update && apt-get -y install linux-image-5.10.0-28-arm64

FROM debian:10 as kernel_deb10
RUN apt-get update && apt-get -y install linux-image-4.19.0-26-arm64

FROM ubuntu:18.04 as kernel_ubuntu1804
RUN apt-get update && apt-get -y install flash-kernel && apt-get -y install linux-image-5.4.0-150-generic

FROM ubuntu:22.04 as kernel_ubuntu2204
RUN apt-get update && apt-get -y install flash-kernel &&  apt-get -y install linux-image-5.15.0-94-generic

# TODO 6.6, bpf-next

FROM scratch as kernels
COPY --from=kernel_deb12            /boot/ /boot
COPY --from=kernel_deb11            /boot/ /boot
COPY --from=kernel_deb10            /boot/ /boot
COPY --from=kernel_ubuntu1804 /boot/ /boot
COPY --from=kernel_ubuntu2204 /boot/ /boot
COPY --from=kernel_deb12            /lib/modules/        /modules/
COPY --from=kernel_deb11            /lib/modules/        /modules/
COPY --from=kernel_deb10            /lib/modules/        /modules/
COPY --from=kernel_ubuntu1804 /lib/modules/        /modules/
COPY --from=kernel_ubuntu2204 /lib/modules/        /modules/



FROM debian:bookworm as image_builder
RUN apt-get update && apt-get -y install debootstrap schroot genext2fs fakechroot rsync
COPY bootstrap_disk_1.sh bootstrap_disk_0.sh  /
