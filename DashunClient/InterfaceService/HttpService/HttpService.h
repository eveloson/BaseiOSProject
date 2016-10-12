//
//  HttpService.h
//  DashunClient
//
//  Created by lottak_mac2 on 16/9/27.
//  Copyright © 2016年 com.lottak. All rights reserved.
//

#import <Foundation/Foundation.h>
//基础网络请求 其他的请求统一由此类发出

typedef NS_ENUM(NSUInteger, HTTP_REQUEST_METHOD) {
    E_HTTP_REQUEST_METHOD_GET = 0,
    E_HTTP_REQUEST_METHOD_HEAD,
    E_HTTP_REQUEST_METHOD_POST,
    E_HTTP_REQUEST_METHOD_PUT,
    E_HTTP_REQUEST_METHOD_PATCH,
    E_HTTP_REQUEST_METHOD_DELETE,
};

typedef void(^completionHandler)(id data,NSError *error);

@interface HttpService : NSObject

+ (HttpService*)service;
//普通请求
- (NSURLSessionDataTask *)sendRequestWithHttpMethod:(HTTP_REQUEST_METHOD)method URLPath:(NSString *)pathStr parameters:(id)parameters completionHandler:(completionHandler)completionHandler;

@end
