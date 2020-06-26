//
//  InfoTVC.h
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoTVC : UITableViewCell

@property (nonatomic, strong) UIImageView *mainImage;
@property (nonatomic, strong) UIImageView *subtitleImage;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;
@property (nonatomic, strong) NSString *creationDate;
@property (nonatomic, strong) NSString *modificationDate;
@property (nonatomic, strong) PHAsset *asset;

@end

NS_ASSUME_NONNULL_END
