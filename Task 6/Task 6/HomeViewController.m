//
//  HomeViewController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/20/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "HomeViewController.h"
#import "TriangleView.h"
#import "UIColor+HexString.h"


@interface HomeViewController ()


@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIStackView *figuresStackView;
@property (nonatomic, strong) UIStackView *buttonsStackView;

@property (nonatomic, strong) UIView *infoContentView;
@property (nonatomic, strong) UIView *figuresContentView;
@property (nonatomic, strong) UIView *buttonsContentView;

@property (nonatomic, strong) UIImageView *appleImage;
@property (nonatomic, strong) UILabel *deviceNameLabel;
@property (nonatomic, strong) UILabel *deviceTypeLabel;
@property (nonatomic, strong) UILabel *iOSVersionLabel;

@property (nonatomic, strong) UIView *topSeparatorView;
@property (nonatomic, strong) UIView *bottomSeparatorView;

@property (nonatomic, strong) TriangleView *triangleView;
@property (nonatomic, strong) UIView *squareView;
@property (nonatomic, strong) UIView *circleView;

@property (nonatomic, strong) UIButton *openGitCVButton;
@property (nonatomic, strong) UIButton *openStartScreenButton;
@property (nonatomic, strong) UIView *openStartScreenContainerView;
@property (nonatomic, strong) UIView *openGitContainerView;

@property (nonatomic, weak) NSLayoutConstraint *bottomAcnhoreConstraint;
@property (nonatomic, weak) NSLayoutConstraint *topAnchoreConstraint;
@property (nonatomic, weak) NSLayoutConstraint *centerYConstraintForTop;
@property (nonatomic, weak) NSLayoutConstraint *centerYConstraintForBot;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    self.mainStackView = [[UIStackView alloc]init];
    self.mainStackView.axis = UILayoutConstraintAxisVertical;
    self.mainStackView.distribution = UIStackViewDistributionFillEqually;
    self.mainStackView.spacing = 0;
    
    //  Configure FiguresStackView
    self.figuresStackView = [[UIStackView alloc]init];
    self.figuresStackView.axis = UILayoutConstraintAxisHorizontal;
    self.figuresStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.figuresStackView.alignment = UIStackViewAlignmentCenter;
    self.figuresStackView.spacing = 30;
    
    //    Configure ButtonsStackView
    self.buttonsStackView = [[UIStackView alloc]init];
    self.buttonsStackView.distribution = UIStackViewDistributionFillEqually;

    if (self.view.frame.size.height>self.view.frame.size.width) {
              self.buttonsStackView.axis = UILayoutConstraintAxisVertical;
          }
          else{
              self.buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
       }
       [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [self startAnimation];
}

