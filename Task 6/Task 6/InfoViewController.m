//
//  InfoViewController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/20/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "InfoViewController.h"
#import <Photos/Photos.h>
#import "InfoTVC.h"
#import "DetailViewController.h"

@interface InfoViewController ()
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic , strong) PHFetchResult *assetsFetchResults;
@property(nonatomic , strong) PHCachingImageManager *imageManager;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [PHImageManager defaultManager];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    self.imageManager = [[PHCachingImageManager alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assetsFetchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
 
    
    if (asset) {
//        PHImageRequestOptions * imageRequestOptions = [[PHImageRequestOptions alloc] init];
//        imageRequestOptions.synchronous = YES;
        [self.imageManager requestImageDataAndOrientationForAsset:asset
                                                          options:nil
                                                    resultHandler:^(NSData *imageData, NSString *dataUTI, CGImagePropertyOrientation orientation, NSDictionary *info) {
      
            cell.textLabel.text = dataUTI;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lux%lu", asset.pixelHeight, asset.pixelWidth];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:imageData];
                cell.imageView.image = image;
            });
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.navigationController pushViewController:self.navigationController. animated:true];
//}


- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    PHFetchOptions *options = [[PHFetchOptions alloc]init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
