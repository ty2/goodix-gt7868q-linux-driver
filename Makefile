PWD := $(shell pwd)
KVERSION := $(shell uname -r)
KERNEL_DIR = /lib/modules/$(KVERSION)
VERSION = $(shell git describe --abbrev=0)
MODULE_NAME = goodix-gt7868q
obj-m := $(MODULE_NAME).o

all:
	make -C $(KERNEL_DIR)/build/ M=$(PWD) modules
clean:
	make -C $(KERNEL_DIR)/build/ M=$(PWD) clean

update-version:
	# update DKMS version
	sed -i "s/PACKAGE_VERSION=.*/PACKAGE_VERSION=\"$(VERSION)\"/g" dkms/dkms.conf
	# update AUR source tag
	sed -i -E '/source=/s/#tag=[^"]+/#tag=$(VERSION)/' aur/PKGBUILD
	# update AUR pkgrel
	sed -Ei 's/^(pkgrel=)([0-9]+)/echo "\1$$((\2 + 1))"/e' aur/PKGBUILD

build-aur:
	cd aur && makepkg -f && makepkg --printsrcinfo > .SRCINFO

install-aur:
	cd aur && makepkg -i

install-dkms:
	# Install the DKMS configuration file to the appropriate directory
	install -Dm644 dkms/dkms.conf /usr/src/goodix-gt7868q-$(VERSION)/dkms.conf
	# Copy the source to the DKMS source directory
	cp -r . /usr/src/goodix-gt7868q-$(VERSION)
	# Add the DKMS module to the system
	dkms add -m goodix-gt7868q/$(VERSION)
	# Install the DKMS module
	dkms install goodix-gt7868q/$(VERSION)

install-quirks:
	# Install the custom libinput quirks file to the appropriate directory
	install -Dm644 local-overrides.quirks /usr/share/libinput/60-custom-thinkbookg6p2024imh.quirks