- (void) setupViews {
    
#pragma mark: - Configure StackViews

    
#pragma mark: - InfoContentView Views
    
    //    Configure contentView
    self.infoContentView = [[UIView alloc]init];
    
    //    Configure InfoViews
    self.appleImage = [[UIImageView alloc] init];
    
    //    Configure deviceNameLabel
    self.deviceNameLabel = [[UILabel alloc]init];
    self.deviceNameLabel.text =  [[UIDevice currentDevice] name];
    self.deviceNameLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    
    //    Configure deviceTypeLabel
    self.deviceTypeLabel = [[UILabel alloc]init];
    self.deviceTypeLabel.text = [[UIDevice currentDevice] model];
    self.deviceTypeLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    
    //    Configure iosVersionLabel
    self.iOSVersionLabel = [[UILabel alloc]init];
    self.iOSVersionLabel.text = [NSString stringWithFormat:@"%@ %@",[[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    self.iOSVersionLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    
    //    Configure TranslatesMasks InfoView items
    self.infoContentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.iOSVersionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    //    Add subviews in InfoContentView
    [self.infoContentView addSubview:self.appleImage];
    [self.infoContentView addSubview:self.deviceNameLabel];
    [self.infoContentView addSubview:self.deviceTypeLabel];
    [self.infoContentView addSubview:self.iOSVersionLabel];
    
    [self.mainStackView addArrangedSubview:self.infoContentView];
    
    UIImage *newApleImage = [self resizeImage:[UIImage imageNamed:@"apple"] newWidth:80];
    self.appleImage.image = newApleImage;
    
    
    self.figuresContentView = [[UIView alloc]init];
    self.figuresContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
#pragma mark: - Top Separator Views
    
    //    Configure TopSeparatorView
    self.topSeparatorView = [[UIView alloc]init];
    self.topSeparatorView.backgroundColor = [UIColor appGrayColor];
    self.topSeparatorView.alpha = 0.3;
    self.topSeparatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.figuresContentView addSubview:self.topSeparatorView];
    
    
#pragma mark: - FiguresStackView Views
    
    
    //  Configure CircleView
    self.circleView = [[UIView alloc] init];
    self.circleView.backgroundColor = [UIColor appRedColor];
    self.circleView.layer.cornerRadius = 35;
    self.circleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.circleView.heightAnchor constraintEqualToConstant:70].active = true;
    [self.circleView.widthAnchor constraintEqualToConstant:70].active = true;
    
    //  Configure SquareView
    self.squareView = [[UIView alloc] init];
    self.squareView.backgroundColor = [UIColor appBlueColor];
    self.squareView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.squareView.heightAnchor constraintEqualToConstant:70].active = true;
    [self.squareView.widthAnchor constraintEqualToConstant:70].active = true;
    
    //  Configure TriangleView
    self.triangleView = [[TriangleView alloc]init];
    self.triangleView.backgroundColor = UIColor.whiteColor;
    self.triangleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.triangleView.heightAnchor constraintEqualToConstant:70].active = true;
    [self.triangleView.widthAnchor constraintEqualToConstant:70].active = true;
    
    //    Add subviews in FiguresStackView
    [self.figuresStackView addArrangedSubview:self.circleView];
    [self.figuresStackView addArrangedSubview:self.squareView];
    [self.figuresStackView addArrangedSubview:self.triangleView];
    
    self.figuresStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.figuresContentView addSubview:self.figuresStackView];
    [self.figuresStackView.centerXAnchor constraintEqualToAnchor:self.figuresContentView.centerXAnchor].active = true;
    [self.figuresStackView.centerYAnchor constraintEqualToAnchor:self.figuresContentView.centerYAnchor].active = true;
    
    [self.mainStackView addArrangedSubview:self.figuresContentView];
    
#pragma mark: - Bottom separator View
    
    self.buttonsContentView = [[UIView alloc]init];
    self.buttonsContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.bottomSeparatorView = [[UIView alloc]init];
    self.bottomSeparatorView.backgroundColor = [UIColor appGrayColor];
    self.bottomSeparatorView.alpha = 0.3;
    
    self.bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.buttonsContentView addSubview:self.bottomSeparatorView];
    
