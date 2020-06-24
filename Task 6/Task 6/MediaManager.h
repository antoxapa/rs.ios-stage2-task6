//
//  MediaManager.h
//  Task 6
//
//  Created by Антон Потапчик on 6/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "MediaObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MediaManager : UIViewController

- (void)downloadAsset:(PHAsset *)asset completion:(void (^)(MediaObject *object))completion;
@end

NS_ASSUME_NONNULL_END
