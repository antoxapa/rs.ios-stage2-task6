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


@interface StartViewController ()

@property (nonatomic, strong) UIStackView *figuresStackView;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UIView *squreView;
@property (nonatomic, strong) UIView *triangleView;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
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
    circleAnimation.fromValue = [NSNumber numberWithFloat:0.9];
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
    
#pragma mark: - QuestionLabel
    
    self.questionLabel = [[UILabel alloc]init];
    self.questionLabel.text = @"Are you ready?";
    self.questionLabel.textColor = [UIColor appBlackColor];
    self.questionLabel.textAlignment = NSTextAlignmentCenter;
    [self.questionLabel setFont:[UIFont systemFontOfSize:24 weight:UIFontWeightMedium]];
    self.questionLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.questionLabel];
    
    //   Label Layout
    [self.questionLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.questionLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.view.bounds.size.height / 6].active = true;
    
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
    self.triangleView.backgroundColor = UIColor.whiteColor;
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
    [self.view addSubview:self.figuresStackView];
    
    //   StackView Layout
    [self.figuresStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.figuresStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-(self.view.frame.size.height / 10)].active = true;
    
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
    [self.view addSubview:self.nextButton];
    
    //    Button layout
    [NSLayoutConstraint activateConstraints:@[
        [self.nextButton.heightAnchor constraintEqualToConstant:55],
        [self.nextButton.widthAnchor constraintEqualToAnchor:self.figuresStackView.widthAnchor],
        [self.nextButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.nextButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-(self.view.bounds.size.height / 5)],
    ]];
}

- (void)showNextVC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
