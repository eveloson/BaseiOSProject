//
//  IdentityHttp.m
//  RealmDemo
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 com.luohaifang. All rights reserved.
//

#import "IdentityHttp.h"

@implementation IdentityHttp

//系统账号密码登陆
+ (NSURLSessionDataTask*)loginWithEmail:(NSString*)account password:(NSString*)password handler:(completionHandler)handler {
    NSString *urlPath = @"Users/login";
    id parameter = @{@"account":account,@"password":password};
    completionHandler compleionHandler = ^(id data,NSError *error) {
        handler(data,error);
    };
    return [[HttpService service] sendRequestWithHttpMethod:E_HTTP_REQUEST_METHOD_POST URLPath:urlPath parameters:parameter completionHandler:compleionHandler];
}

@end
