//
//  User.h
//  RealmDemo
//
//  Created by haigui on 16/7/2.
//  Copyright © 2016年 com.luohaifang. All rights reserved.
//


//当前用户
@interface User : RLMObject

@property (nonatomic, assign) int userNo;//用户编号
@property (nonatomic, strong) NSString *name;//用户名字

@end

