//
//  HttpHelper.m
//  
//
//  Created by Jason on 15-1-5.
//
//

#import "HttpHelper.h"
#define KIRS_http_initAuthCode @"20150209"
#define KSTS_http_initAuthCode @"20150212"
@implementation HttpHelper

#pragma mark- IRS. httpHelper
+ (AFHTTPRequestOperation *) getRequestSuccess:(void (^)(id resultObject))blockSuccess Failure:(void (^)(NSError *error))blockError{
    
    AFHTTPClient *httpClient = [AFHTTPClient sharedClientChangeURL:NO];
    // 设置验证码
    [httpClient.requestSerializer setValue:KIRS_http_initAuthCode forHTTPHeaderField:@"Authorization"];
    
    // API URL 地址
    return [httpClient GET:@"irs/api/getUsers" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"result : %@",responseObject);
            if (blockSuccess) {
                // 提取 data 中的数据作为 blocksuccess 参数
                blockSuccess([responseObject objectForKey:@"data"]);
            }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (blockError) {
            blockError(error);
        }
    }];

}

+ (AFHTTPRequestOperation *) postReqestWithPams:(NSMutableArray *)pams Success:(void (^)(id resultObject))blockSuccess Failure:(void (^)(NSError *error))blockError{
    
    AFHTTPClient *httpClient = [AFHTTPClient sharedClientChangeURL:NO];
    // 设置验证码
    [httpClient.requestSerializer setValue:KIRS_http_initAuthCode forHTTPHeaderField:@"Authorization"];
    // API URL 地址
    return [httpClient POST:@"irs/api/updateStatus" parameters:userBeacons success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"result : %@",responseObject);
        if (blockSuccess) {
            // 提取 data 中的数据作为 blocksuccess 参数
            blockSuccess([responseObject objectForKey:@"data"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (blockError) {
            blockError(error);
        }
    }];
}

@end
