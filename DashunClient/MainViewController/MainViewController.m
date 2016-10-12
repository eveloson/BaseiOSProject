//
//  MainViewController.m
//  DashunClient
//
//  Created by lottak_mac2 on 16/9/27.
//  Copyright © 2016年 com.lottak. All rights reserved.
//

#import "MainViewController.h"
#import "BusinessController.h"
#import "LoginController.h"
#import "WelcomeController.h"

#import "IdentityManager.h"
#import "UserManager.h"

@interface MainViewController () {
    WelcomeController *_welcome;//欢迎界面
    LoginController *_login;//登录界面
    BusinessController *_business;//业务界面
    
    IdentityManager *_identityManager;//登录信息管理器
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additionalsetup after loading the view.
    _identityManager = [IdentityManager manager];
    [_identityManager readAuthorizeData];
    //保存当前的版本号
    _identityManager.identity.lastSoftVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [_identityManager saveAuthorizeData];
    //进入登录逻辑
    [self gotoIdentityVC];
    
    //加上欢迎界面和登录界面的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoIdentityVC) name:@"WelcomeDidFinish" object:nil];
    //加上重新登录的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoIdentityVC) name:@"ShowLogin" object:nil];
    //加上登录结束的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoIdentityVC) name:@"LoginDidFinish" object:nil];
}
//进入判断逻辑
- (void)gotoIdentityVC {
    //看用户是不是第一次使用软件
    if(_identityManager.identity.firstUseSoft == 1) {
        _welcome = [WelcomeController new];
        _welcome.view.alpha = 0;
        [self addChildViewController:_welcome];
        [self.view addSubview:_welcome.view];
        //如果是从业务界面进来
        if([self.childViewControllers containsObject:_business]) {
            [self transitionFromViewController:_business toViewController:_welcome duration:1 options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionCurveEaseInOut animations:^{
                _welcome.view.alpha = 1;
                _business.view.alpha = 0;
            } completion:^(BOOL finished) {
                [_business.view removeFromSuperview];
                [_business removeFromParentViewController];
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                _welcome.view.alpha = 1;
            }];
        }
        return;
    }
    //看用户是否登录
    if(_identityManager.identity.userNo == 0) {
        _login = [LoginController new];
        _login.view = 0;
        [self addChildViewController:_login];
        [self.view addSubview:_login.view];
        //如果是从欢迎界面进来
        if([self.childViewControllers containsObject:_welcome]) {
            [self transitionFromViewController:_welcome toViewController:_login duration:1 options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionCurveEaseInOut animations:^{
                _login.view.alpha = 1;
                _welcome.view.alpha = 0;
            } completion:^(BOOL finished) {
                [_welcome.view removeFromSuperview];
                [_welcome removeFromParentViewController];
            }];
        } else if([self.childViewControllers containsObject:_business]){//如果是从业务界面进来
            [self transitionFromViewController:_business toViewController:_login duration:1 options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionCurveEaseInOut animations:^{
                _login.view.alpha = 1;
                _business.view.alpha = 0;
            } completion:^(BOOL finished) {
                [_welcome.view removeFromSuperview];
                [_welcome removeFromParentViewController];
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                _login.view.alpha = 1;
            }];
        }
        return;
    }
    //已经登陆就加载登陆的用户信息
    [[UserManager manager] loadUserWithNo:_identityManager.identity.userNo];
    _business = [BusinessController new];
    _business.view.alpha = 0;
    [self addChildViewController:_business];
    [self.view addSubview:_business.view];
    //如果是从登录界面进来
    if([self.childViewControllers containsObject:_login]) {
        [self transitionFromViewController:_login toViewController:_business duration:1 options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionCurveEaseInOut animations:^{
            _business.view.alpha = 1;
            _login.view.alpha = 0;
        } completion:^(BOOL finished) {
            [_login.view removeFromSuperview];
            [_login removeFromParentViewController];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _business.view.alpha = 1;
        }];
    }
}

@end
