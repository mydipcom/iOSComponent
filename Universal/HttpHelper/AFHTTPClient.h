//
//  AFHTTPClient.h
//
//  依赖：AFNetworking
//
//  Created by Jason on 15-1-5.
//
//

#import "AFHTTPRequestOperationManager.h"

#define base_url @"http://192.168.10.58:8080/"


@interface AFHTTPClient : AFHTTPRequestOperationManager
+ (instancetype)sharedClient;
@end
