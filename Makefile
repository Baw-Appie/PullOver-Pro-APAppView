TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ZPullOverProAPAppView

ZPullOverProAPAppView_FILES = Tweak.x
ZPullOverProAPAppView_CFLAGS = -fobjc-arc
ZPullOverProAPAppView_LIBRARIES = APAppView

include $(THEOS_MAKE_PATH)/tweak.mk
