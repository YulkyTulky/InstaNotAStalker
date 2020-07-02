ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = InstaNotAStalker

InstaNotAStalker_FILES = Tweak.x
InstaNotAStalker_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += InstaNotAStalkerPreferences
include $(THEOS_MAKE_PATH)/aggregate.mk