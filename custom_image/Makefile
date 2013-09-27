NAME = offlineArt
VERSION = 0.1.3-image
ARCH = all

#Source data
WGET = wget -c
PIRATEBOX_IMG = source_piratebox_ws_img.tar.gz
PIRATEBOX_IMG_URL = "http://piratebox.aod-rpg.de/piratebox_ws_0.6_img.tar.gz"

# Data Folder from 
MOD_SRC_FOLDER=mod_data
MOD_VERSION_TAG=$(MOD_SRC_FOLDER)/version_tag

#Vars for appling config
MOD_FOLDER=mod_image
MOUNT_POINT=$(MOD_FOLDER)/image
MOD_IMAGE=$(MOD_FOLDER)/image_file
MOD_IMAGE_TGZ=offlineArt_0.1_img.tar.gz
MOD_IMAGE_GZ=offlineArt_0.1_img.gz

.DEFAULT_GOAL = all
.PHONY: all clean cleanall

#--------------------------------------------
# Fetching DATA
$(PIRATEBOX_IMG): 
	$(WGET)  $(PIRATEBOX_IMG_URL) -O $@ 

$(MOD_IMAGE): $(PIRATEBOX_IMG)
	tar xzO -f $(PIRATEBOX_IMG) > $@

$(MOD_FOLDER): 
	mkdir -p $@

$(MOUNT_POINT):
	mkdir -p $@


#--------------------------------------------
# Preparing image

$(MOD_VERSION_TAG): 
	echo  "$(NAME) - $(VERSION)"   > $@ 

$(MOD_IMAGE_TGZ): $(MOD_FOLDER) $(MOUNT_POINT) $(MOD_IMAGE) $(MOD_VERSION_TAG)
	echo "#### Mounting image-file"
	sudo  mount -o loop,rw,sync   $(MOD_IMAGE)   $(MOUNT_POINT)
	echo "#### Copy Modifications to image file"
	sudo   cp -vr $(MOD_SRC_FOLDER)/*   $(MOUNT_POINT)
# Example Exchanging stock lines
#	sed 's:HOST="piratebox.lan":HOST="piratechest.lan":'  -i  $(MOUNT_POINT)/conf/piratebox.conf
	sudo sed 's:DROOPY_ENABLED="yes":DROOPY_ENABLED="no":'  -i  $(MOUNT_POINT)/conf/piratebox.conf
	sudo sed 's:RESET_CHAT="yes":RESET_CHAT="no":'  -i  $(MOUNT_POINT)/conf/piratebox.conf
	sudo  chmod a+w mod_image/image/conf/lighttpd/lighttpd.conf && echo 'include "/opt/piratebox/conf/lighttpd/offlineArt_mod"' >>  $(MOUNT_POINT)/conf/lighttpd/lighttpd.conf
	sudo  umount  $(MOUNT_POINT)
	tar czf  $(MOD_IMAGE_TGZ)  $(MOD_IMAGE)
	gzip -c $(MOD_IMAGE) > $(MOD_IMAGE_GZ)


#---------------------------------------------
# Clean stuff
clean: 
	-rm -f  $(MOD_IMAGE_GZ)
	-rm -f  $(MOD_IMAGE_TGZ)
	-rm -f  $(MOD_VERSION_TAG)

cleanall: clean
	-rm -fr $(MOUNT_POINT) 
	-rm -fr $(MOD_IMAGE)
	-rm -fr $(PIRATEBOX_IMG) 
	-rm -fr $(MOD_FOLDER) 

all:    $(MOD_IMAGE_TGZ)
