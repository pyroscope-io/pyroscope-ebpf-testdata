
DIST_IMAGE ?= pyroscope/ebpf-test-vm-image:latest


.PHONY: amd64/kernels
amd64/kernels:
	docker build --platform=linux/amd64 --target=kernels --output=amd64/ -f amd64.Dockerfile .

.PHONY: arm64/kernels
arm64/kernels:
	docker build --platform=linux/arm64 --target=kernels --output=arm64/ -f arm64.Dockerfile .

.PHONY: amd64/disk.ext4
amd64/disk.ext4: amd64/kernels
	rm -f $@ && fallocate -l 5G $@ && mkfs.ext4 $@
	docker build --platform=linux/amd64 --target=image_builder --tag=vm_image_builder -f amd64.Dockerfile .
	# I failed to build a docker image using genext2fs, so I'm using a docker container to build the image using docker run --privileged
	docker run --platform=linux/amd64 --rm -ti -u 0 --privileged -v $(shell pwd):/mnt/ vm_image_builder \
		/bootstrap_disk_0.sh /mnt/$@ /mnt/amd64/modules

.PHONY: arm64/disk.ext4
arm64/disk.ext4: arm64/kernels
	rm -f $@ && fallocate -l 5G $@ && mkfs.ext4 $@
	docker build --platform=linux/arm64 --target=image_builder --tag=vm_image_builder -f arm64.Dockerfile .
	# I failed to build a docker image using genext2fs, so I'm using a docker container to build the image using docker run --privileged
	docker run --platform=linux/arm64 --rm -ti -u 0 --privileged -v $(shell pwd):/mnt/ vm_image_builder \
		/bootstrap_disk_0.sh /mnt/$@ /mnt/arm64/modules


.PHONY: dist/push
dist/push:
	docker build --build-arg=IMAGE=$(DIST_IMAGE) --push -t $(DIST_IMAGE) -f dist.Dockerfile .

.PHONY: dist/pull
dist/pull:
	docker pull $(DIST_IMAGE)
	docker rm temp_container || true
	docker create --name temp_container $(DIST_IMAGE) sh
	docker export temp_container -o filesystem.tar
	docker rm temp_container
	tar -xf filesystem.tar -C ./
	rm -rf filesystem.tar .dockerenv dev/ etc/


.PHONY: clean
clean:
	rm -rf amd64/*ext4 arm64/*ext4 amd64/modules/* arm64/modules/* amd64/boot/* arm64/boot/* dev/ etc/ .dockerenv

include vmrun.mk
