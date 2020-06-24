//
//  MediaObject.m
//  Task 6
//
//  Created by Антон Потапчик on 6/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "MediaObject.h"

@implementation MediaObject

- (instancetype) initWithInfo:(UIImage *)objectImage objectName:(NSString *)objectName objectDuration:(NSString *)objectDuration objectType:(NSString *)objectType creationDate:(NSString *)creationDate modificationDate:(NSString *)modificationDate objectSize:(NSString *)objectSize {
    self = [super init];
    if (self) {
        _objectImage = objectImage;
        _objectName = objectName;
        _objectDuration = objectDuration;
        _objectType = objectType;
        _creationDate = creationDate;
        _modificationDate = modificationDate;
        _objectSize = objectSize;
    }
    return self;
}


@end
