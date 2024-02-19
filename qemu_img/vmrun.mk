
QEMU_ARCH ?= amd64
KVM_ARGS ?= -enable-kvm -cpu host
ifeq ($(QEMU_ARCH),amd64)
QEMU_BIN ?= qemu-system-x86_64 -M pc   -append "root=/dev/vda console=ttyS0  noresume"
KERNEL ?= amd64/boot/vmlinuz-6.1.0-18-amd64
INITRD ?= amd64/boot/initrd.img-6.1.0-18-amd64
DISK ?= amd64/disk.ext4
else ifeq ($(QEMU_ARCH),arm64)
QEMU_BIN=qemu-system-aarch64 -M virt -cpu cortex-a57  -append "root=/dev/vda2 console=ttyAMA0 noresume"
#INITRD=$(TMP_EBPF)/initrd.img-5.10.0-26-arm64
#KERNEL=$(TMP_EBPF)/vmlinuz-5.10.0-26-arm64
#DISK=$(TMP_EBPF)/debian-5.10-aarch64.qcow2
else
$(error "Unknown QEMU_ARCH: $(QEMU_ARCH)")
endif



.PHONY: qemu/kill
qemu/kill:
	pkill qemu-system || true

.PHONY: qemu/start
qemu/start: # todo add dependencies
	  $(QEMU_BIN) $(KVM_ARGS) \
        -smp 4  \
        -m 4G \
        -initrd $(INITRD) \
        -kernel $(KERNEL) \
        -drive if=virtio,file=${DISK},format=raw,id=hd \
        -net user,hostfwd=tcp::2222-:22 \
        -net nic \
        -device intel-hda \
        -device hda-duplex \
        -nographic \
         &


SSH_CMD="ssh -p 2222 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost"
#
#wait_for_ssh() {
#  local retries=0
#  while ! (${connect} true); do
#    if [[ "${retries}" -gt 30 ]]; then
#      echo "SSH connection failed after 30 retries"
#      exit 1
#    fi
#    retries=$((retries + 1))
#    sleep 1
#  done
#}

# TODO LOOP
.PHONY: qemu/wait
qemu/wait:
	@echo "Waiting for SSH to be available"
	@${SSH_CMD} true
	@echo "SSH is available"
