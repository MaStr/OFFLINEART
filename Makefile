NAME = offlineArt
VERSION = 0.1.1
ARCH = all

WRT_PACKAGE = wrt_package
CUSTOM_IMAGE = custom_image


.DEFAULT_GOAL = all


all: 
	$(MAKE) -C $(WRT_PACKAGE)
	$(MAKE) -C $(CUSTOM_IMAGE)


clean: 
	$(MAKE) -C $(WRT_PACKAGE)  clean
	$(MAKE) -C $(CUSTOM_IMAGE) clean


.PHONY: all clean

