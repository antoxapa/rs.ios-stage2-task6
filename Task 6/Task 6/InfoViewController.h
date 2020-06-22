//
//  InfoViewController.h
//  Task 6
//
//  Created by Антон Потапчик on 6/20/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photos/Photos.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PHPhotoLibraryChangeObserver>

@end

NS_ASSUME_NONNULL_END
