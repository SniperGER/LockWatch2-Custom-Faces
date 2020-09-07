//
// LWBinaryFace.m
// LockWatch2CustomFaces
//
// Created by janikschmidt on 8/20/2020
// Copyright © 2020 Team FESTIVAL. All rights reserved
//

#import "LWBinaryBottomTextEditOption.h"
#import "LWBinaryFace.h"
#import "NTKFaceStyle.h"

@implementation LWBinaryFace

+ (BOOL)acceptsDevice:(CLKDevice*)device {
	return YES;
}

+ (Class)faceViewClass {
	return NSClassFromString(@"LWBinaryFaceView");
}

+ (NSUUID*)uuid {
    static NSUUID* uuid;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        uuid = [NSUUID UUID];
    });
    
    return uuid;
}


- (NSString*)author {
	return @"Team FESTIVAL";
}

- (NSString*)faceDescription {
	return [[NSBundle bundleForClass:self.class] localizedStringForKey:@"DESCRIPTION" value:@"DESCRIPTION" table:@"Binary"];
}

- (long long)faceStyle {
	return NTKFaceStyleCustom;
}

- (NSString*)name {
	return [[NSBundle bundleForClass:self.class] localizedStringForKey:@"DISPLAY_NAME" value:@"Binary" table:@"Binary"];
}

#pragma mark - Edit Modes

- (NSArray*)_customEditModes {
	return @[ @10, @15 ];
}

- (id)_defaultOptionForCustomEditMode:(long long)editMode slot:(id)slot {
	switch (editMode) {
		case 10:
			return [NTKFaceColorEditOption optionWithFaceColor:5 forDevice:self.device];
		case 15:
			return [LWBinaryBottomTextEditOption optionWithBottomTextEnabled:NO forDevice:self.device];
		default: break;	
	}
	
	return nil;
}

- (NSUInteger)_indexOfOption:(id)option forCustomEditMode:(long long)editMode slot:(id)slot {
	switch (editMode) {
		case 10:
			return [NTKFaceColorEditOption indexOfOption:option forDevice:self.device];
		case 15:
			return [LWBinaryBottomTextEditOption indexOfOption:option forDevice:self.device];
		default: break;	
	}
	
	return -1;
}

- (NSUInteger)_numberOfOptionsForCustomEditMode:(long long)editMode slot:(id)slot {
	switch (editMode) {
		case 10:
			return [NTKFaceColorEditOption numberOfOptionsForDevice:self.device];
		case 15:
			return [LWBinaryBottomTextEditOption numberOfOptionsForDevice:self.device];
		default: break;	
	}
	
	return 0;
}

- (id)_optionAtIndex:(NSUInteger)index forCustomEditMode:(long long)editMode slot:(id)slot {
	switch (editMode) {
		case 10:
			return [NTKFaceColorEditOption optionAtIndex:index forDevice:self.device];
		case 15:
			return [LWBinaryBottomTextEditOption optionAtIndex:index forDevice:self.device];
		default: break;	
	}
	
	return 0;
}

- (Class)_optionClassForCustomEditMode:(long long)editMode {
	switch (editMode) {
		case 10: return NSClassFromString(@"NTKFaceColorEditOption");
		case 15: return NSClassFromString(@"LWBinaryBottomTextEditOption");
		default: break;
	}
	
	return nil;
}

@end