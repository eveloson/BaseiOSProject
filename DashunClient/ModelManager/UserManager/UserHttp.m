//
//  UserHttp.m
//  RealmDemo
//
//  Created by haigui on 16/7/2.
//  Copyright © 2016年 com.luohaifang. All rights reserved.
//

#import "UserHttp.h"
#import "UserManager.h"

@implementation UserHttp

#pragma mark -- 修改用户信息
//修改用户信息
+ (NSURLSessionDataTask*)updateUserInfo:(User*)user handler:(completionHandler)handler {
    NSString *urlPath = @"Users/update_user";
    NSMutableDictionary *params = [user.JSONDictionary mutableCopy];
    completionHandler compleionHandler = ^(id data,NSError *error) {
        handler(data,error);
    };
    return [[HttpService service] sendRequestWithHttpMethod:E_HTTP_REQUEST_METHOD_POST URLPath:urlPath parameters:params completionHandler:compleionHandler];
}

@end
