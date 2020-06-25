//
//  DetailViewController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "DetailViewController.h"
#import "UIColor+HexString.h"

#import "MediaManager.h"
#import "MediaObject.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"


@interface DetailViewController ()

@property (nonatomic, strong) UIStackView *textStackView;
@property (nonatomic, strong) UIStackView *mainStackView;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *creationDate;
@property (nonatomic, strong) NSString *modificationDate;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollContentView;


@property(nonatomic , strong) MediaManager *mediaManager;
@property (nonatomic, strong) UIButton *playVideoButton;

@end

@implementation DetailViewController

- (instancetype)initWithInfo:(UIImage *)image creationDate:(NSString *)creationDate modificationDate:(NSString *)modificationDate type:(NSString *)type {
    self = [super init];
    if (self) {
        _image = image;
        _creationDate = creationDate;
        _modificationDate = modificationDate;
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.appWhiteColor;
     [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
   
    
}

- (void)setupViews {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.scrollView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
    
    self.scrollContentView = [[UIView alloc]init];
    [self.scrollView addSubview:self.scrollContentView];
    self.scrollContentView.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollContentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.scrollContentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.scrollContentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.scrollContentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
    ]];
    
#pragma mark: - DetailImageView
    
    self.detailImageView = [[UIImageView alloc]init];
    
    UIImage *newImage = [self resizeImage:self.image newWidth:self.view.frame.size.width];
    self.image = newImage;
    self.detailImageView.image = self.image;
    
    self.creationDateField = [[UILabel alloc]init];
    
    self.creationDateField.text = [NSString stringWithFormat:@"Creation date: %@", self.creationDate];
    self.creationDateField.textColor = [UIColor appBlackColor];
    
    NSMutableAttributedString *dataFieldText = [[NSMutableAttributedString alloc] initWithAttributedString: self.creationDateField.attributedText];
    [dataFieldText addAttribute:NSForegroundColorAttributeName
                          value:[UIColor appGrayColor]
                          range:NSMakeRange(0, 13)];
    [self.creationDateField setAttributedText: dataFieldText];
    
    self.modificationDateField = [[UILabel alloc]init];
    self.modificationDateField.text = [NSString stringWithFormat:@"Modification date: %@", self.modificationDate];
    self.modificationDateField.textColor = [UIColor appBlackColor];
    
    NSMutableAttributedString *modificationFieldText = [[NSMutableAttributedString alloc] initWithAttributedString: self.modificationDateField.attributedText];
    [modificationFieldText addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor appGrayColor]
                                  range:NSMakeRange(0, 18)];
    [self.modificationDateField setAttributedText: modificationFieldText];
    
    self.typeField = [[UILabel alloc]init];
    self.typeField.text = [NSString stringWithFormat:@"Type: %@", self.type];
    self.typeField.textColor = [UIColor appBlackColor];
    
    NSMutableAttributedString *typeFieldText = [[NSMutableAttributedString alloc] initWithAttributedString: self.typeField.attributedText];
    [typeFieldText addAttribute:NSForegroundColorAttributeName
                          value:[UIColor appGrayColor]
                          range:NSMakeRange(0, 5)];
    [self.typeField setAttributedText: typeFieldText];
    
    
    self.textStackView = [[UIStackView alloc]init];
    self.textStackView.axis = UILayoutConstraintAxisVertical;
    self.textStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.textStackView.alignment = UIStackViewAlignmentLeading;
    self.textStackView.spacing = 10;
    self.textStackView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.textStackView addArrangedSubview:self.creationDateField];
    [self.textStackView addArrangedSubview:self.modificationDateField];
    [self.textStackView addArrangedSubview:self.typeField];
    
    [self.textStackView.widthAnchor constraintEqualToConstant:self.image.size.width - 30].active = true;
    
    self.textStackView.backgroundColor = [UIColor appGrayColor];
    
