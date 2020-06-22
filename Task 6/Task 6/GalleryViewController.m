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

@interface GalleryViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) int numberOfItems;
@property (nonatomic , strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *creationDateArray;
@property (nonatomic, strong) NSMutableArray *modificationDateArray;
@property (nonatomic, strong) NSMutableArray *typeArray;

@property (nonatomic , strong) PHFetchResult *assetsFetchResults;
@property (nonatomic , strong) PHCachingImageManager *imageManager;

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagesArray = [NSMutableArray array];
    self.creationDateArray = [NSMutableArray array];
    self.modificationDateArray = [NSMutableArray array];
    self.typeArray = [NSMutableArray array];
    
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
    
    // Fetch all assets, sorted by date created.
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    self.imageManager = [[PHCachingImageManager alloc] init];
    
    [self.collectionView setContentInset:UIEdgeInsetsMake(5, 5, 5, 5)];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    if (asset.sourceType == PHAssetMediaTypeImage) {
        NSLog(@"1");
    } else if (asset.sourceType == PHAssetMediaTypeImage) {
        NSLog(@"2");
    } else if (asset.sourceType == PHAssetMediaTypeVideo) {
        NSLog(@"3");
    }

//    NSDateFormatter* df = [[NSDateFormatter alloc]init];
//    [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
//    NSString *creationDate = [df stringFromDate:asset.creationDate];
//    NSString *modification = [df stringFromDate:asset.creationDate];
//
//    [self.creationDateArray addObject:creationDate];
//    [self.modificationDateArray addObject:modification];
////    [self.typeArray addObject:asset];
//
//        [self.imageManager requestImageDataAndOrientationForAsset:asset
//                                                          options:nil
//                                                    resultHandler:^(NSData *imageData, NSString *dataUTI, CGImagePropertyOrientation orientation, NSDictionary *info) {
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIImage *image = [UIImage imageWithData:imageData];
//                [self.imagesArray addObject:image];
//                cell.imageView.image = image;
//            });
//        }];
    
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
    CGFloat width = (self.collectionView.frame.size.width - 10 - ((self.numberOfItems-1) * 5))  / (self.numberOfItems);
    return CGSizeMake(width, width);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        self.numberOfItems = 5;
    }
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        self.numberOfItems = 3;
    }
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    PHFetchOptions *options = [[PHFetchOptions alloc]init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    [self.imagesArray removeAllObjects];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc]initWithInfo:self.imagesArray[indexPath.row] creationDate:self.creationDateArray[indexPath.row] modificationDate:self.modificationDateArray[indexPath.row] type:@"Image"];
    
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



@end