#pragma mark: - Buttons View
    
    self.openGitContainerView = [UIView new];
    self.openGitContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.openStartScreenContainerView = [UIView new];
    self.openStartScreenContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.openGitCVButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openGitCVButton.backgroundColor = [UIColor appYellowColor];
    [self.openGitCVButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
    [self.openGitCVButton setTitleColor:[UIColor appBlackColor] forState:UIControlStateNormal];
    [self.openGitCVButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight: UIFontWeightSemibold]];
    
    [self.openGitCVButton addTarget:self action:@selector(openGitScreen) forControlEvents:UIControlEventTouchUpInside];
    
    //    Button layer config
    self.openGitCVButton.layer.cornerRadius = 25;
    self.openGitCVButton.clipsToBounds = YES;
    
    self.openStartScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openStartScreenButton.backgroundColor = [UIColor appRedColor];
    [self.openStartScreenButton setTitle:@"Go to start!" forState:UIControlStateNormal];
    [self.openStartScreenButton setTitleColor:[UIColor appWhiteColor] forState:UIControlStateNormal];
    [self.openStartScreenButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight: UIFontWeightSemibold]];
    [self.openStartScreenButton addTarget:self action:@selector(openStartScreen) forControlEvents:UIControlEventTouchUpInside];
    
    //    Button layer config
    self.openStartScreenButton.layer.cornerRadius = 25;
    self.openStartScreenButton.clipsToBounds = YES;
    
    self.openStartScreenButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.openGitCVButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.buttonsStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.buttonsContentView addSubview:self.buttonsStackView];
    
    [self.buttonsStackView addArrangedSubview:self.openGitContainerView];
    [self.buttonsStackView addArrangedSubview:self.openStartScreenContainerView];
    
    [self.openGitContainerView addSubview:self.openGitCVButton];
    [self.openStartScreenContainerView addSubview:self.openStartScreenButton];
    
    [self.mainStackView addArrangedSubview:self.buttonsContentView];
    self.mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.mainStackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.mainStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.mainStackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:40],
        [self.mainStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.mainStackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-30],
        [self.mainStackView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor constant: -70],
        
        [self.deviceTypeLabel.centerYAnchor constraintEqualToAnchor:self.infoContentView.centerYAnchor],
        [self.deviceTypeLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        
        [self.deviceNameLabel.leadingAnchor constraintEqualToAnchor:self.deviceTypeLabel.leadingAnchor],
        [self.deviceNameLabel.bottomAnchor constraintEqualToAnchor:self.deviceTypeLabel.topAnchor constant:-5],
        [self.iOSVersionLabel.leadingAnchor constraintEqualToAnchor:self.deviceTypeLabel.leadingAnchor],
        [self.iOSVersionLabel.topAnchor constraintEqualToAnchor:self.deviceTypeLabel.bottomAnchor constant:5],
        
        [self.appleImage.centerYAnchor constraintEqualToAnchor:self.infoContentView.centerYAnchor],
        [self.appleImage.trailingAnchor constraintEqualToAnchor:self.deviceTypeLabel.leadingAnchor constant:-30],
        [self.appleImage.widthAnchor constraintEqualToConstant:self.appleImage.image.size.width],
        [self.appleImage.heightAnchor constraintEqualToConstant:self.appleImage.image.size.height],
        
        [self.topSeparatorView.heightAnchor constraintEqualToConstant: 2],
        [self.topSeparatorView.topAnchor constraintEqualToAnchor: self.figuresContentView.topAnchor],
        [self.topSeparatorView.centerXAnchor constraintEqualToAnchor: self.figuresContentView.centerXAnchor],
        [self.topSeparatorView.widthAnchor constraintEqualToAnchor: self.mainStackView.widthAnchor],
        
        [self.bottomSeparatorView.heightAnchor constraintEqualToConstant: 2],
        [self.bottomSeparatorView.topAnchor constraintEqualToAnchor: self.buttonsContentView.topAnchor],
        [self.bottomSeparatorView.leadingAnchor constraintEqualToAnchor: self.buttonsContentView.leadingAnchor],
        [self.bottomSeparatorView.trailingAnchor constraintEqualToAnchor: self.buttonsContentView.trailingAnchor],
        [self.bottomSeparatorView.centerXAnchor constraintEqualToAnchor: self.buttonsContentView.centerXAnchor],
        
        [self.buttonsContentView.topAnchor constraintEqualToAnchor:self.buttonsStackView.topAnchor],
        [self.buttonsContentView.leadingAnchor constraintEqualToAnchor:self.buttonsStackView.leadingAnchor],
        [self.buttonsContentView.trailingAnchor constraintEqualToAnchor:self.buttonsStackView.trailingAnchor],
        [self.buttonsContentView.bottomAnchor constraintEqualToAnchor:self.buttonsStackView.bottomAnchor],
        
        [self.openGitCVButton.heightAnchor constraintEqualToConstant:55],
        [self.openGitCVButton.widthAnchor constraintEqualToAnchor: self.figuresStackView.widthAnchor],
        [self.openGitCVButton.centerXAnchor constraintEqualToAnchor: self.openGitContainerView.centerXAnchor],
        [self.openGitCVButton.centerYAnchor constraintEqualToAnchor: self.openGitContainerView.centerYAnchor],
        
        [self.openStartScreenButton.heightAnchor constraintEqualToConstant:55],
        [self.openStartScreenButton.widthAnchor constraintEqualToAnchor:self.figuresStackView.widthAnchor],
        [self.openStartScreenButton.centerXAnchor constraintEqualToAnchor: self.openStartScreenContainerView.centerXAnchor],
        [self.openStartScreenButton.centerYAnchor constraintEqualToAnchor: self.openStartScreenContainerView.centerYAnchor],
        
    ]];
    
    //
    //    self.bottomAcnhoreConstraint = [NSLayoutConstraint constraintWithItem:self.openGitCVButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.openGitContainerView attribute:NSLayoutAttributeBottom multiplier:1 constant:-15];
    //
    //    self.topAnchoreConstraint = [NSLayoutConstraint constraintWithItem:self.openStartScreenButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.openStartScreenContainerView attribute:NSLayoutAttributeTop multiplier:1 constant:15];
    //
    //    self.centerYConstraintForTop = [NSLayoutConstraint constraintWithItem:self.openGitCVButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.self.openGitContainerView attribute:NSLayoutAttributeCenterY multiplier:1 constant: 1];
    //
    //    self.centerYConstraintForBot = [NSLayoutConstraint constraintWithItem:self.openStartScreenButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.openStartScreenContainerView attribute:NSLayoutAttributeCenterY multiplier:1 constant: 1];
    //
    ////
    //
    ////    self.centerYConstraintForBot.active = false;
    ////    self.centerYConstraintForTop.active = false;
    ////    [self.openGitCVButton.bottomAnchor constraintEqualToAnchor: self.bottomAcnhoreConstraint].active = true;
    ////    [self.openStartScreenButton.topAnchor constraintEqualToAnchor: self.openStartScreenContainerView.topAnchor constant:+15],
    //
}

