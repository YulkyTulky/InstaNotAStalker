ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = InstaNotAStalkerPreferences

InstaNotAStalkerPreferences_FILES = NASRootListController.m NASRootHeaderView.m NASSwitchCell.m NASKillButtonCell.m NASDynamicTextEditCell.m
InstaNotAStalkerPreferences_INSTALL_PATH = /Library/PreferenceBundles
InstaNotAStalkerPreferences_FRAMEWORKS = UIKit
InstaNotAStalkerPreferences_PRIVATE_FRAMEWORKS = Preferences
InstaNotAStalkerPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/InstaNotAStalkerPreferences.plist$(ECHO_END)
