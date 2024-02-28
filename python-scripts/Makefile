VERSION ?= 3.13.0a3
VERSION_MINOR ?= $(shell echo $(VERSION) | cut -d. -f1-2)
ARCH ?= amd64
ifeq ($(ARCH),amd64)
PLATFORM ?= linux/amd64
OUTPUT ?= ../python-x64/$(VERSION)/
else ifeq ($(ARCH),arm64)
PLATFORM ?= linux/arm64
OUTPUT ?= ../python-arm64/$(VERSION)/
else
$(error "Unknown ARCH: $(ARCH)")
endif

.phony: all
all:
	docker build \
		--platform=$(PLATFORM) \
		--build-arg=PYTHON_VERSION_PATCH=$(VERSION) \
		--build-arg=PYTHON_VERSION_MINOR=$(VERSION_MINOR)  \
		-f pythons.Dockerfile \
		--output=$(OUTPUT) \
		.

