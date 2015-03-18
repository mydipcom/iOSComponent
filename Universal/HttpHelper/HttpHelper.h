//
//  HttpHelper.h
//  依赖：AFNetWorking, AFHTTPClient.h
//
//  Created by Jason on 15-1-5.
//
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
@interface HttpHelper : NSObject

// get request eg.
/**
 *  GET 请求 不带参数
 *
 *  @param blockSuccess
 *  @param blockError
 *
 *  @return
 */
+ (AFHTTPRequestOperation *) getRequestSuccess:(void (^)(id resultObject))blockSuccess Failure:(void (^)(NSError *error))blockError;


// post request eg.
/**
 *  POST 请求 带参数
 *
 *  @param pams         需要传递的参数
 *  @param blockSuccess
 *  @param blockError
 *
 *  @return
 */
+ (AFHTTPRequestOperation *) postReqestWithPams:(NSMutableArray *)pams Success:(void (^)(id resultObject))blockSuccess Failure:(void (^)(NSError *error))blockError;


@end
