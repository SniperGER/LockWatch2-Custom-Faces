THEOS_DEVICE_IP = Janiks-iPhone-X.local

PACKAGE_VERSION = $(shell cat VERSION)
ARCHS = arm64# arm64e
TARGET = iphone:13.3:latest

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = LockWatch2CustomFaces

LockWatch2CustomFaces_FILES = $(shell find . -name *.m)
LockWatch2CustomFaces_INSTALL_PATH = /Library/Application Support/LockWatch2/Faces
LockWatch2CustomFaces_CFLAGS = -fobjc-arc -I$(THEOS_PROJECT_DIR)
LockWatch2CustomFaces_PRIVATE_FRAMEWORKS = ClockKit NanoTimeKitCompanion

include $(THEOS_MAKE_PATH)/bundle.mk

before-stage::
	@find . -name ".DS_Store" -delete