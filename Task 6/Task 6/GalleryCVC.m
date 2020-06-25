//
//  GalleryCVC.m
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "GalleryCVC.h"
#import "UIColor+HexString.h"


@interface GalleryCVC ()
@property (nonatomic, strong) UILabel *durationLabel;
@end

@implementation GalleryCVC

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupImageView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView {
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    [NSLayoutConstraint activateConstraints:@[
            [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        ]];
    
    self.durationLabel = [[UILabel alloc]init];
    [self.imageView addSubview:self.durationLabel];
    self.durationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.durationLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
    self.durationLabel.textAlignment = NSTextAlignmentRight;
    self.durationLabel.numberOfLines = 1;
    self.durationLabel.textColor = UIColor.whiteColor;
   
    
    [NSLayoutConstraint activateConstraints:@[
//        [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
//        [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        
        [self.durationLabel.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:-5],
        [self.durationLabel.leadingAnchor constraintEqualToAnchor:self.imageView.leadingAnchor],
        [self.durationLabel.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:-5],
    ]];
}

- (void) setDuration:(NSString*)duration {
    
    self.durationLabel.text = duration;
    self.imageView.layer.shadowColor = [UIColor appBlackColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(0, -50);
    self.imageView.layer.shadowOpacity = 0.8;
    self.imageView.layer.shadowRadius = 1.0;
    self.imageView.clipsToBounds = NO;
}

@end
