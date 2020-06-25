//
//  StartViewController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/19/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "StartViewController.h"
#import "TriangleView.h"
#import "UIColor+HexString.h"
#import "MediaManager.h"
#import "CustonTabBarController.h"


@interface StartViewController ()

@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UIView *figuresView;
@property (nonatomic, strong) UIView *buttonView;

@property (nonatomic, strong) UIStackView *figuresStackView;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UIView *squreView;
@property (nonatomic, strong) TriangleView *triangleView;
@property (nonatomic, strong) UIButton *nextButton;


@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [self addSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self startAnimation];
}

- (void)startAnimation {
    
#pragma mark: - Views Animation
    CABasicAnimation *circleAnimation;
    circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    //    circleAnimation.fromValue = [NSNumber numberWithFloat:0.9];
    circleAnimation.fromValue = [NSNumber numberWithFloat:1];
    circleAnimation.toValue = [NSNumber numberWithFloat:0.9];
    circleAnimation.toValue = [NSNumber numberWithFloat:1.1];
    circleAnimation.duration  = 0.75;
    circleAnimation.repeatCount = INFINITY;
    circleAnimation.autoreverses = true;
    
    CABasicAnimation *squareAnimation;
    squareAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    squareAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.squreView.center.x, self.squreView.center.y  - self.squreView.bounds.size.width * 0.1)];
    squareAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.squreView.center.x, self.squreView.center.y + self.squreView.bounds.size.width * 0.1)];;
    squareAnimation.duration = 0.75;
    squareAnimation.repeatCount = INFINITY;
    squareAnimation.autoreverses = true;
    
    CABasicAnimation *triangleAnimation;
    triangleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    triangleAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    triangleAnimation.duration  = 4;
    triangleAnimation.repeatCount = INFINITY;
    
    
    [self.circleView.layer addAnimation:circleAnimation forKey:nil];
    [self.squreView.layer addAnimation:squareAnimation forKey:nil];
    [self.triangleView.layer addAnimation:triangleAnimation forKey:@"rotationAnimation"];
}

- (void) stopAnimation {
    NSLog(@"Animation removed");
    [self.circleView.layer removeAllAnimations];
    [self.squreView.layer removeAllAnimations];
    [self.triangleView.layer removeAllAnimations];
}

- (void)addSubviews {
    
    self.mainStackView = [[UIStackView alloc]init];
    self.mainStackView.axis = UILayoutConstraintAxisVertical;
    self.mainStackView.distribution = UIStackViewDistributionFillEqually;
    
    self.labelView = [UIView new];
    self.buttonView = [UIView new];
    self.figuresView = [UIView new];
    
#pragma mark: - QuestionLabel
    
    self.questionLabel = [[UILabel alloc]init];
    self.questionLabel.text = @"Are you ready?";
    self.questionLabel.textColor = [UIColor appBlackColor];
    self.questionLabel.textAlignment = NSTextAlignmentCenter;
    [self.questionLabel setFont:[UIFont systemFontOfSize:24 weight:UIFontWeightMedium]];
    self.questionLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.labelView addSubview:self.questionLabel];
    //    [self.view addSubview:self.questionLabel];
    [self.mainStackView addArrangedSubview:self.labelView];
    
    //   Label Layout
    [self.questionLabel.centerXAnchor constraintEqualToAnchor:self.labelView.centerXAnchor].active = true;
    //    [self.questionLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.view.bounds.size.height / 6].active = true;
    [self.questionLabel.centerYAnchor constraintEqualToAnchor:self.labelView.centerYAnchor constant:15].active = true;
    
    
#pragma mark: - Views and FiguresStackView
    //  Configure CircleView
    self.circleView = [[UIView alloc] init];
    self.circleView.backgroundColor = [UIColor appRedColor];
    self.circleView.layer.cornerRadius = 35;
    [self.circleView.heightAnchor constraintEqualToConstant:70].active = true;
    [self.circleView.widthAnchor constraintEqualToConstant:70].active = true;
    
    //  Configure SquareView
    self.squreView = [[UIView alloc] init];
    self.squreView.backgroundColor = [UIColor appBlueColor];
    [self.squreView.heightAnchor constraintEqualToConstant:70].active = true;
    [self.squreView.widthAnchor constraintEqualToConstant:70].active = true;
    
    //  Configure TriangleView
    self.triangleView = [[TriangleView alloc]init];
    self.triangleView.backgroundColor = UIColor.clearColor;
    [self.triangleView.heightAnchor constraintEqualToConstant:70].active = true;
    [self.triangleView.widthAnchor constraintEqualToConstant:70].active = true;
    
    //  Configure FiguresStackView
    self.figuresStackView = [[UIStackView alloc]init];
    self.figuresStackView.axis = UILayoutConstraintAxisHorizontal;
    self.figuresStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.figuresStackView.alignment = UIStackViewAlignmentCenter;
    self.figuresStackView.spacing = 30;
    self.figuresStackView.translatesAutoresizingMaskIntoConstraints = false;
    
    //    Add subviews in FiguresStackView
    [self.figuresStackView addArrangedSubview:self.circleView];
    [self.figuresStackView addArrangedSubview:self.squreView];
    [self.figuresStackView addArrangedSubview:self.triangleView];
    
    //    Add subviews in rootView
    //    [self.view addSubview:self.figuresStackView];
    [self.figuresView addSubview:self.figuresStackView];
    [self.mainStackView addArrangedSubview:self.figuresView];
    
    //   StackView Layout
    [self.figuresStackView.centerXAnchor constraintEqualToAnchor:self.figuresView.centerXAnchor].active = true;
    [self.figuresStackView.topAnchor constraintEqualToAnchor:self.figuresView.topAnchor].active = true;
    
    
    
#pragma mark: - NextButton
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.backgroundColor = [UIColor appYellowColor];
    [self.nextButton setTitle:@"START" forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor appBlackColor] forState:UIControlStateNormal];
    [self.nextButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight: UIFontWeightMedium]];
    [self.nextButton addTarget:self action:@selector(showNextVC) forControlEvents:UIControlEventTouchUpInside];
    
    //    Button layer config
    self.nextButton.layer.cornerRadius = 25;
    self.nextButton.clipsToBounds = YES;
    
    self.nextButton.translatesAutoresizingMaskIntoConstraints = false;
    //    [self.view addSubview:self.nextButton];
    [self.buttonView addSubview:self.nextButton];
    [self.mainStackView addArrangedSubview:self.buttonView];
    [self.view addSubview:self.mainStackView];
    self.mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.mainStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [self.mainStackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
            [self.mainStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
            [self.mainStackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
            [self.mainStackView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.mainStackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50],
            [self.mainStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.mainStackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-50],
            [self.mainStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.mainStackView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        ]];
    }
    
    //    Button layout
    [NSLayoutConstraint activateConstraints:@[
        [self.nextButton.heightAnchor constraintEqualToConstant:55],
        [self.nextButton.widthAnchor constraintEqualToAnchor:self.figuresStackView.widthAnchor],
        [self.nextButton.centerXAnchor constraintEqualToAnchor:self.buttonView.centerXAnchor],
        [self.nextButton.topAnchor constraintEqualToAnchor:self.buttonView.topAnchor constant: 30],
    ]];
    
}

- (void)showNextVC {
    UITabBarController *mainTBC = [CustonTabBarController new];
    
    [self.navigationController pushViewController:mainTBC animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) applicationWillEnterForeground {
    [self startAnimation];
}

//- (void) applicationDidEnterBackground {
////    [self stopAnimation];
//}

@end
