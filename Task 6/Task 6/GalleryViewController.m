//
//  GalleryViewController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/20/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryCVC.h"
#import <Photos/Photos.h>
#import "DetailViewController.h"
#import "MediaObject.h"
#import "MediaManager.h"
#import "ModalViewController.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"
#import "UIColor+HexString.h"

@interface GalleryViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) int numberOfItems;
@property (nonatomic , strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *creationDateArray;
@property (nonatomic, strong) NSMutableArray *modificationDateArray;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *nameArray;

@property (nonatomic, strong) MediaManager *mediaManager;
@property (nonatomic, strong) MediaObject *mediaObject;

@property (nonatomic , strong) PHFetchResult *assetsFetchResults;
@property (nonatomic , strong) PHImageManager *imageManager;


@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Fetch all assets, sorted by date created.
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
    
    if (self.view.frame.size.height>self.view.frame.size.width) {
        self.numberOfItems = 5;
    }
    else{
        self.numberOfItems = 3;
    }
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
     
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    [self.mediaManager downloadAsset:asset completion:^(MediaObject *object) {
        
        
        [self.imagesArray addObject:object.objectImage];
        [self.nameArray addObject:object.objectName];
        [self.creationDateArray addObject:object.creationDate];
        [self.modificationDateArray addObject:object.modificationDate];
        [self.typeArray addObject:object.objectType];
//        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = object.objectImage;
//        });
    }];
    //    });
    return cell;
}
- (NSString *)formatTimeFromSeconds:(NSInteger)numberOfSeconds {
    
    NSInteger seconds = numberOfSeconds % 60;
    NSInteger minutes = (numberOfSeconds / 60) % 60;
    NSInteger hours = numberOfSeconds / 3600;
    
    if (hours) {
        return [NSString stringWithFormat:@"%2ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    }
    if (minutes) {
        return [NSString stringWithFormat:@"%2ld:%02ld", (long)minutes, (long)seconds];
    }
    return [NSString stringWithFormat:@"0:%02ld", (long)seconds];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsFetchResults.count;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.view.frame.size.height>self.view.frame.size.width) {
        self.numberOfItems = 3;
    }
    else{
        self.numberOfItems = 5;
    }
    
    CGFloat width = (self.view.frame.size.width - 10 - (self.numberOfItems-1) * 5) / self.numberOfItems;
    return CGSizeMake(width, width);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        self.numberOfItems = 5;
    }
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        self.numberOfItems = 3;
    }
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ModalViewController *notificationVC = [[ModalViewController alloc] init];
    GalleryCVC *cell = [GalleryCVC new];
    
//    This row call Xcode warning "Incompatible pointer types assigning to 'GalleryCVC *' from 'UICollectionViewCell * _Nullable'"
    cell = [collectionView cellForItemAtIndexPath:indexPath];
    notificationVC.image = cell.imageView.image;
    
    
//    notificationVC.image = self.imagesArray[indexPath.row];
    notificationVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    notificationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    PHAsset *asset = self.assetsFetchResults[indexPath.row];
    
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *videoOptions = [PHVideoRequestOptions new];
        [[PHImageManager defaultManager] requestPlayerItemForVideo:asset options:videoOptions resultHandler:^(AVPlayerItem *playerItem, NSDictionary *info) {
            AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
            AVPlayerViewController *playerViewController = [AVPlayerViewController new];
            playerViewController.player = player;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:playerViewController animated:YES completion:^{
                    [playerViewController.player play];
                }];
            });
        }];
    } else {
        [self presentViewController:notificationVC animated:YES completion:nil];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    if (PHPhotoLibrary.authorizationStatus == PHAuthorizationStatusAuthorized) {
//        dispatch_async(dispatch_get_main_queue(), ^{
            PHFetchOptions *options = [[PHFetchOptions alloc] init];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        
        [self.imagesArray removeAllObjects];
        [self.creationDateArray removeAllObjects];
        [self.typeArray removeAllObjects];
        [self.modificationDateArray removeAllObjects];
        [self.nameArray removeAllObjects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
              [self.collectionView reloadData];
          });
//        });
    } else {
        return;
    }
//
//    PHFetchOptions *options = [[PHFetchOptions alloc]init];
//    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
//    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
//

    
  
}

- (void)setupViews {
    
    
    self.imagesArray = [NSMutableArray array];
    self.creationDateArray = [NSMutableArray array];
    self.modificationDateArray = [NSMutableArray array];
    self.typeArray = [NSMutableArray array];
    self.nameArray = [NSMutableArray array];
    
    self.imageManager = [PHImageManager defaultManager];
    self.mediaManager = [[MediaManager alloc]init];
    self.mediaObject = [[MediaObject alloc]init];
    
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(50, 50);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 5, 0)];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[GalleryCVC class] forCellWithReuseIdentifier:@"Cell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.collectionView setContentInset:UIEdgeInsetsMake(5, 5, 5, 5)];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
            [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
            [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
    
}



@end
