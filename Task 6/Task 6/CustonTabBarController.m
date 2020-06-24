//
//  CustonTabBarController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/20/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "CustonTabBarController.h"
#import "InfoViewController.h"
#import "GalleryViewController.h"
#import "HomeViewController.h"
#import "UIColor+HexString.h"
#import "CustomNavController.h"

@interface CustonTabBarController ()

@property (nonatomic, strong) CustomNavController *firstVC;
@property (nonatomic, strong) CustomNavController *secondVC;
@property (nonatomic, strong) CustomNavController *thirdVC;

@end

@implementation CustonTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.tabBar.tintColor = [UIColor appBlackColor];

#pragma mark: - Setup TabBarItems
    InfoViewController *infoVC = [[InfoViewController alloc]init];
    infoVC.view.backgroundColor = [UIColor appWhiteColor];
    infoVC.title = @"Info";
    UITabBarItem *infoTab = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"info_unselected"] selectedImage:[UIImage imageNamed:@"info_selected"]];
    infoVC.tabBarItem = infoTab;
    
    self.firstVC = [[CustomNavController alloc]initWithRootViewController:infoVC];
    self.firstVC.navigationBar.barTintColor = [UIColor appYellowColor];
    
    
    GalleryViewController *galleryVC = [[GalleryViewController alloc]init];
    galleryVC.title = @"Gallery";
    galleryVC.view.backgroundColor = [UIColor appWhiteColor];
    UITabBarItem *galleryTab = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"gallery_unselected"] selectedImage:[UIImage imageNamed:@"gallery_selected"]];
    galleryVC.tabBarItem = galleryTab;
    self.secondVC = [[CustomNavController alloc]initWithRootViewController:galleryVC];
    self.secondVC.navigationBar.barTintColor = [UIColor appYellowColor];
    
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    homeVC.view.backgroundColor = [UIColor appWhiteColor];
    homeVC.title = @"RSSchool Task 6";
    UITabBarItem *homeTab = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"home_unselected"] selectedImage:[UIImage imageNamed:@"home_selected"]];;
    homeVC.tabBarItem = homeTab;
    self.thirdVC = [[CustomNavController alloc]initWithRootViewController:homeVC];
    self.thirdVC.navigationBar.barTintColor = [UIColor appYellowColor];
    
    self.viewControllers = @[self.firstVC, self.secondVC, self.thirdVC];
    
    self.selectedIndex = 1;
}

@end
