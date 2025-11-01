AESD_ASSIGNMENTS_VERSION = main
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-4trastos.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

AESD_ASSIGNMENTS_MODULE_SUBDIRS = server

# Compilar aesdsocket usando cross-compiler
define AESD_ASSIGNMENTS_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) -o $(@D)/server/aesdsocket $(@D)/server/aesdsocket.c
endef

# Instalar binarios compilados y scripts de inicio
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
	$(INSTALL) -D -m 0755 $(@D)/server/generate-ssh-keys $(TARGET_DIR)/etc/init.d/S49generate-ssh-keys
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/tmp
endef

$(eval $(generic-package))
