# Heavily based on Cloud.ca Makefile
# https://github.com/cloud-ca/docker-machine-driver-cloudca/blob/master/Makefile

TARGET_OS = "darwin linux windows"
TARGET_ARCH = "386 amd64"

VERSION := $(shell git describe --tags)
VERSION_COMMIT := $(shell git describe --always --long)
ifeq ($(VERSION),)
VERSION:=$(VERSION_COMMIT)
endif

build: clean
		go build -o ./dist/docker-machine-driver-upcloud

install: build
		cp ./dist/docker-machine-driver-upcloud $(GOPATH)/bin/

uninstall:
		rm -f $(GOPATH)/bin/docker-machine-driver-upcloud

clean: uninstall
		rm -rf ./dist

build-all: clean
		gox -verbose \
			-ldflags "-X main.version=$(VERSION)" \
			-os=$(TARGET_OS) \
			-arch=$(TARGET_ARCH) \
			-output="dist/{{.OS}}-{{.Arch}}/docker-machine-driver-upcloud"
		mkdir ./dist/compressed
		for PLATFORM in `find ./dist -mindepth 1 -maxdepth 1 -type d` ; do \
			OSARCH=`basename $$PLATFORM` ; \
			echo "--> $$OSARCH" ; \
			pushd $$PLATFORM >/dev/null 2>&1 ; \
			zip ../compressed/docker-machine-driver-upcloud_v$(VERSION)_$$OSARCH.zip ./* ; \
			popd >/dev/null 2>&1 ; \
		done
