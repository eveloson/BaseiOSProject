//
//  IdentityHttp.h
//  RealmDemo
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 com.luohaifang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpService.h"

@interface IdentityHttp : NSObject

//系统账号密码登陆
+ (NSURLSessionDataTask*)loginWithEmail:(NSString*)account password:(NSString*)password handler:(completionHandler)handler;

@end
