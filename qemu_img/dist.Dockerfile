
ARG IMAGE=
FROM $IMAGE as pull

FROM ubuntu as compressor
RUN apt-get update && apt-get -y install xz-utils
ADD amd64/disk.ext4 /amd64/disk.ext4
ADD arm64/disk.ext4 /arm64/disk.ext4
RUN xz -z /amd64/disk.ext4
RUN xz -z /arm64/disk.ext4

FROM scratch as push
ADD amd64/boot /amd64/boot
ADD amd64/modules /amd64/modules
ADD arm64/boot /arm64/boot
ADD arm64/modules /arm64/modules
COPY --from=compressor /amd64/disk.ext4.xz /amd64/disk.ext4.xz
COPY --from=compressor /arm64/disk.ext4.xz /arm64/disk.ext4.xz

