//
// LWBinaryBottomTextEditOption.m
// LockWatch2CustomFaces [SSH: janiks-mac-mini.local]
//
// Created by janikschmidt on 9/5/2020
// Copyright © 2020 Team FESTIVAL. All rights reserved
//

#import "LWBinaryBottomTextEditOption.h"

@implementation LWBinaryBottomTextEditOption

+ (instancetype)optionWithBottomTextEnabled:(BOOL)bottomTextEnabled forDevice:(CLKDevice*)device {
	return [self _optionWithValue:(bottomTextEnabled ? 1 : 0) forDevice:device];
}

- (BOOL)bottomTextEnabled {
	return [self _value] == 1;
}

#pragma mark - NTKEnumeratedFaceEditOption

+ (NSString*)_localizedNameForValue:(NSUInteger)value forDevice:(CLKDevice*)device {
	switch (value) {
		case 0: return [[NSBundle bundleForClass:self.class] localizedStringForKey:@"BINARY_BOTTOM_TEXT_OFF" value:@"Binary" table:@"Binary"];
		case 1: return [[NSBundle bundleForClass:self.class] localizedStringForKey:@"BINARY_BOTTOM_TEXT_ON" value:@"Binary" table:@"Binary"];
		default: break;
	}
	
	return nil;
}

+ (NSArray*)_orderedValuesForDevice:(CLKDevice*)device {
	return @[ @0, @1 ];
}

+ (NSString*)_snapshotKeyForValue:(NSUInteger)value forDevice:(CLKDevice*)device {
	switch (value) {
		case 0: return @"BottomTime-off";
		case 1: return @"BottomTime-on";
		default: break;
	}
	
	return nil;
}

- (NSDictionary*)_valueToFaceBundleStringDict {
	return @{
		@0: @"BottomTime-off",
		@1: @"BottomTime-on"
	};
}

- (long long)swatchStyle {
	return 3;
}

@end