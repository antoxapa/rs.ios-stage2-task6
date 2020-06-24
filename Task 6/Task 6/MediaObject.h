//
//  MediaObject.h
//  Task 6
//
//  Created by Антон Потапчик on 6/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaObject : NSObject

@property (nonatomic, strong) UIImage* objectImage;
@property (nonatomic, strong) NSString* objectName;
@property (nonatomic, strong) NSString* objectDuration;
@property (nonatomic, strong) NSString* objectType;
@property (nonatomic, strong) NSString* creationDate;
@property (nonatomic, strong) NSString* modificationDate;
@property (nonatomic, strong) NSString* objectSize;

- (instancetype) initWithInfo:(UIImage *)objectImage objectName:(NSString *)objectName objectDuration:(NSString *)objectDuration objectType:(NSString *)objectType creationDate:(NSString *)creationDate modificationDate:(NSString *)modificationDate objectSize:(NSString *)objectSize;

@end

NS_ASSUME_NONNULL_END
