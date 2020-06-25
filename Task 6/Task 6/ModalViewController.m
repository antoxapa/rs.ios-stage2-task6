//
//  ModalViewController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/23/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()
@property (weak, nonatomic) UIView *contentView;
@property (weak, nonatomic) UILabel *notificationTitleLabel;
@property (strong, nonatomic) UIButton *dismissButton;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

-(void)setupView {
    self.imageView = [[UIImageView alloc]init];
    self.dismissButton = [[UIButton alloc]init];
    self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.60];
    self.contentView.layer.cornerRadius = 3.0;
    
    self.imageView.image = self.image;
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.dismissButton];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    UIImage *resizedImage = [self resizeImage:self.image newWidth:self.view.frame.size.width];
    self.imageView.image = resizedImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
            [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
            [self.imageView.heightAnchor constraintLessThanOrEqualToAnchor:self.view.heightAnchor],
            [self.imageView.widthAnchor constraintLessThanOrEqualToAnchor:self.view.widthAnchor],
            
            
            [self.dismissButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
            [self.dismissButton.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10],
            [self.dismissButton.widthAnchor constraintEqualToConstant:50],
            [self.dismissButton.heightAnchor constraintEqualToConstant:50],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
            [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
            [self.imageView.heightAnchor constraintLessThanOrEqualToAnchor:self.view.heightAnchor],
            [self.imageView.widthAnchor constraintLessThanOrEqualToAnchor:self.view.widthAnchor],
            
            
            [self.dismissButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10],
            [self.dismissButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
            [self.dismissButton.widthAnchor constraintEqualToConstant:50],
            [self.dismissButton.heightAnchor constraintEqualToConstant:50],
        ]];
    }
    
    self.dismissButton.layer.cornerRadius = 25;
    [self.dismissButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.dismissButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.dismissButton.backgroundColor = [UIColor blackColor];
    [self.dismissButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (void)dismissPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
