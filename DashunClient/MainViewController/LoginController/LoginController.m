//
//  LoginController.m
//  DashunClient
//
//  Created by lottak_mac2 on 16/9/27.
//  Copyright © 2016年 com.lottak. All rights reserved.
//

#import "LoginController.h"
#import "UserLoginController.h"

@interface LoginController () {
    UINavigationController *_loginNavigationController;
}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginNavigationController = [[UINavigationController alloc] initWithRootViewController:[UserLoginController new]];
    [self addChildViewController:_loginNavigationController];
    [self.view addSubview:_loginNavigationController.view];
    // Do any additional setup after loading the view.
    
}

@end
