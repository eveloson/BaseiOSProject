//
//  UserLoginController.m
//  DashunClient
//
//  Created by lottak_mac2 on 16/9/27.
//  Copyright © 2016年 com.lottak. All rights reserved.
//

#import "UserLoginController.h"
#import "IdentityHttp.h"
#import "UserManager.h"
#import "IdentityManager.h"

@interface UserLoginController ()

@end

@implementation UserLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(loginClicked:)];
}
- (void)loginClicked:(UIBarButtonItem*)item {
//    [self.navigationController.view showLoadingTips:@""];
    //登录逻辑
//    [IdentityHttp loginWithEmail:@"" password:@"" handler:^(id data, NSError *error) {
//        [self.navigationController.view dismissTips];
//        if(error) {
//            [self.navigationController.view showFailureTips:error.domain];
//            return ;
//        }
        //存入用户管理器
        User *user = [User new];
//        [user mj_setKeyValues:data];
        user.userNo = 10;
        [[UserManager manager] updateUser:user];
        //记录登录信息
        [IdentityManager manager].identity.userNo = user.userNo;
        [[IdentityManager manager] saveAuthorizeData];
        //登录完成
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginDidFinish" object:nil];
//    }];
}

@end
