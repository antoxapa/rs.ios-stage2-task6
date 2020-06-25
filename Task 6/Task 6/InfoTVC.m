//
//  InfoTVC.m
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "InfoTVC.h"
#import "UIColor+HexString.h"

@interface InfoTVC ()

@property (nonatomic, strong) UIStackView *textStackView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *subtitleView;

@end

@implementation InfoTVC

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupViews];
    return self;
}

- (void)setupViews {
    
    self.textStackView = [UIStackView new];
    self.textStackView.axis = UILayoutConstraintAxisVertical;
    self.textStackView.distribution = UIStackViewDistributionFillEqually;
    self.textStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.titleView = [UIView new];
    self.subtitleView = [UIView new];
    
    UIView *selectedView = [[UIView alloc]initWithFrame:self.contentView.frame];
    selectedView.backgroundColor = [UIColor appYellowHighlightedColor];
    self.selectedBackgroundView = selectedView;
    
    self.mainImage = [[UIImageView alloc]init];
    self.mainImage.contentMode = UIViewContentModeScaleToFill;
    
    self.mainImage.clipsToBounds = YES;
   
    self.title = [[UILabel alloc]init];
    self.title.textColor = [UIColor appBlackColor];
    [self.title setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]];
    
    self.subTitle = [[UILabel alloc]init];
     self.subtitleImage = [[UIImageView alloc]init];
    [self.subTitle setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular]];
   
    self.mainImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.title.translatesAutoresizingMaskIntoConstraints = NO;
    self.subTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtitleImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.titleView addSubview:self.title];
    [self.subtitleView addSubview:self.subtitleImage];
    [self.subtitleView addSubview:self.subTitle];
    
    [self.textStackView addArrangedSubview:self.titleView];
    [self.textStackView addArrangedSubview:self.subtitleView];
    
    [self addSubview: self.mainImage];
    [self addSubview:self.textStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.mainImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:8],
        [self.mainImage.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.mainImage.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
        [self.mainImage.widthAnchor constraintEqualToAnchor:self.heightAnchor constant:-5],
        
        [self.textStackView.leadingAnchor constraintEqualToAnchor: self.mainImage.trailingAnchor constant:self.frame.size.height /3],
        [self.textStackView.topAnchor constraintEqualToAnchor:self.mainImage.topAnchor],
        [self.textStackView.bottomAnchor constraintEqualToAnchor:self.mainImage.bottomAnchor],
        
        [self.title.leadingAnchor constraintEqualToAnchor:self.titleView.leadingAnchor],
        [self.title.bottomAnchor constraintEqualToAnchor:self.titleView.bottomAnchor constant:-5],
        
        [self.subtitleImage.leadingAnchor constraintEqualToAnchor:self.subtitleView.leadingAnchor],
        [self.subtitleImage.topAnchor constraintEqualToAnchor:self.subtitleView.topAnchor constant:5],
        
        [self.subTitle.leadingAnchor constraintEqualToAnchor:self.subtitleImage.trailingAnchor constant:5],
        [self.subTitle.centerYAnchor constraintEqualToAnchor: self.subtitleImage.centerYAnchor],
    ]];
}

@end
