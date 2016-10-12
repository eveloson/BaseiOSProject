//
//  WelcomeController.m
//  DashunClient
//
//  Created by lottak_mac2 on 16/9/27.
//  Copyright © 2016年 com.lottak. All rights reserved.
//

#import "WelcomeController.h"
#import "IdentityManager.h"

@interface WelcomeController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *imageScrollView;//滚动视图
@property (strong, nonatomic) UIButton *jumpBtn;//跳过

@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    //创建滚动视图
    NSArray<NSString*> *labelNameArr = @[@"大舜网络",@"诚心合作",@"遇见不一样的自己",@"原来你也可以这样"];
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    _imageScrollView.delegate = self;
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.bounces = NO;
    _imageScrollView.pagingEnabled = YES;
    for (int index = 0; index < labelNameArr.count; index ++) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(index * _imageScrollView.frame.size.width, 0, _imageScrollView.frame.size.width, _imageScrollView.frame.size.height)];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = labelNameArr[index];
        [_imageScrollView addSubview:nameLabel];
    }
    _imageScrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH * labelNameArr.count, MAIN_SCREEN_HEIGHT);
    [self.view addSubview:_imageScrollView];
    //创建跳过按钮
    _jumpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _jumpBtn.frame = CGRectMake(MAIN_SCREEN_WIDTH - 50 - 60, MAIN_SCREEN_HEIGHT - 30 - 60, 50, 30);
    [_jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [_jumpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_jumpBtn addTarget:self action:@selector(jumpClicked:) forControlEvents:UIControlEventTouchUpInside];
    _jumpBtn.hidden = YES;
    [self.view addSubview:_jumpBtn];
}
- (void)jumpClicked:(id)sender {
    IdentityManager *identityManager = [IdentityManager manager];
    identityManager.identity.firstUseSoft = NO;
    [identityManager saveAuthorizeData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WelcomeDidFinish" object:nil];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _jumpBtn.hidden = (scrollView.contentOffset.x / MAIN_SCREEN_WIDTH != 3);
}

@end
