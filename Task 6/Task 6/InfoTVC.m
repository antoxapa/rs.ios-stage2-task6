//
//  InfoTVC.m
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "InfoTVC.h"

@implementation InfoTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupViews];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    self.mainImage = [[UIImageView alloc]init];
    self.subtitleImage = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"image"]];
    self.title = [[UILabel alloc]init];
    self.subTitle = [[UILabel alloc]init];
   
    self.mainImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.mainImage];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.mainImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.mainImage.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.mainImage.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.mainImage.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
//        [self.mainImage.heightAnchor constraintEqualToAnchor:self.heightAnchor],
//        [self.mainImage.widthAnchor constraintEqualToAnchor:self.widthAnchor],
    ]];
    
    
}

@end
