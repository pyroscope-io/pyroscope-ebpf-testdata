
.PHONY: amd64/disk.ext4
amd64/disk.ext4: amd64/kernels
	rm -f $@
	fallocate -l 8G $@
	mkfs.ext4 $@

	docker build --platform=linux/amd64 --target=image_builder  --tag=vm_image_builder .
	# I failed to build a docker image using genext2fs, so I'm using a docker container to build the image using docker run --privileged
	docker run --rm -ti -u 0 --privileged -v $(shell pwd):/mnt/ vm_image_builder \
		/bootstrap_disk_0.sh /mnt/$@ /mnt/amd64/modules


.PHONY: amd64/kernels
amd64/kernels:
	docker build --platform=linux/amd64 --target=kernel_amd64 --output=amd64/ .


include vmrun.mk
