##############################################################
#
# AESD-ASSIGNMENTS Buildroot package
#
##############################################################

AESD_ASSIGNMENTS_VERSION = main
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-4trastos.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
    $(MAKE) -C $(@D)/finder-app CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)"
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server ARCH=$(BR2_ARCH) CROSS_COMPILE=$(TARGET_CROSS)
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin

	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin

    $(INSTALL) -D -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket

endef

$(eval $(generic-package))