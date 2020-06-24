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
    
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
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
    self.numberOfItems = 3;
    [self.collectionView setContentInset:UIEdgeInsetsMake(5, 5, 5, 5)];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
           [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
           [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
           [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
           [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
       ]];
    
    
    // Fetch all assets, sorted by date created.
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    PHAsset *asset = self.assetsFetchResults[indexPath.item];


        [self.mediaManager downloadAsset:asset completion:^(MediaObject *object) {
               
             [self.imagesArray addObject:object.objectImage];
            [self.nameArray addObject:object.objectName];
                    [self.creationDateArray addObject:object.creationDate];
                    [self.modificationDateArray addObject:object.modificationDate];
                    [self.typeArray addObject:object.objectType];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.imageView.image = object.objectImage;
                    });
           }];

   
    return cell;
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
        notificationVC.image = self.imagesArray[indexPath.row];
        notificationVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        notificationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:notificationVC animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    PHFetchOptions *options = [[PHFetchOptions alloc]init];
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
}



@end
