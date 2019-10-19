NAME=linux-namespace
GOOS ?= linux
ARCH ?= amd64

# NB: Requires 'sudo' if no new User namespace is created.
PHONY: go-run
go-run:
	go run linux-namespace.go

.PHONY: build-dirs
build-dirs:
	@mkdir -p dist/

PHONY: build
build:
	@GOOS=$(GOOS) GOARCH=$(ARCH) go build \
		-i -o dist/${NAME} ./cmd/${NAME}

PHONY: build-mount
build-mount: build
	rm -Rf /tmp/ns-process
	mkdir -p /tmp/ns-process/rootfs
	tar -C /tmp/ns-process/rootfs -xf assets/busybox.tar

PHONY: run
run: build-mount
	./dist/linux-namespace

PHONY: clean
clean:
	rm ./dist/linux-namespace
	rm -Rf /tmp/ns-process