- (void)startAnimation {
    
#pragma mark: - Views Animation
    CABasicAnimation *circleAnimation;
    circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    circleAnimation.fromValue = [NSNumber numberWithFloat:0.9];
    circleAnimation.toValue = [NSNumber numberWithFloat:1.1];
    circleAnimation.duration  = 0.75;
    circleAnimation.repeatCount = INFINITY;
    circleAnimation.autoreverses = true;
    //    circleAnimation.removedOnCompletion = FALSE;
    
    CABasicAnimation *squareAnimation;
    squareAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    squareAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.squareView.center.x, self.squareView.center.y  - self.squareView.bounds.size.width * 0.1)];
    squareAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.squareView.center.x, self.squareView.center.y + self.squareView.bounds.size.width * 0.1)];;
    squareAnimation.duration = 0.75;
    squareAnimation.repeatCount = INFINITY;
    squareAnimation.autoreverses = true;
    //    squareAnimation.removedOnCompletion = FALSE;
    
    CABasicAnimation *triangleAnimation;
    triangleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    triangleAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    triangleAnimation.duration  = 4;
    triangleAnimation.repeatCount = INFINITY;
    //    triangleAnimation.removedOnCompletion = FALSE;
    
    [self.circleView.layer addAnimation:circleAnimation forKey:nil];
    [self.squareView.layer addAnimation:squareAnimation forKey:nil];
    [self.triangleView.layer addAnimation:triangleAnimation forKey:@"rotationAnimation"];
}

- (void) stopAnimation {
    NSLog(@"Animation removed");
    [self.circleView.layer removeAllAnimations];
    [self.squareView.layer removeAllAnimations];
    [self.triangleView.layer removeAllAnimations];
}
- (UIImage *)resizeImage:(UIImage *)image newWidth:(CGFloat)newWidth {
    
    double scale = newWidth / image.size.width;
    double newHeight = image.size.height * scale;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void) applicationWillEnterForeground {
    [self startAnimation];
}

- (void) applicationDidEnterBackground {
    [self stopAnimation];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        self.buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
    }
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        self.buttonsStackView.axis = UILayoutConstraintAxisVertical;
    }
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
}

- (void) openGitScreen {
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:@"https://antoxapa.github.io/rsschool-cv/cv"] options:@{} completionHandler:nil];
}

- (void) openStartScreen {
    [self stopAnimation];
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
