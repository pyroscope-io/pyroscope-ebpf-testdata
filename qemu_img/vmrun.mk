
ARCH ?= amd64

ifeq ($(ARCH),amd64)
QEMU_BIN ?= qemu-system-x86_64 -M pc   -append "root=/dev/vda console=ttyS0  noresume"
KVM_ARGS ?= -enable-kvm -cpu host
KERNEL_NAME ?= 6.1.0-18-amd64
KERNEL ?= amd64/boot/vmlinuz-$(KERNEL_NAME)
INITRD ?= amd64/boot/initrd.img-$(KERNEL_NAME)
DISK ?= amd64/disk.ext4
else ifeq ($(ARCH),arm64)
QEMU_BIN=qemu-system-aarch64 -M virt -cpu cortex-a57  -append "root=/dev/vda console=ttyAMA0 noresume"
KVM_ARGS ?=
KERNEL_NAME ?= 6.1.0-18-arm64
KERNEL ?= arm64/boot/vmlinuz-$(KERNEL_NAME)
INITRD ?= arm64/boot/initrd.img-$(KERNEL_NAME)
DISK ?= arm64/disk.ext4
else
$(error "Unknown ARCH: $(ARCH)")
endif



.PHONY: qemu/kill
qemu/kill:
	pkill qemu-system || true

.PHONY: qemu/start
qemu/start:
	  $(QEMU_BIN) $(KVM_ARGS) \
        -smp 4  \
        -m 4G \
        -initrd $(INITRD) \
        -kernel $(KERNEL) \
        -drive if=virtio,file=${DISK},format=raw,id=hd \
        -net user,hostfwd=tcp::2222-:22 \
        -net nic \
        -nographic


SSH_PORT ?= 2222
SSH_OPTIONS ?= -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
SSH_CMD ?= ssh -p $(SSH_PORT) $(SSH_OPTIONS) root@localhost

.PHONY: qemu/wait
qemu/wait:
	bash wait.sh

.PHONY: qemu/start_and_wait
qemu/start_and_wait:
	$(MAKE) qemu/start >/dev/null 2>/dev/null &
	$(MAKE) qemu/wait

.PHONY: qemu/ssh
qemu/ssh:
	$(SSH_CMD)

.PHONY: qemu/scp
qemu/scp:
	scp -P $(SSH_PORT) $(SSH_OPTIONS) $(F) root@localhost:$(shell basename $(F))

.PHONY: qemu/exec
qemu/exec:
	$(SSH_CMD) $(CMD)