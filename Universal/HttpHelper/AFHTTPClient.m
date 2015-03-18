//
//  AFHTTPClient.m
//  OrderDishs
//
//  Created by CAMPRAY-MAC1 on 15-1-5.
//
//

#import "AFHTTPClient.h"

//static NSString * const AFAppClientAPIBaseURLString = BASE_URL;

@implementation AFHTTPClient

+ (instancetype)sharedClient{
    static AFHTTPClient *_sharedClient = nil;
            static dispatch_once_t onceToken;
            // 保证运行一次
            dispatch_once(&onceToken, ^{
    
                _sharedClient=[[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:base_url]];
                // 设置request 格式 JSON
                _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
                _sharedClient.requestSerializer.timeoutInterval = 30;
                // 设置response 格式 JSON
                _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
                // 设置请求头
                [_sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [_sharedClient.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                
                // 设置 监控 网络环境
                [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                    switch (status) {
                        case AFNetworkReachabilityStatusNotReachable:
                            NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                            //[[AppDelegate sharedAppDelegate] alterWhenNetBreak];
                            break;
                        default:
                            break;
                    }
                }];
                // 开启监控
                [_sharedClient.reachabilityManager startMonitoring];
                
        });
    

    
    
    return _sharedClient;
}
@end
