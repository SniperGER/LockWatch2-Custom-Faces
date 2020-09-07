//
// LWBinaryFaceView.m
// LockWatch2CustomFaces
//
// Created by janikschmidt on 8/20/2020
// Copyright © 2020 Team FESTIVAL. All rights reserved
//

#import "LWBinaryBottomTextEditOption.h"
#import "LWBinaryFaceView.h"

@interface LWBinaryFaceView () {
	NSLayoutConstraint* _centerYConstraint;
	NSLayoutConstraint* _centerYOffsetConstraint;
}
@end

@implementation LWBinaryFaceView

- (instancetype)initWithFaceStyle:(long long)faceStyle forDevice:(id)device clientIdentifier:(id)clientIdentifier {
	if (self = [super initWithFaceStyle:faceStyle forDevice:device clientIdentifier:clientIdentifier]) {
		CGFloat dotSpacing = 10;
		CGFloat dotSize = ((CGRectGetWidth(self.bounds) - 24) - (5 * dotSpacing)) / 6;
		
		_stackViewContainer = [[UIStackView alloc] initWithFrame:CGRectZero];
		// [_stackViewContainer setAlignment:UIStackViewAlignmentCenter];
		[_stackViewContainer setDistribution:UIStackViewDistributionFillProportionally];
		[_stackViewContainer setSpacing:dotSpacing];
		[_stackViewContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
		
		[self addSubview:_stackViewContainer];
		
		_centerYConstraint = [_stackViewContainer.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
		_centerYOffsetConstraint = [_stackViewContainer.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:(-(dotSize + 8) / 2)];
		
		[NSLayoutConstraint activateConstraints:@[
			[_stackViewContainer.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12],
			[_stackViewContainer.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-12],
			// [_stackViewContainer.heightAnchor constraintEqualToConstant:((dotSize * 4) + (dotSpacing * 3))],
		]];
		
		_hours1StackView = [self _newStackViewWithDotCount:2 dotSize:dotSize spacing:dotSpacing];
		[_stackViewContainer addArrangedSubview:_hours1StackView];
		
		_hours2StackView = [self _newStackViewWithDotCount:4 dotSize:dotSize spacing:dotSpacing];
		[_stackViewContainer addArrangedSubview:_hours2StackView];
		
		_minutes1StackView = [self _newStackViewWithDotCount:3 dotSize:dotSize spacing:dotSpacing];
		[_stackViewContainer addArrangedSubview:_minutes1StackView];
		
		_minutes2StackView = [self _newStackViewWithDotCount:4 dotSize:dotSize spacing:dotSpacing];
		[_stackViewContainer addArrangedSubview:_minutes2StackView];
		
		_seconds1StackView = [self _newStackViewWithDotCount:3 dotSize:dotSize spacing:dotSpacing];
		[_stackViewContainer addArrangedSubview:_seconds1StackView];
		
		_seconds2StackView = [self _newStackViewWithDotCount:4 dotSize:dotSize spacing:dotSpacing];
		[_stackViewContainer addArrangedSubview:_seconds2StackView];
		
		_timeLabelContainer = [[UIStackView alloc] initWithFrame:CGRectZero];
		[_timeLabelContainer setDistribution:UIStackViewDistributionFillProportionally];
		[_timeLabelContainer setSpacing:dotSpacing];
		[_timeLabelContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
		
		[self addSubview:_timeLabelContainer];
		
		for (int i = 0; i < 6; i++) {
			UILabel* timeLabel = [UILabel new];
			[timeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
			[timeLabel setTextAlignment:NSTextAlignmentCenter];
			[timeLabel setFont:[CLKFont systemFontOfSize:13.5 weight:UIFontWeightSemibold]];
			[timeLabel setTextColor:[UIColor colorWithWhite:1.0 alpha:0.7]];
			[_timeLabelContainer addArrangedSubview:timeLabel];
			
			[NSLayoutConstraint activateConstraints:@[
				[timeLabel.widthAnchor constraintEqualToConstant:dotSize],
				[timeLabel.heightAnchor constraintEqualToConstant:dotSize],
			]];
		}
		
		[NSLayoutConstraint activateConstraints:@[
			[_timeLabelContainer.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12],
			[_timeLabelContainer.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-12],
			[_timeLabelContainer.topAnchor constraintEqualToAnchor:_stackViewContainer.bottomAnchor constant:8],
		]];
	}
	
	return self;
}

#pragma mark - Instance Methods

- (void)_becameActiveFace {
	_clockTimerToken = [[CLKClockTimer sharedInstance] startSecondUpdatesWithHandler:^(NSDate* date) {
		[self _timeDidUpdate:[[NTKTimeOffsetManager sharedManager] faceDisplayTime]];
	} identificationLog:nil];
}

- (void)_becameInactiveFace {
	if (_clockTimerToken) {
		[[CLKClockTimer sharedInstance] stopSecondUpdatesForToken:_clockTimerToken];
		_clockTimerToken = nil;
	}
}

- (void)_timeDidUpdate:(NSDate*)time {
	NSDateFormatter* dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateFormat:@"HHmmss"];
	NSString* timeString = [dateFormatter stringFromDate:time];
	
	[_stackViewContainer.subviews enumerateObjectsUsingBlock:^(UIStackView* stackView, NSUInteger index, BOOL* stop) {
		int timeValue = [[timeString substringWithRange:(NSRange){ index, 1 }] integerValue];
		
		[stackView.subviews enumerateObjectsUsingBlock:^(UIStackView* view, NSUInteger index, BOOL* stop) {
			if (timeValue & (1 << index)) {
				[view setBackgroundColor:_foregroundColor];
			} else {
				[view setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
			}
		}];
	}];
	
	[_timeLabelContainer.subviews enumerateObjectsUsingBlock:^(UILabel* timeLabel, NSUInteger index, BOOL* stop) {
		[timeLabel setText:[timeString substringWithRange:(NSRange){ index, 1 }]];
	}];
}

- (UIStackView*)_newStackViewWithDotCount:(NSInteger)dotCount dotSize:(CGFloat)dotSize spacing:(CGFloat)spacing {
	UIStackView* stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
	[stackView setSpacing:spacing];
	[stackView setAxis:UILayoutConstraintAxisVertical];
	[stackView setAlignment:UIStackViewAlignmentCenter];
	[stackView setDistribution:UIStackViewDistributionFill];
	[stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[stackView setTransform:CGAffineTransformMakeScale(1, -1)];
	
	for (int i = 0; i < 4; i++) {
		UIView* dotView = [[UIView alloc] initWithFrame:(CGRect){ CGPointZero, { dotSize, dotSize }}];
		[dotView setTranslatesAutoresizingMaskIntoConstraints:NO];
		// [dotView setAlpha:(i + 1) / 4.0];
		[dotView.layer setCornerRadius:dotSize / 2];
		[stackView addArrangedSubview:dotView];
		
		[NSLayoutConstraint activateConstraints:@[
			[dotView.widthAnchor constraintEqualToConstant:dotSize],
			[dotView.heightAnchor constraintEqualToConstant:dotSize],
		]];
	}
	
	UIView* fillView = [UIView new];
	[fillView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
	[fillView setAlpha:0];
	[stackView addArrangedSubview:fillView];
	
	return stackView;
}

- (void)setOverrideDate:(NSDate*)date duration:(CGFloat)duration {
	[super setOverrideDate:date duration:duration];
	
	if (date) {
		[self _timeDidUpdate:date];
	}
}

#pragma mark - Edit Modes

- (void)_applyOption:(NTKEditOption*)option forCustomEditMode:(long long)editMode slot:(id)slot {
	if (editMode == 10) {
		NTKFaceColorScheme* colorScheme = [NTKFaceColorScheme colorSchemeForDevice:self.device withFaceColor:[(NTKFaceColorEditOption*)option faceColor] units:1];
		_foregroundColor = colorScheme.foregroundColor;
	} else if (editMode == 15) {
		BOOL bottomTextEnabled = [(LWBinaryBottomTextEditOption*)option bottomTextEnabled];
		[_timeLabelContainer setHidden:!bottomTextEnabled];
		
		[NSLayoutConstraint activateConstraints:@[
			(bottomTextEnabled ? _centerYOffsetConstraint : _centerYConstraint)
		]];
		
		[NSLayoutConstraint deactivateConstraints:@[
			(bottomTextEnabled ? _centerYConstraint : _centerYOffsetConstraint)
		]];
	}
}

- (UIImage*)_swatchImageForEditOption:(NTKEditOption*)option mode:(long long)editMode withSelectedOptions:(id)selectedOptions {
	// NSLog(@"option: %@, selected options: %@", NSStringFromClass(option.class), selectedOptions);
	if ([option isKindOfClass:NSClassFromString(@"LWBinaryBottomTextEditOption")]) {
		NSMutableString* backgroundImageName = [NSMutableString stringWithFormat:@"Binary-%@", option.dailySnapshotKey];
		NSMutableString* accentImageName = [NSMutableString stringWithFormat:@"Binary-%@-Accent", option.dailySnapshotKey];
		
		if ([self.device isLuxo]) {
			[backgroundImageName appendString:@"-luxo"];
			[accentImageName appendString:@"-luxo"];
		}
		
		UIImage* backgroundImage = [UIImage imageNamed:backgroundImageName inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
		UIImage* accentImage = [[UIImage imageNamed:accentImageName inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithTintColor:_foregroundColor renderingMode:UIImageRenderingModeAlwaysTemplate];
		
		UIGraphicsBeginImageContext(backgroundImage.size);
		[backgroundImage drawInRect:(CGRect){ CGPointZero, backgroundImage.size }];
		[accentImage drawInRect:(CGRect){ CGPointZero, backgroundImage.size }];
		
		UIImage* finalImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return finalImage;
	}
	
	return [super _swatchImageForEditOption:option mode:editMode withSelectedOptions:selectedOptions];
}

@end