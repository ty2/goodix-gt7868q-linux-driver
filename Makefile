PWD := $(shell pwd)
KVERSION := $(shell uname -r)
KERNEL_DIR = /lib/modules/$(KVERSION)

MODULE_NAME = goodix-gt7868q
obj-m := $(MODULE_NAME).o

all:
	make -C $(KERNEL_DIR)/build/ M=$(PWD) modules
clean:
	make -C $(KERNEL_DIR)/build/ M=$(PWD) clean
