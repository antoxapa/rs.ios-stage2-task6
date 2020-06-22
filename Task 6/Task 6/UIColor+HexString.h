//
//  UIColor+HexString.h
//  Task 6
//
//  Created by Антон Потапчик on 6/19/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexString)
+ (UIColor *) colorWithHexString: (NSString *) hexString;

+ (UIColor *) appBlackColor;
+ (UIColor *) appWhiteColor;
+ (UIColor *) appRedColor;
+ (UIColor *) appBlueColor;
+ (UIColor *) appGreenColor;
+ (UIColor *) appYellowColor;
+ (UIColor *) appYellowHighlightedColor;
+ (UIColor *) appGrayColor;

@end

NS_ASSUME_NONNULL_END
