//
//  DetailViewController.h
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic, strong) UIImageView *detailImageView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *creationDateField;
@property (nonatomic, strong) UILabel *modificationDateField;
@property (nonatomic, strong) UILabel *typeField;

- (instancetype) initWithInfo:(UIImage *)image creationDate:(NSString *)creationDate modificationDate:(NSString *)modificationDate type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
