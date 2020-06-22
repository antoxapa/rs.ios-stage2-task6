//
//  CustomNavController.m
//  Task 6
//
//  Created by Антон Потапчик on 6/21/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "CustomNavController.h"

@interface CustomNavController ()

@end

@implementation CustomNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    CGFloat height = 50;
    self.navigationBar.frame = CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height + height);
}

@end
