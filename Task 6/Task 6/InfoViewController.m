//
//  InfoViewController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/20/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoTVC.h"
#import "DetailViewController.h"
#import "MediaManager.h"
#import "MediaObject.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"
#import <Photos/Photos.h>


@interface InfoViewController ()
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic , strong) PHFetchResult *assetsFetchResults;
@property(nonatomic , strong) MediaManager *mediaManager;

@property (nonatomic , strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *creationDateArray;
@property (nonatomic, strong) NSMutableArray *modificationDateArray;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *sizeArray;
@property (nonatomic, strong) NSMutableArray *durationArray;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.imagesArray = [NSMutableArray array];
    self.creationDateArray = [NSMutableArray array];
    self.modificationDateArray = [NSMutableArray array];
    self.typeArray = [NSMutableArray array];
    self.nameArray = [NSMutableArray array];
    self.sizeArray = [NSMutableArray array];
    self.durationArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setContentInset:UIEdgeInsetsMake(8, 0, 0, 0)];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
    
    
    [self.tableView registerClass:[InfoTVC class] forCellReuseIdentifier:@"Cell"];
    
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    self.mediaManager = [[MediaManager alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (PHAsset *asset in self.assetsFetchResults) {
               [self.mediaManager downloadAsset:asset completion:^(MediaObject *object) {
                   [self.imagesArray addObject:object.objectImage];
                   [self.creationDateArray addObject:object.creationDate];
                   [self.modificationDateArray addObject:object.modificationDate];
                   [self.typeArray addObject:object.objectType];
                   [self.nameArray addObject:object.objectName];
                   [self.sizeArray addObject:object.objectSize];
                   [self.durationArray addObject:object.objectDuration];
               }];
           }
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assetsFetchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTVC * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
//    InfoTVC * cell = (InfoTVC *)[tableView cellForRowAtIndexPath:indexPath];
//    dispatch_async(dispatch_get_main_queue(), ^{
        
        cell.mainImage.image = self.imagesArray[indexPath.row];
        cell.title.text = self.nameArray[indexPath.row];
        NSString *duration = self.durationArray[indexPath.row];
        if ([self.typeArray[indexPath.row]  isEqual: @"Video"]) {
            
            cell.subTitle.text = [NSString stringWithFormat:@"%@ %@", self.sizeArray[indexPath.row], [self formatTimeFromSeconds:duration.integerValue]];
            cell.subtitleImage.image = [UIImage imageNamed:@"video"];
            
        } else if ([self.typeArray[indexPath.row] isEqual: @"Image"]) {
            cell.subTitle.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", self.sizeArray[indexPath.row]]];
            cell.subtitleImage.image = [UIImage imageNamed:@"image"];
        } else if ([self.typeArray[indexPath.row]   isEqual: @"Audio"]) {
            cell.subTitle.text = [NSString stringWithFormat:@"%@", [self formatTimeFromSeconds:duration.integerValue]];
            cell.subtitleImage.image = [UIImage imageNamed:@"audio"];
        } else if ([self.typeArray[indexPath.row]   isEqual: @"Other"]) {
            cell.subTitle.text = @"";
            cell.subtitleImage.image = [UIImage imageNamed:@"other"];
        }
//    });
//}];
//    });

return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = 80;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        size = 120;
    }
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        size =  80;
    }
    
    return size;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailVC = [[DetailViewController alloc]initWithInfo:self.imagesArray[indexPath.row] creationDate:self.creationDateArray[indexPath.row] modificationDate:self.modificationDateArray[indexPath.row] type:self.typeArray[indexPath.row]];
    detailVC.asset = self.assetsFetchResults[indexPath.row];
    detailVC.hidesBottomBarWhenPushed = YES;
    [detailVC.navigationItem setTitle:self.nameArray[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    PHFetchOptions *options = [[PHFetchOptions alloc]init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSString *)formatTimeFromSeconds:(NSInteger)numberOfSeconds {
    
    NSInteger seconds = numberOfSeconds % 60;
    NSInteger minutes = (numberOfSeconds / 60) % 60;
    NSInteger hours = numberOfSeconds / 3600;
    
    if (hours) {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, seconds];
    }
    if (minutes) {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    }
    return [NSString stringWithFormat:@"00:%02ld", (long)seconds];
}



- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
