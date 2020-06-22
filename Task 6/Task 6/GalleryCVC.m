//
//  GalleryCVC.m
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "GalleryCVC.h"

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
    
    [NSLayoutConstraint activateConstraints:@[
            [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    //        [self.mainImage.heightAnchor constraintEqualToAnchor:self.heightAnchor],
    //        [self.mainImage.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        ]];
}

@end
