//
//  GalleryCVC.h
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryCVC : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
- (void) setDuration:(NSString*)duration;
@end

NS_ASSUME_NONNULL_END
