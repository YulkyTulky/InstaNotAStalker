ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = InstaNotAStalkerPreferences

<<<<<<< HEAD
InstaNotAStalkerPreferences_FILES = NASRootListController.m NASSwitchCell.m NASRootHeaderView.m NASKillButtonCell.m NASDynamicTextEditCell.m
=======
InstaNotAStalkerPreferences_FILES = NASRootListController.m NASSwitchCell.m NASRootHeaderView.m NASKillButtonCell.m
>>>>>>> 8f302c8d28aaac2ebd820063e0828c4563b51983
InstaNotAStalkerPreferences_INSTALL_PATH = /Library/PreferenceBundles
InstaNotAStalkerPreferences_FRAMEWORKS = UIKit
InstaNotAStalkerPreferences_PRIVATE_FRAMEWORKS = Preferences
InstaNotAStalkerPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/InstaNotAStalkerPreferences.plist$(ECHO_END)