//
// LWBinaryBottomTextEditOption.h
// LockWatch2CustomFaces [SSH: janiks-mac-mini.local]
//
// Created by janikschmidt on 9/5/2020
// Copyright © 2020 Team FESTIVAL. All rights reserved
//

#import <ClockKit/ClockKit.h>
#import <NanoTimeKitCompanion/NanoTimeKitCompanion.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWBinaryBottomTextEditOption : NTKEnumeratedEditOption

+ (instancetype)optionWithBottomTextEnabled:(BOOL)bottomTextEnabled forDevice:(CLKDevice*)device;
- (BOOL)bottomTextEnabled;

@end

NS_ASSUME_NONNULL_END