#pragma mark: - ShareButton
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.backgroundColor = [UIColor appYellowColor];
    [self.shareButton setTitle:@"Share" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor appBlackColor] forState:UIControlStateNormal];
    [self.shareButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight: UIFontWeightMedium]];
    [self.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    //    Button layer config
    self.shareButton.layer.cornerRadius = 25;
    self.shareButton.clipsToBounds = YES;
    
    self.shareButton.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.shareButton.heightAnchor constraintEqualToConstant:55].active = true;
    [self.shareButton.widthAnchor constraintEqualToConstant:self.view.frame.size.width - self.view.frame.size.width  /4  ].active = true;
    
    self.mainStackView = [[UIStackView alloc]init];
    self.mainStackView.axis = UILayoutConstraintAxisVertical;
    self.mainStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.mainStackView.alignment = UIStackViewAlignmentCenter;
    self.mainStackView.spacing = 30;
    self.mainStackView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.mainStackView addArrangedSubview:self.detailImageView];
    [self.mainStackView addArrangedSubview:self.textStackView];
    [self.mainStackView addArrangedSubview:self.shareButton];
    
    
    [self.scrollContentView addSubview:self.mainStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.mainStackView.topAnchor constraintEqualToAnchor:self.scrollContentView.topAnchor constant: 15],
        [self.mainStackView.rightAnchor constraintEqualToAnchor:self.scrollContentView.rightAnchor constant:-15],
        [self.mainStackView.leftAnchor constraintEqualToAnchor:self.scrollContentView.leftAnchor constant:15],
        [self.mainStackView.bottomAnchor constraintEqualToAnchor:self.scrollContentView.bottomAnchor constant:-15],
        
        [self.mainStackView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:  - 30],
        
    ]];
    
    if (self.asset.mediaType == PHAssetMediaTypeVideo) {
         
             [self.detailImageView setUserInteractionEnabled:YES];
             
             self.playVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
             [self.playVideoButton setImage:[UIImage imageNamed:@"playVideo"] forState:UIControlStateNormal];
             self.playVideoButton.backgroundColor = [UIColor appYellowColor];
             self.playVideoButton.alpha = 0.8;

             [self.playVideoButton addTarget:self action:@selector(showVideo) forControlEvents:UIControlEventTouchUpInside];

             self.playVideoButton.translatesAutoresizingMaskIntoConstraints = NO;
             self.playVideoButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
             [self.detailImageView addSubview:self.playVideoButton];
             
            self.playVideoButton.layer.cornerRadius = 35;
            self.playVideoButton.clipsToBounds = YES;
             
             [NSLayoutConstraint activateConstraints:@[
                 [self.playVideoButton.centerXAnchor constraintEqualToAnchor:self.detailImageView.centerXAnchor],
                 [self.playVideoButton.centerYAnchor constraintEqualToAnchor:self.detailImageView.centerYAnchor],
                 [self.playVideoButton.heightAnchor constraintEqualToConstant:70],
                 [self.playVideoButton.widthAnchor constraintEqualToConstant:70],
             ]];
     }
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

- (void)backPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
};


- (void)share {
    
    NSMutableArray *activityItems= [NSMutableArray arrayWithObjects:self.image, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop];
    
    if (@available (iOS 13,*)) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            [self presentViewController:activityViewController animated:YES completion:nil];
        } else {
            activityViewController.modalPresentationStyle = UIModalPresentationPopover;
            activityViewController.popoverPresentationController.sourceView = self.shareButton;
            [self presentViewController:activityViewController animated:YES completion:nil];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self presentViewController:activityViewController animated:YES completion:nil];
        } else {
            activityViewController.modalPresentationStyle = UIModalPresentationPopover;
            activityViewController.popoverPresentationController.sourceView = self.shareButton;
            [self presentViewController:activityViewController animated:YES completion:nil];
        }
    }
}

- (void)showVideo {
    
    PHAsset *asset = self.asset;
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *videoOptions = [PHVideoRequestOptions new];
        [[PHImageManager defaultManager] requestPlayerItemForVideo:asset options:videoOptions resultHandler:^(AVPlayerItem *playerItem, NSDictionary *info) {
            AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
            
//            AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer: player];
//            layer.frame = self.view.layer.bounds;
//            UIView *newView = [[UIView alloc] initWithFrame:self.detailImageView.bounds];
//            [newView.layer addSublayer:layer];
//            [self.detailImageView addSubview:newView];
//            [player play];
            AVPlayerViewController *playerViewController = [AVPlayerViewController new];
            playerViewController.player = player;
            [self presentViewController:playerViewController animated:YES completion:^{
                [playerViewController.player play];
            }];
        }];
    }
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
