//
// LWBinaryFaceView.h
// LockWatch2CustomFaces
//
// Created by janikschmidt on 8/20/2020
// Copyright © 2020 Team FESTIVAL. All rights reserved
//

#import <ClockKit/ClockKit.h>
#import <NanoTimeKitCompanion/NanoTimeKitCompanion.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWBinaryFaceView : NTKFaceView {
	NSNumber* _clockTimerToken;
	
	UIStackView* _stackViewContainer;
	UIStackView* _hours1StackView;
	UIStackView* _hours2StackView;
	UIStackView* _minutes1StackView;
	UIStackView* _minutes2StackView;
	UIStackView* _seconds1StackView;
	UIStackView* _seconds2StackView;
	
	UIStackView* _timeLabelContainer;
	
	UIColor* _foregroundColor;
}

@end

NS_ASSUME_NONNULL_END