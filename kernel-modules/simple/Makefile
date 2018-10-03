obj-m += simple_lkm.o

.PHONY: install-libs
install-libs:
	sudo apt-get install -y build-essential linux-headers-`uname -r`
	# ubuntu
	sudo apt install -y libelf-dev


all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules


clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean


.PHONY: load-mod
load-mod:
	sudo insmod simple_lkm.ko


.PHONY: unload-mod
unload-mod:
	sudo rmmod simple_lkm.ko


.PHONY: test
test:
	sudo dmesg -C
	sudo insmod simple_lkm.ko
	sudo rmmod simple_lkm.ko
	dmesg